% Tập từ vựng
từ_vựng(rất_thích, 2).
từ_vựng(yêu, 2).
từ_vựng(đọc_sách, 2).
từ_vựng(học, 2).
từ_vựng(bố, 2).
từ_vựng(mẹ, 2).
từ_vựng(giáo_viên, 2).
từ_vựng(học, 2).
từ_vựng(học_giỏi, 2).
từ_vựng(hoc_sinh_giỏi, 2).
từ_vựng(ban_gái, 2).
từ_vựng(học_cùng_lớp, 2).
từ_vựng(yêu_qúy, 2).
từ_vựng(học_sinh, 1).
từ_vựng(giám_đốc, 1).
từ_vựng(nam, 0).
từ_vựng(hà_nội, 0).
từ_vựng(lớp_mười_hai, 0).
từ_vựng(đạt, 0).
từ_vựng(nhi, 0).
từ_vựng(môn_toán, 0).
từ_vựng(lớp, 0).
từ_vựng(thể_thao, 0).
từ_vựng(rất, 0).
từ_vựng(hoa, 0).
từ_vựng(hai_năm, 0).
từ_vựng(họ, 0).
từ_vựng(thư_viện, 0).
từ_vựng(hay, 0).
từ_vựng(lan, 0).

% Tập các phép toán

:-op(950,yfx,@).
:-op(925,yfx,x).
:-op(900,yfx,=>).
:-op(850,yfx,v).
:-op(800,yfx,&).
:-op(750,fx,~).

~BT1:-not(BT1).
BT1 & BT2:-BT1, BT2.
BT1 v BT2:-BT1; BT2.
BT1 => BT2:-not(BT1),!; BT2.
tồn_tại(X,BT1):-từ_vựng(X, 0),BT1,!.
với_mọi(X,BT1):- ~tồn_tại(X,~BT1).

% Mô hình bậc nhất

ở(nam, hà_nội).
bố(đạt, nam).
giám_đốc(đạt).
mẹ(nhi, nam).
giáo_viên(nhi, môn_toán).
học_giỏi(nam, môn_toán).
hoc_sinh_giỏi(nam, lớp).
rất_thích(nam, thể_thao).
ban_gái(hoa, nam).
yêu(hoa, nam).
yêu(nam, hoa).
đọc_sách(họ, thư_viện).
yêu_qúy(đạt, lan).
yêu_qúy(nhi, lan).
học_sinh(nam).
học_sinh(X) :- học(X, _), !.
học_cùng_lớp(hoa, nam).
học_cùng_lớp(nam, hoa).
học(nam, lớp_mười_hai).
học(X, Y) :- học_cùng_lớp(Z, X), học(Z, Y), !.
con(X, Y) :- mẹ(Y, X); bố(Y, X).

/* 3 phát biểu đơn giản chỉ gồm chủ từ, động từ, tân từ
+ Hoa là học_sinh.
+ mẹ nam sống hà_nội
+ hoa đang học lớp_mười_hai. */
prp(lambda(P, P@ họ)) --> [họ].

nnp(lambda(P, P@ nam)) --> [nam].
nnp(lambda(P, P@ lan)) --> [lan].
nnp(lambda(P, P@ hà_nội)) --> [hà, nội].
nnp(lambda(P, P@ đạt)) --> [đạt].
nnp(lambda(P, P@ nhi)) --> [nhi].
nnp(lambda(P, P@ hoa)) --> [hoa].

nn(lambda(P, P@ lớp)) --> [lớp].
nn(lambda(P, P@ lớp_mười_hai)) --> [lớp, mười, hai].
nn(lambda(P, P@ môn_toán)) --> [môn, toán].
nn(lambda(P, P@ thể_thao)) --> [thể, thao].
nn(lambda(P, P@ thư_viện)) --> [thư, viện].
nn(lambda(P, học_sinh(P))) --> [học, sinh].
nn(lambda(P, giám_đốc(P))) --> [giám, đốc].
nn(lambda(P,lambda(X, P@ lambda(Y, bố(X, Y))))) --> [bố].
nn(lambda(P,lambda(X, P@ lambda(Y, mẹ(X, Y))))) --> [mẹ].
nn(lambda(P,lambda(X, P@ lambda(Y, giáo_viên(X, Y))))) --> [giáo, viên].
nn(lambda(P,lambda(X, P@ lambda(Y, bạn_gái(X, Y))))) --> [bạn, gái].

in(lambda(P,lambda(X, P@ lambda(Y, ở(X, Y))))) --> [ở].

vb(_) --> [sống]; [là].
vb(lambda(P,lambda(X, P@ lambda(Y, học(X, Y))))) --> [học].
vb(lambda(P,lambda(X, P@ lambda(Y, học_giỏi(X, Y))))) --> [học, giỏi].
vb(lambda(P,lambda(X, P@ lambda(Y, học_sinh_giỏi(X, Y))))) --> [học, sinh, giỏi].
vb(lambda(P,lambda(X, P@ lambda(Y, rất_thích(X, Y))))) --> [rất, thích].
vb(lambda(P,lambda(X, P@ lambda(Y, yêu(X, Y))))) --> [yêu].
vb(lambda(P,lambda(X, P@ lambda(Y, học_cùng_lớp(X, Y))))) --> [học, cùng, lớp].
vb(lambda(P,lambda(X, P@ lambda(Y, đọc_sách(X, Y))))) --> [đọc, sách].
vb(lambda(P,lambda(X, P@ lambda(Y, yêu_qúy(X, Y))))) --> [yêu, qúy].

cc(lambda(P,lambda(Q, lambda(X, (P@ X) & (Q @ X))))) --> [và].
det(lambda(P, lambda(Q, tồn_tại(X, (P@ X) & (Q@ X))))) --> [một].
det(lambda(P, lambda(Q, với_mọi(X, (P@ X) => (Q@ X))))) --> [mọi];[tất,cả];[mỗi].

sen(X @ Y) --> np(X), vp(Y).
sen((NP @ X) & (VP @ X)) --> np2(NP), vp(VP).
np(X) --> nnp(X).
np(X) --> nn(X).
np2(X @ Y) --> nn(X), nnp(Y).
pp(Y @ Z) --> in(Y), np(Z).
vp(X) --> vb(_), pp(X).
vp(X) --> vb(_), np(X).

% Tính biểu thức lambda với vị từ beta
beta(A,KQ):- var(A),!,KQ=A.
beta(FP@ A,KQ):-
	compound(FP), beta(FP,KQ1), beta(A,A1),
	KQ1=lambda(X,F), 
	repl(A1,X,F,KQ2),!,beta(KQ2,KQ).
beta(F,KQ):-	
	F=..[H|T], beta_lst(T,KQ1),
	KQ=..[H|KQ1].

beta_lst([],[]).
beta_lst([F|A],[KQ|B]):-beta(F,KQ), beta_lst(A,B).
repl(A,X,F,A):- X==F.
repl(_,_,F,F):- not(compound(F)).
repl(A,X,F,KQ):-
	F=..[H|T], repl_lst(A,X,T,KQ1),!,
	KQ=..[H|KQ1].
repl_lst(_,_,[],[]).
repl_lst(A,X,[H1|T1],[H2|T2]):-
	repl(A,X,H1,H2), repl_lst(A,X,T1,T2).

% Hỏi đáp câu đúng/sai.
kiemtra(S):- sen(R,S,[]), beta(R,K), K.
% Tính ra ngữ nghĩa từ câu
cal(S, K) :- sen(R, S, []), beta(R, K).
calNP(NP, K) :- np(X, NP, []), beta(X, K).
calVP(VP, K) :- vp(X, VP, []), beta(X, K).