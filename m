Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262660AbVDHC2Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262660AbVDHC2Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 22:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262662AbVDHC2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 22:28:16 -0400
Received: from fmr21.intel.com ([143.183.121.13]:32222 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S262660AbVDHC1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 22:27:44 -0400
Message-Id: <200504080227.j382RWg11431@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Ingo Molnar'" <mingo@elte.hu>
Cc: "Paul Jackson" <pj@engr.sgi.com>, <torvalds@osdl.org>,
       <nickpiggin@yahoo.com.au>, <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>
Subject: RE: [patch] sched: auto-tune migration costs [was: Re: Industry db benchmark result on recent 2.6 kernels]
Date: Thu, 7 Apr 2005 19:27:32 -0700
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcU6dFSCNpQKWIdzR0iNjkaFixP66gBbeznQ
In-Reply-To: <20050406064550.GA6367@elte.hu>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote on Tuesday, April 05, 2005 11:46 PM
> ok, the delay of 16 secs is alot better. Could you send me the full
> detection log, how stable is the curve?

Full log attached.


begin 666 boot.log
M0F]O="!P<F]C97-S;W(@:60@,'@P+S!X8S0Q. I#4%4@,3H@<WEN8VAR;VYI
M>F5D($E40R!W:71H($-052 P("AL87-T(&1I9F8@,R!C>6-L97,L(&UA>&5R
M<B U-# @8WEC;&5S*0I#4%4@,3H@8F%S92!F<F5Q/3$Y.2XT-3E-2'HL($E4
M0R!R871I;STQ-2\R+"!)5$,@9G)E<3TQ-#DU+CDT-$U(>@I#86QI8G)A=&EN
M9R!D96QA>2!L;V]P+BXN(#(R-#$N,#@@0F]G;TU)4%,@*&QP:CTQ,#DS-C,R
M*0I#4%4@,CH@<WEN8VAR;VYI>F5D($E40R!W:71H($-052 P("AL87-T(&1I
M9F8@,R!C>6-L97,L(&UA>&5R<B U-# @8WEC;&5S*0I#4%4@,CH@8F%S92!F
M<F5Q/3$Y.2XT-3E-2'HL($E40R!R871I;STQ-2\R+"!)5$,@9G)E<3TQ-#DU
M+CDT-$U(>@I#86QI8G)A=&EN9R!D96QA>2!L;V]P+BXN(#(R-#$N,#@@0F]G
M;TU)4%,@*&QP:CTQ,#DS-C,R*0I#4%4@,SH@<WEN8VAR;VYI>F5D($E40R!W
M:71H($-052 P("AL87-T(&1I9F8@,R!C>6-L97,L(&UA>&5R<B U-# @8WEC
M;&5S*0I#4%4@,SH@8F%S92!F<F5Q/3$Y.2XT-3E-2'HL($E40R!R871I;STQ
M-2\R+"!)5$,@9G)E<3TQ-#DU+CDT-$U(>@I#86QI8G)A=&EN9R!D96QA>2!L
M;V]P+BXN(#(R-#$N,#@@0F]G;TU)4%,@*&QP:CTQ,#DS-C,R*0I"<F]U9VAT
M('5P(#0@0U!5<PI4;W1A;"!O9B T('!R;V-E<W-O<G,@86-T:79A=&5D("@X
M.38T+C,R($)O9V]-25!3*2X*0U!5,"!A='1A8VAI;F<@<V-H960M9&]M86EN
M.@H@9&]M86EN(# Z('-P86X@9@H@(&=R;W5P<SH@,2 R(#0@. I#4%4Q(&%T
M=&%C:&EN9R!S8VAE9"UD;VUA:6XZ"B!D;VUA:6X@,#H@<W!A;B!F"B @9W)O
M=7!S.B R(#0@." Q"D-053(@871T86-H:6YG('-C:&5D+61O;6%I;CH*(&1O
M;6%I;B P.B!S<&%N(&8*("!G<F]U<',Z(#0@." Q(#(*0U!5,R!A='1A8VAI
M;F<@<V-H960M9&]M86EN.@H@9&]M86EN(# Z('-P86X@9@H@(&=R;W5P<SH@
M." Q(#(@- I;,"T^,5TZ(" W,#<Y-C,P(" W,#<Y-C,P(" S,S(Y.#4P(#T^
M(" @,3 T,#DT.# N"ELP+3XQ73H@(#<P.#$T,C @(#<P.#$T,C @(#,S,S$W
M.3$@/3X@(" Q,#0Q,S(Q,2X*6S M/C%=.B @-S$W,#8U,R @-S$W,#8U,R @
M,S,T.#$Y.2 ]/B @(#$P-3$X.#4R+@I;,2T^,%TZ(" W,#<R-#$U(" W,#<R
M-#$U(" S,S,Q.#0T(#T^(" @,3 T,#0R-3DN"ELQ+3XP73H@(#<P-S8R,C@@
M(#<P-S8R,C@@(#,S,S W,S(@/3X@(" Q,#0P-CDV,"X*6S$M/C!=.B @-S$V
M-#$Q-" @-S$V-#$Q-" @,S,T.#$Q,R ]/B @(#$P-3$R,C(W+@I;,"T^,%TZ
M(" W,#<W,3$W(" W,#<W,3$W(" @.30R,38Q(#T^(" @(#@P,3DR-S@N"ELP
M+3XP73H@(#<P-S0Y-C(@(#<P-S0Y-C(@(" Y-#(R,C$@/3X@(" @.# Q-S$X
M,RX*6S M/C!=.B @-S$W,#(Y-R @-S$W,#(Y-R @(#DS.34S," ]/B @(" X
M,3 Y.#(W+@I;,2T^,5TZ(" W,#<V,#4T(" W,#<V,#4T(" @.30R,CDR(#T^
M(" @(#@P,3@S-#8N"ELQ+3XQ73H@(#<P-S U,S<@(#<P-S U,S<@(" Y-#$T
M-S@@/3X@(" @.# Q,C Q-2X*6S$M/C%=.B @-S$V,34Y,B @-S$V,34Y,B @
M(#DS.#<V." ]/B @(" X,3 P,S8P+@HM/B!;,%U;,5U;-#<Q.#4Y,ET@(" R
M+C0@6R @,BXT72 H,"DZ("@@,C0P,CDV-B @,3(P,30X,RD*6S M/C%=.B @
M-S4S,S(P," @-S4S,S(P," @,S4R,C$T-2 ]/B @(#$Q,#4U,S0U+@I;,"T^
M,5TZ(" W-3,Q-3,V(" W-3,Q-3,V(" S-3(T,#DV(#T^(" @,3$P-34V,S(N
M"ELP+3XQ73H@(#<T-#$Q.#(@(#<T-#$Q.#(@(#,U,#,S.3@@/3X@(" Q,#DT
M-#4X,"X*6S$M/C!=.B @-S4R,S<Q,2 @-S4R,S<Q,2 @,S4R-S4Y-" ]/B @
M(#$Q,#4Q,S U+@I;,2T^,%TZ(" W-3(V,S0P(" W-3(V,S0P(" S-3(V-C,W
M(#T^(" @,3$P-3(Y-S<N"ELQ+3XP73H@(#<T,SDU.3<@(#<T,SDU.3<@(#,U
M,#0S,C8@/3X@(" Q,#DT,SDR,RX*6S M/C!=.B @-S4S,#@X,R @-S4S,#@X
M,R @(#DX.#(Q-2 ]/B @(" X-3$Y,#DX+@I;,"T^,%TZ(" W-3,Q-C$U(" W
M-3,Q-C$U(" @.3@W-C,S(#T^(" @(#@U,3DR-#@N"ELP+3XP73H@(#<T,SDS
M,C8@(#<T,SDS,C8@(" Y.3 W,S@@/3X@(" @.#0S,# V-"X*6S$M/C%=.B @
M-S4R.#4W-R @-S4R.#4W-R @(#DX-SDW,2 ]/B @(" X-3$V-30X+@I;,2T^
M,5TZ(" W-3(T-#@S(" W-3(T-#@S(" @.3@W-S$Q(#T^(" @(#@U,3(Q.30N
M"ELQ+3XQ73H@(#<T,S(V-S<@(#<T,S(V-S<@(" Y.#DW-CD@/3X@(" @.#0R
M,C0T-BX*+3X@6S!=6S%=6S0Y-C8Y,SA=(" @,BXU(%L@(#(N-5T@*# I.B H
M(#(U,C@R.3 @(" V-C,T,#,I"ELP+3XQ73H@(#<X-SDQ.#<@(#<X-SDQ.#<@
M(#,W,#DP,C @/3X@(" Q,34X.#(P-RX*6S M/C%=.B @-S@W-S8V-" @-S@W
M-S8V-" @,S<P-SDQ,2 ]/B @(#$Q-3@U-3<U+@I;,"T^,5TZ(" W.3(T.34Q
M(" W.3(T.34Q(" S-C@W,#$U(#T^(" @,3$V,3$Y-C8N"ELQ+3XP73H@(#<X
M-S$P-3,@(#<X-S$P-3,@(#,W,30P,S(@/3X@(" Q,34X-3 X-2X*6S$M/C!=
M.B @-S@W,3DP-R @-S@W,3DP-R @,S<Q-# W,B ]/B @(#$Q-3@U.3<Y+@I;
M,2T^,%TZ(" W.3(P-#DY(" W.3(P-#DY(" S-CDQ.30S(#T^(" @,3$V,3(T
M-#(N"ELP+3XP73H@(#<X-S4Y.3@@(#<X-S4Y.3@@(#$P-# R-#@@/3X@(" @
M.#DQ-C(T-BX*6S M/C!=.B @-S@W-C0U," @-S@W-C0U," @,3 T,# T." ]
M/B @(" X.3$V-#DX+@I;,"T^,%TZ(" W.3(Q-S$Q(" W.3(Q-S$Q(" Q,#0S
M,C S(#T^(" @(#@Y-C0Y,30N"ELQ+3XQ73H@(#<X-S(R.#@@(#<X-S(R.#@@
M(#$P-# P,3(@/3X@(" @.#DQ,C,P,"X*6S$M/C%=.B @-S@V.3@U.2 @-S@V
M.3@U.2 @,3 S.38X,B ]/B @(" X.3 Y-30Q+@I;,2T^,5TZ(" W.3$W,#@W
M(" W.3$W,#@W(" Q,#0R.#8W(#T^(" @(#@Y-3DY-30N"BT^(%LP75LQ75LU
M,C(X,S4U72 @(#(N-B!;(" R+C9=("@P*3H@*" R-C8Q,C8T(" @,SDX,3@X
M*0I;,"T^,5TZ(" X,C8P-CDR(" X,C8P-CDR(" S.#@R.3<W(#T^(" @,3(Q
M-#,V-CDN"ELP+3XQ73H@(#@R-3<X,#0@(#@R-3<X,#0@(#,X.#,T,30@/3X@
M(" Q,C$T,3(Q."X*6S M/C%=.B @.#0R-CDS,2 @.#0R-CDS,2 @,SDP,S,V
M-R ]/B @(#$R,S,P,CDX+@I;,2T^,%TZ(" X,C4Q,C8T(" X,C4Q,C8T(" S
M.#@W,#<S(#T^(" @,3(Q,S@S,S<N"ELQ+3XP73H@(#@R-3$X,S@@(#@R-3$X
M,S@@(#,X.#8T-3(@/3X@(" Q,C$S.#(Y,"X*6S$M/C!=.B @.#0Q.3,U," @
M.#0Q.3,U," @,SDP-3<Q-R ]/B @(#$R,S(U,#8W+@I;,"T^,%TZ(" X,C4X
M.#@W(" X,C4X.#@W(" Q,#DW,#(Y(#T^(" @(#DS-34Y,38N"ELP+3XP73H@
M(#@R-3,V,S,@(#@R-3,V,S,@(#$Q,# R-C$@/3X@(" @.3,U,S@Y-"X*6S M
M/C!=.B @.#0R-#8X-R @.#0R-#8X-R @,3 Y,SDX,B ]/B @(" Y-3$X-C8Y
M+@I;,2T^,5TZ(" X,C4T-30U(" X,C4T-30U(" Q,#DU.#$T(#T^(" @(#DS
M-3 S-3DN"ELQ+3XQ73H@(#@R-#DT,34@(#@R-#DT,34@(#$P.38V,3@@/3X@
M(" @.3,T-C S,RX*6S$M/C%=.B @.#0Q.#@S,2 @.#0Q.#@S,2 @,3 Y,S8Y
M-" ]/B @(" Y-3$R-3(U+@HM/B!;,%U;,5U;-34P,S4S,5T@(" R+C@@6R @
M,BXX72 H,"DZ("@@,C@P,#DS." @(#(V.#DS,2D*6S M/C%=.B @.#@V,#(R
M-R @.#@V,#(R-R @-#$P.3DT-" ]/B @(#$R.3<P,3<Q+@I;,"T^,5TZ(" X
M.#4X-3,W(" X.#4X-3,W(" T,3$P-S V(#T^(" @,3(Y-CDR-#,N"ELP+3XQ
M73H@(#@W-S4S,#,@(#@W-S4S,#,@(#0P.#<Q.3,@/3X@(" Q,C@V,C0Y-BX*
M6S$M/C!=.B @.#@U,#(S-R @.#@U,#(S-R @-#$Q,S0X-R ]/B @(#$R.38S
M-S(T+@I;,2T^,%TZ(" X.#4R,C0T(" X.#4R,C0T(" T,3$R,S,Y(#T^(" @
M,3(Y-C0U.#,N"ELQ+3XP73H@(#@W-C@U-#0@(#@W-C@U-#0@(#0P.3 R-#8@
M/3X@(" Q,C@U.#<Y,"X*6S M/C!=.B @.#@U-CDW-B @.#@U-CDW-B @,3$U
M,C8Q," ]/B @(#$P,# Y-3@V+@I;,"T^,%TZ(" X.#4T-C4P(" X.#4T-C4P
M(" Q,34T.3(Y(#T^(" @,3 P,#DU-SDN"ELP+3XP73H@(#@W-S0S,S @(#@W
M-S0S,S @(#$Q-30V,38@/3X@(" @.3DR.#DT-BX*6S$M/C%=.B @.#@U,3<V
M,R @.#@U,3<V,R @,3$U,3,W-B ]/B @(#$P,# S,3,Y+@I;,2T^,5TZ(" X
M.#4P-#,X(" X.#4P-#,X(" Q,34P.3,X(#T^(" @,3 P,#$S-S8N"ELQ+3XQ
M73H@(#@W-C8X-C$@(#@W-C8X-C$@(#$Q-30U,#8@/3X@(" @.3DR,3,V-RX*
M+3X@6S!=6S%=6S4W.3,Q.3!=(" @,BXY(%L@(#(N.5T@*# I.B H(#(Y-#@T
M-C$@(" R,#@R,C<I"ELP+3XQ73H@(#DS,S@V-# @(#DS,S@V-# @(#0S,C8T
M,#@@/3X@(" Q,S8V-3 T."X*6S M/C%=.B @.3,S.#DP,2 @.3,S.#DP,2 @
M-#,R-S0R,2 ]/B @(#$S-C8V,S(R+@I;,"T^,5TZ(" Y,C0X-3DS(" Y,C0X
M-3DS(" T,S Q-C@Y(#T^(" @,3,U-3 R.#(N"ELQ+3XP73H@(#DS,C@W-C @
M(#DS,C@W-C @(#0S,C<V-S4@/3X@(" Q,S8U-C0S-2X*6S$M/C!=.B @.3,S
M,# U-B @.3,S,# U-B @-#,S,#,U-" ]/B @(#$S-C8P-#$P+@I;,2T^,%TZ
M(" Y,C,Y,#DW(" Y,C,Y,#DW(" T,S V,CDP(#T^(" @,3,U-#4S.#<N"ELP
M+3XP73H@(#DS,S0Y,#D@(#DS,S0Y,#D@(#$R,3(S.30@/3X@(" Q,#4T-S,P
M,RX*6S M/C!=.B @.3,S-C,U,R @.3,S-C,U,R @,3(Q,3DR,2 ]/B @(#$P
M-30X,C<T+@I;,"T^,%TZ(" Y,C0V,#0X(" Y,C0V,#0X(" Q,C$U,C U(#T^
M(" @,3 T-C$R-3,N"ELQ+3XQ73H@(#DS,S(T.3(@(#DS,S(T.3(@(#$R,3$S
M-S8@/3X@(" Q,#4T,S@V."X*6S$M/C%=.B @.3,S,38Q." @.3,S,38Q." @
M,3(Q,3$T-B ]/B @(#$P-30R-S8T+@I;,2T^,5TZ(" Y,C,W.#(Q(" Y,C,W
M.#(Q(" Q,C$U,#0V(#T^(" @,3 T-3(X-C<N"BT^(%LP75LQ75LV,#DX,#DT
M72 @(#,N,2!;(" S+C%=("@P*3H@*" S,3 T,S$Q(" @,3@R,#,X*0I;,"T^
M,5TZ(" Y-S4V-#0U(" Y-S4V-#0U(" T-34S-38R(#T^(" @,30S,3 P,#<N
M"ELP+3XQ73H@(#DW-38P-C0@(#DW-38P-C0@(#0U-3,X.3,@/3X@(" Q-#,P
M.3DU-RX*6S M/C%=.B @.38U-S$R-2 @.38U-S$R-2 @-#4U,S$V-B ]/B @
M(#$T,C$P,CDQ+@I;,2T^,%TZ(" Y-S0V.38Q(" Y-S0V.38Q(" T-34W,S(V
M(#T^(" @,30S,#0R.#<N"ELQ+3XP73H@(#DW-#DT,3 @(#DW-#DT,3 @(#0U
M-30V-C4@/3X@(" Q-#,P-# W-2X*6S$M/C!=.B @.38U,#DV,2 @.38U,#DV
M,2 @-#4U-C<Q-B ]/B @(#$T,C W-C<W+@I;,"T^,%TZ(" Y-S4S-S4X(" Y
M-S4S-S4X(" Q,C<Y,#<P(#T^(" @,3$P,S(X,C@N"ELP+3XP73H@(#DW-34R
M,3(@(#DW-34R,3(@(#$R-S8U.30@/3X@(" Q,3 S,3@P-BX*6S M/C!=.B @
M.38U.3(R," @.38U.3(R," @,3(W-3DY." ]/B @(#$P.3,U,C$X+@I;,2T^
M,5TZ(" Y-S4P,# R(" Y-S4P,# R(" Q,C<V,C0V(#T^(" @,3$P,C8R-#@N
M"ELQ+3XQ73H@(#DW-#<U.#D@(#DW-#<U.#D@(#$R-S4X-3D@/3X@(" Q,3 R
M,S0T."X*6S$M/C%=.B @.38T-S(T-2 @.38T-S(T-2 @,3(W-C,U," ]/B @
M(#$P.3(S-3DU+@HM/B!;,%U;,5U;-C0Q.3 T-ET@(" S+C(@6R @,RXR72 H
M,"DZ("@@,S(W.30X-" @(#$W.#8P-2D*6S M/C%=.B Q,#$R,SDU-R Q,#$R
M,SDU-R @-#<V.#$R-R ]/B @(#$T.#DR,#@T+@I;,"T^,5TZ(#$P,3(R,34R
M(#$P,3(R,34R(" T-S8W-C0U(#T^(" @,30X.#DW.3<N"ELP+3XQ73H@,3 S
M,C@Q-3<@,3 S,C@Q-3<@(#0W.3(V,S$@/3X@(" Q-3$R,#<X."X*6S$M/C!=
M.B Q,#$Q,S0V-B Q,#$Q,S0V-B @-#<W,3DW," ]/B @(#$T.#@U-#,V+@I;
M,2T^,%TZ(#$P,3$W-#@X(#$P,3$W-#@X(" T-S8X-S$W(#T^(" @,30X.#8R
M,#4N"ELQ+3XP73H@,3 S,C$X-CD@,3 S,C$X-CD@(#0W.30U.3$@/3X@(" Q
M-3$Q-C0V,"X*6S M/C!=.B Q,#$R,#DY." Q,#$R,#DY." @,3,T.3(R-" ]
M/B @(#$Q-#<P,C(R+@I;,"T^,%TZ(#$P,3(T,S8W(#$P,3(T,S8W(" Q,S0Y
M,3$S(#T^(" @,3$T-S,T.# N"ELP+3XP73H@,3 S,C@Q.#(@,3 S,C@Q.#(@
M(#$S-#,V-C4@/3X@(" Q,38W,3@T-RX*6S$M/C%=.B Q,#$Q.# T.2 Q,#$Q
M.# T.2 @,3,T-3@R,2 ]/B @(#$Q-#8S.#<P+@I;,2T^,5TZ(#$P,3$T-C(X
M(#$P,3$T-C(X(" Q,S0U-#4P(#T^(" @,3$T-C P-S@N"ELQ+3XQ73H@,3 S
M,C$Q-38@,3 S,C$Q-38@(#$S-#0X.3 @/3X@(" Q,38V-C T-BX*+3X@6S!=
M6S%=6S8W-38X.3!=(" @,RXT(%L@(#,N-%T@*# I.B H(#,T,S4T-3 @(" Q
M-C<R.#4I"ELP+3XQ73H@,3 W-S$U-3,@,3 W-S$U-3,@(#4P,3@T,#D@/3X@
M(" Q-3<X.3DV,BX*6S M/C%=.B Q,#<W,3(X,B Q,#<W,3(X,B @-3 Q.#0T
M-" ]/B @(#$U-S@Y-S(V+@I;,"T^,5TZ(#$P-S$U,C4R(#$P-S$U,C4R(" U
M,#0T-S8Q(#T^(" @,34W-C P,3,N"ELQ+3XP73H@,3 W-3DX.#D@,3 W-3DX
M.#D@(#4P,C$V-S8@/3X@(" Q-3<X,34V-2X*6S$M/C!=.B Q,#<V-#8Y-" Q
M,#<V-#8Y-" @-3 R,3$Q," ]/B @(#$U-S@U.# T+@I;,2T^,%TZ(#$P-S V
M-3@R(#$P-S V-3@R(" U,#0W.#$W(#T^(" @,34W-30S.3DN"ELP+3XP73H@
M,3 W-C<X,3,@,3 W-C<X,3,@(#$T,3DY-C$@/3X@(" Q,C$X-S<W-"X*6S M
M/C!=.B Q,#<V-S,Q,B Q,#<V-S,Q,B @,30Q.3@Y,R ]/B @(#$R,3@W,C U
M+@I;,"T^,%TZ(#$P-S$Q.#DR(#$P-S$Q.#DR(" Q-#$V-C@X(#T^(" @,3(Q
M,C@U.# N"ELQ+3XQ73H@,3 W-C0P.3,@,3 W-C0P.3,@(#$T,3@X,3@@/3X@
M(" Q,C$X,CDQ,2X*6S$M/C%=.B Q,#<V,3 X,R Q,#<V,3 X,R @,30Q-C,R
M-R ]/B @(#$R,3<W-#$P+@I;,2T^,5TZ(#$P-S U-S0T(#$P-S U-S0T(" Q
M-#$S,C S(#T^(" @,3(Q,3@Y-#<N"BT^(%LP75LQ75LW,3$R-3$U72 @(#,N
M-B!;(" S+C9=("@P*3H@*" S-C$Y-#4P(" @,3<U-C0R*0I;,"T^,5TZ(#$Q
M,C$W.#<X(#$Q,C$W.#<X(" U,C@S-3$X(#T^(" @,38U,#$S.38N"ELP+3XQ
M73H@,3$R,3<P-34@,3$R,3<P-34@(#4R.#$X-#D@/3X@(" Q-C0Y.#DP-"X*
M6S M/C%=.B Q,3,X,38X-" Q,3,X,38X-" @-3,P.38V,2 ]/B @(#$V-CDQ
M,S0U+@I;,2T^,%TZ(#$Q,C V,C4T(#$Q,C V,C4T(" U,C@X-S(Q(#T^(" @
M,38T.30Y-S4N"ELQ+3XP73H@,3$R,#DW-#4@,3$R,#DW-#4@(#4R.#4S-#<@
M/3X@(" Q-C0Y-3 Y,BX*6S$M/C!=.B Q,3,V-S0Y-2 Q,3,V-S0Y-2 @-3,Q
M-34T-R ]/B @(#$V-C@S,#0R+@I;,"T^,%TZ(#$Q,C$T,C4X(#$Q,C$T,C4X
M(" Q-#DT-S<X(#T^(" @,3(W,#DP,S8N"ELP+3XP73H@,3$R,3DP-# @,3$R
M,3DP-# @(#$T.3(Q-S<@/3X@(" Q,C<Q,3(Q-RX*6S M/C!=.B Q,3,W-S@V
M-R Q,3,W-S@V-R @,30Y,3 U,2 ]/B @(#$R.#8X.3$X+@I;,2T^,5TZ(#$Q
M,C Y,S,T(#$Q,C Y,S,T(" Q-#DP.3,P(#T^(" @,3(W,# R-C0N"ELQ+3XQ
M73H@,3$R,#<R-S8@,3$R,#<R-S8@(#$T.3(X-#@@/3X@(" Q,C<P,#$R-"X*
M6S$M/C%=.B Q,3,V-S4T,R Q,3,V-S4T,R @,30X.3DU,B ]/B @(#$R.#4W
M-#DU+@HM/B!;,%U;,5U;-S0X-C@U-UT@(" S+C@@6R @,RXX72 H,"DZ("@@
M,S@P-S8U-R @(#$X,3DR-"D*6S M/C%=.B Q,3DS-C4V,R Q,3DS-C4V,R @
M-34V,#@X-2 ]/B @(#$W-#DW-#0X+@I;,"T^,5TZ(#$Q.3,U,C(Y(#$Q.3,U
M,C(Y(" U-38Q,3@Q(#T^(" @,3<T.38T,3 N"ELP+3XQ73H@,3$X-S(Q-34@
M,3$X-S(Q-34@(#4U.#8Y,3@@/3X@(" Q-S0U.3 W,RX*6S$M/C!=.B Q,3DR
M,C$R,B Q,3DR,C$R,B @-34V-38U,B ]/B @(#$W-#@W-S<T+@I;,2T^,%TZ
M(#$Q.3(V,C U(#$Q.3(V,C U(" U-38W,C@W(#T^(" @,3<T.3,T.3(N"ELQ
M+3XP73H@,3$X-C$U-S$@,3$X-C$U-S$@(#4U.3$P-S@@/3X@(" Q-S0U,C8T
M.2X*6S M/C!=.B Q,3DS,C<U,B Q,3DS,C<U,B @,34W,C8V.2 ]/B @(#$S
M-3 U-#(Q+@I;,"T^,%TZ(#$Q.3,S-3(T(#$Q.3,S-3(T(" Q-3<P,C<T(#T^
M(" @,3,U,#,W.3@N"ELP+3XP73H@,3$X-S(X.3,@,3$X-S(X.3,@(#$U-CDQ
M-S$@/3X@(" Q,S0T,C V-"X*6S$M/C%=.B Q,3DR-#DU,2 Q,3DR-#DU,2 @
M,34W,3,V-B ]/B @(#$S-#DV,S$W+@I;,2T^,5TZ(#$Q.3(T-S Y(#$Q.3(T
M-S Y(" Q-38Y,3@U(#T^(" @,3,T.3,X.30N"ELQ+3XQ73H@,3$X-3DX,S4@
M,3$X-3DX,S4@(#$U-C<P.#4@/3X@(" Q,S0R-CDR,"X*+3X@6S!=6S%=6S<X
M.# Y,#)=(" @-"XP(%L@(#0N,%T@*# I.B H(#0P,#@W,S<@(" Q.3$U,#(I
M"ELP+3XQ73H@,3(U.3DV-#D@,3(U.3DV-#D@(#4X.#0Y,S,@/3X@(" Q.#0X
M-#4X,BX*6S M/C%=.B Q,C4Y.#(Q-2 Q,C4Y.#(Q-2 @-3@X,S4S," ]/B @
M(#$X-#@Q-S0U+@I;,"T^,5TZ(#$R-3DR-S Q(#$R-3DR-S Q(" U.#@V,#(S
M(#T^(" @,3@T-S@W,C0N"ELQ+3XP73H@,3(U.#8X-C$@,3(U.#8X-C$@(#4X
M.#<Y-C4@/3X@(" Q.#0W-#@R-BX*6S$M/C!=.B Q,C4Y,38U-R Q,C4Y,38U
M-R @-3@X-S<S,2 ]/B @(#$X-#<Y,S@X+@I;,2T^,%TZ(#$R-3@R-#0S(#$R
M-3@R-#0S(" U.#@Y,S Q(#T^(" @,3@T-S$W-#0N"ELP+3XP73H@,3(U.38R
M-SD@,3(U.38R-SD@(#$V-3(V-#8@/3X@(" Q-#(T.#DR-2X*6S M/C!=.B Q
M,C4Y-C<U,B Q,C4Y-C<U,B @,38U,34Q." ]/B @(#$T,C0X,C<P+@I;,"T^
M,%TZ(#$R-3DP,SDU(#$R-3DP,SDU(" Q-C0W,3$V(#T^(" @,30R,S<U,3$N
M"ELQ+3XQ73H@,3(U.3 R.3,@,3(U.3 R.3,@(#$V-#<Y.#$@/3X@(" Q-#(S
M.#(W-"X*6S$M/C%=.B Q,C4X-C0S,2 Q,C4X-C0S,2 @,38U,#4P,B ]/B @
M(#$T,C,V.3,S+@I;,2T^,5TZ(#$R-3<V-C,U(#$R-3<V-C,U(" Q-C0Y,CDR
M(#T^(" @,30R,C4Y,C<N"BT^(%LP75LQ75LX,CDU-C@V72 @(#0N,B!;(" T
M+C)=("@P*3H@*" T,C0P-S0P(" @,C$Q-S4R*0I;,"T^,5TZ(#$S,C<U,C0Y
M(#$S,C<U,C0Y(" V,3DU-#@V(#T^(" @,3DT-S W,S4N"ELP+3XQ73H@,3,R
M-S$T,C@@,3,R-S$T,C@@(#8Q.34W-C@@/3X@(" Q.30V-S$Y-BX*6S M/C%=
M.B Q,S(S-S0Q-B Q,S(S-S0Q-B @-C$Y,3$X-B ]/B @(#$Y-#(X-C R+@I;
M,2T^,%TZ(#$S,C8P-3(V(#$S,C8P-3(V(" V,3DW,C0U(#T^(" @,3DT-3<W
M-S$N"ELQ+3XP73H@,3,R-C0X.#D@,3,R-C0X.#D@(#8Q.3<R-C$@/3X@(" Q
M.30V,C$U,"X*6S$M/C!=.B Q,S(R.30R." Q,S(R.30R." @-C$Y-38X,R ]
M/B @(#$Y-#(U,3$Q+@I;,"T^,%TZ(#$S,C<P,3@P(#$S,C<P,3@P(" Q-S,W
M.#8R(#T^(" @,34P,#@P-#(N"ELP+3XP73H@,3,R-CDR-#<@,3,R-CDR-#<@
M(#$W,S0V-S@@/3X@(" Q-3 P,SDR-2X*6S M/C!=.B Q,S(S-C0W,B Q,S(S
M-C0W,B @,3<S-SDX-B ]/B @(#$T.3<T-#4X+@I;,2T^,5TZ(#$S,C8T.#8Y
M(#$S,C8T.#8Y(" Q-S,V.3$R(#T^(" @,34P,#$W.#$N"ELQ+3XQ73H@,3,R
M-3DY,# @,3,R-3DY,# @(#$W,S8W.3D@/3X@(" Q-#DY-C8Y.2X*6S$M/C%=
M.B Q,S(R-#<S.2 Q,S(R-#<S.2 @,3<S-C8T-2 ]/B @(#$T.38Q,S@T+@HM
M/B!;,%U;,5U;.#<S,C,P,5T@(" T+C0@6R @-"XT72 H,"DZ("@@-#0V,38T
M." @(#(Q-C,S,"D*6S M/C%=.B Q,S@Y.#@U,2 Q,S@Y.#@U,2 @-C0X.3 R
M.2 ]/B @(#(P,S@W.#@P+@I;,"T^,5TZ(#$S.#DV,C<V(#$S.#DV,C<V(" V
M-#@Y,3,Y(#T^(" @,C S.#4T,34N"ELP+3XQ73H@,3,X,S0Y,#@@,3,X,S0Y
M,#@@(#8U,3@X.3@@/3X@(" R,#,U,S@P-BX*6S$M/C!=.B Q,S@X,C$P-2 Q
M,S@X,C$P-2 @-C0Y,# Q," ]/B @(#(P,S<R,3$U+@I;,2T^,%TZ(#$S.#@S
M-S(R(#$S.#@S-S(R(" V-#DP,SDR(#T^(" @,C S-S0Q,30N"ELQ+3XP73H@
M,3,X,C0X,# @,3,X,C0X,# @(#8U,C0Y.3@@/3X@(" R,#,T.3<Y."X*6S M
M/C!=.B Q,S@Y,3@Y-" Q,S@Y,3@Y-" @,3@T.#<Y,R ]/B @(#$U-S0P-C@W
M+@I;,"T^,%TZ(#$S.#DS,S0W(#$S.#DS,S0W(" Q.#0X-S<W(#T^(" @,34W
M-#(Q,C0N"ELP+3XP73H@,3,X,S T.38@,3,X,S T.38@(#$X-#0U-C<@/3X@
M(" Q-38W-3 V,RX*6S$M/C%=.B Q,S@X-S,P,2 Q,S@X-S,P,2 @,3@T-#0X
M-B ]/B @(#$U-S,Q-S@W+@I;,2T^,5TZ(#$S.#@Q-S8T(#$S.#@Q-S8T(" Q
M.#0T-#0Y(#T^(" @,34W,C8R,3,N"ELQ+3XQ73H@,3,X,3DV-C0@,3,X,3DV
M-C0@(#$X,SDP-S4@/3X@(" Q-38U.#<S.2X*+3X@6S!=6S%=6SDQ.3$X.35=
M(" @-"XV(%L@(#0N-ET@*# I.B H(#0V-C4R-#D@(" R,#DY-C4I"ELP+3XQ
M73H@,30U,# P-#$@,30U,# P-#$@(#8X-#(W-CD@/3X@(" R,3,T,C@Q,"X*
M6S M/C%=.B Q-#0Y-S<Y,2 Q-#0Y-S<Y,2 @-C@T,C8P.2 ]/B @(#(Q,S0P
M-# P+@I;,"T^,5TZ(#$T-SDS,C,R(#$T-SDS,C,R(" V.#<Y.3 W(#T^(" @
M,C$V-S,Q,SDN"ELQ+3XP73H@,30T.#(V-#<@,30T.#(V-#<@(#8X-#4X,3$@
M/3X@(" R,3,R.#0U."X*6S$M/C!=.B Q-#0X-38Y-R Q-#0X-38Y-R @-C@T
M-C4X.2 ]/B @(#(Q,S,R,C@V+@I;,2T^,%TZ(#$T-S@P,S W(#$T-S@P,S W
M(" V.#@S-C,W(#T^(" @,C$V-C,Y-#0N"ELP+3XP73H@,30T.3$W,S,@,30T
M.3$W,S,@(#(S,S(V-C0@/3X@(" Q-C@R-#,Y-RX*6S M/C!=.B Q-#0Y-CDW
M." Q-#0Y-CDW." @,C,S,C$P," ]/B @(#$V.#(Y,#<X+@I;,"T^,%TZ(#$T
M-SDP,# S(#$T-SDP,# S(" R,S,R-#,S(#T^(" @,3<Q,C(T,S8N"ELQ+3XQ
M73H@,30T.#<S.#(@,30T.#<S.#(@(#(S,C$X-#@@/3X@(" Q-C@P.3(S,"X*
M6S$M/C%=.B Q-#0X,CDT." Q-#0X,CDT." @,C,S,#$Y." ]/B @(#$V.#$S
M,30V+@I;,2T^,5TZ(#$T-S<Y,#,R(#$T-S<Y,#,R(" R,S,S-#(W(#T^(" @
M,3<Q,3(T-3DN"BT^(%LP75LQ75LY-C<U-C<X72 @(#0N-2!;(" T+C9=("@P
M*3H@*" T-3,S,38S(" @,3<Q,#(U*0I;,"T^,5TZ(#$U-# P,3$R(#$U-# P
M,3$R(" W,C8R-3<T(#T^(" @,C(V-C(V.#8N"ELP+3XQ73H@,34T,#4S,#$@
M,34T,#4S,#$@(#<R-38P,#8@/3X@(" R,C8V,3,P-RX*6S M/C%=.B Q-3,S
M,38T,B Q-3,S,38T,B @-S(X,C4S-R ]/B @(#(R-C$T,3<Y+@I;,2T^,%TZ
M(#$U,S@T,C@R(#$U,S@T,C@R(" W,C8U-3@Q(#T^(" @,C(V-#DX-C,N"ELQ
M+3XP73H@,34S.3 Y-C(@,34S.3 Y-C(@(#<R-C P,S@@/3X@(" R,C8U,3 P
M,"X*6S$M/C!=.B Q-3,Q.#<S-B Q-3,Q.#<S-B @-S(Y-# X,2 ]/B @(#(R
M-C$R.#$W+@I;,"T^,%TZ(#$U-# Q,3DY(#$U-# Q,3DY(" S-34V.3<W(#T^
M(" @,3@Y-3@Q-S8N"ELP+3XP73H@,34T,#(W-S0@,34T,#(W-S0@(#,U.#4V
M-S@@/3X@(" Q.#DX.#0U,BX*6S M/C!=.B Q-3,S,#@P-R Q-3,S,#@P-R @
M,S4T-S,R-" ]/B @(#$X.#<X,3,Q+@I;,2T^,5TZ(#$U,SDQ-CDT(#$U,SDQ
M-CDT(" S-3<R,#$W(#T^(" @,3@Y-C,W,3$N"ELQ+3XQ73H@,34S.3 S.#D@
M,34S.3 S.#D@(#,U-3<R-3 @/3X@(" Q.#DT-S8S.2X*6S$M/C%=.B Q-3,Q
M-#@V-" Q-3,Q-#@V-" @,S4U,C0P." ]/B @(#$X.#8W,C<R+@HM/B!;,%U;
M,5U;,3 Q.#0Y,C1=(" @,RXW(%L@(#0N-ET@*# I.B H(#,W,30T-3(@(" T
M.30X-C@I"ELP+3XQ73H@,38R,38X.#,@,38R,38X.#,@(#<X,3 U-3D@/3X@
M(" R-# R-S0T,BX*6S M/C%=.B Q-C(P-S8Q.2 Q-C(P-S8Q.2 @-S@Q-S<R
M,R ]/B @(#(T,#(U,S0R+@I;,"T^,5TZ(#$V,3,S.# Q(#$V,3,S.# Q(" W
M.#<R,30Q(#T^(" @,C0P,#4Y-#(N"ELQ+3XP73H@,38Q.30Q.3 @,38Q.30Q
M.3 @(#<X,C(Q,S<@/3X@(" R-# Q-C,R-RX*6S$M/C!=.B Q-C$Y.3(T-2 Q
M-C$Y.3(T-2 @-S@Q.#<T.2 ]/B @(#(T,#$W.3DT+@I;,2T^,%TZ(#$V,3(P
M,3DS(#$V,3(P,3DS(" W.#@S.34Y(#T^(" @,C0P,#0Q-3(N"ELP+3XP73H@
M,38R,#0S,SD@,38R,#0S,SD@(#<T.#<X,C<@/3X@(" R,S8Y,C$V-BX*6S M
M/C!=.B Q-C(Q,# S-2 Q-C(Q,# S-2 @-S4S.#<Y," ]/B @(#(S-S0X.#(U
M+@I;,"T^,%TZ(#$V,3,Q-3@U(#$V,3,Q-3@U(" W-C0R,3 Y(#T^(" @,C,W
M-S,V.30N"ELQ+3XQ73H@,38R,#$T,#$@,38R,#$T,#$@(#<U,S,S-C(@/3X@
M(" R,S<S-#<V,RX*6S$M/C%=.B Q-C$Y,C4T-B Q-C$Y,C4T-B @-S0W-C<W
M." ]/B @(#(S-C8Y,S(T+@I;,2T^,5TZ(#$V,3$X.#$X(#$V,3$X.#$X(" W
M-C,U-3 R(#T^(" @,C,W-30S,C N"BT^(%LP75LQ75LQ,#<R,#DW,ET@(" P
M+C(@6R @-"XV72 H,"DZ("@@(#(W-C@Q-R @,3DV-C(U,2D*6S M/C%=.B Q
M-S$T,38Y,2 Q-S$T,38Y,2 @.#8V,#DR-R ]/B @(#(U.# R-C$X+@I;,"T^
M,5TZ(#$W,30T,3DX(#$W,30T,3DX(" X-C4Y,S<S(#T^(" @,C4X,#,U-S$N
M"ELP+3XQ73H@,3<R.3<R-3(@,3<R.3<R-3(@(#@V,3DT-C0@/3X@(" R-3DQ
M-C<Q-BX*6S$M/C!=.B Q-S$R-34S-2 Q-S$R-34S-2 @.#8V,C U." ]/B @
M(#(U-S@W-3DS+@I;,2T^,%TZ(#$W,3,P-3(P(#$W,3,P-3(P(" X-C8S.3(X
M(#T^(" @,C4W.30T-#@N"ELQ+3XP73H@,3<R-S@S,C @,3<R-S@S,C @(#@V
M,C$Y-S4@/3X@(" R-3DP,#(Y-2X*6S M/C!=.B Q-S$S.#@Q,R Q-S$S.#@Q
M,R Q-#0U,30T,B ]/B @(#,Q-3DP,C4U+@I;,"T^,%TZ(#$W,3,Y.#DV(#$W
M,3,Y.#DV(#$T-3 X-3(P(#T^(" @,S$V-#@T,38N"ELP+3XP73H@,3<R.#DX
M-C$@,3<R.#DX-C$@,3,U.# Q-34@/3X@(" S,#@W,# Q-BX*6S$M/C%=.B Q
M-S$R.#4S-2 Q-S$R.#4S-2 Q-#0P-3,X,B ]/B @(#,Q-3,S.3$W+@I;,2T^
M,5TZ(#$W,3(V-S$X(#$W,3(V-S$X(#$T-#4S,S(R(#T^(" @,S$U.# P-# N
M"ELQ+3XQ73H@,3<R-S@T.#0@,3<R-S@T.#0@,3,U-C8P-38@/3X@(" S,#@T
M-#4T,"X*+3X@6S!=6S%=6S$Q,C@U,C,S72 @+34N+3,@6R @-"XV72 H,"DZ
M("@M-3,X,3DY-B @,S@Q,C4S,BD*6S M/C%=.B Q.#(P.#8U-B Q.#(P.#8U
M-B @.34V-3,U,B ]/B @(#(W-S<T,# X+@I;,"T^,5TZ(#$X,3DY,S<Q(#$X
M,3DY,S<Q(" Y-38P,#$X(#T^(" @,C<W-3DS.#DN"ELP+3XQ73H@,3@P,S,W
M,3,@,3@P,S,W,3,@(#DU,S(R,S<@/3X@(" R-S4V-3DU,"X*6S$M/C!=.B Q
M.#$W.3<T-B Q.#$W.3<T-B @.34V.# Y,R ]/B @(#(W-S0W.#,Y+@I;,2T^
M,%TZ(#$X,3@U-38T(#$X,3@U-38T(" Y-38Q,C0U(#T^(" @,C<W-#8X,#DN
M"ELQ+3XP73H@,3@P,30Y-C8@,3@P,30Y-C8@(#DU,S0U.3(@/3X@(" R-S4T
M.34U."X*6S M/C!=.B Q.#$Y-3@R,2 Q.#$Y-3@R,2 Q.#,V.#0R-B ]/B @
M(#,V-38T,C0W+@I;,"T^,%TZ(#$X,3DW,3DU(#$X,3DW,3DU(#$X,S8X-C(U
M(#T^(" @,S8U-C4X,C N"ELP+3XP73H@,3@P,C<S-C8@,3@P,C<S-C8@,3@P
M.3 U.38@/3X@(" S-C$Q-SDV,BX*6S$M/C%=.B Q.#$Y,#(X-B Q.#$Y,#(X
M-B Q.#,R,3 Y-R ]/B @(#,V-3$Q,S@S+@I;,2T^,5TZ(#$X,3<Y.#4V(#$X
M,3<Y.#4V(#$X,S0T-C@R(#T^(" @,S8U,C0U,S@N"ELQ+3XQ73H@,3@P,3$T
M,# @,3@P,3$T,# @,3@P.#0P,3<@/3X@(" S-C Y-30Q-RX*+3X@6S!=6S%=
M6S$Q.#<Y,3DR72 @+3@N+38@6R @-"XV72 H,"DZ("@M.#8W,#4P." @,S4U
M,#4R,BD*6S M/C%=.B Q.#@T-S,V-" Q.#@T-S,V-" Q,#0U,C(Y," ]/B @
M(#(Y,CDY-C4T+@I;,"T^,5TZ(#$X.#0P.3DV(#$X.#0P.3DV(#$P-#4Q.38Y
M(#T^(" @,CDR.3(Y-C4N"ELP+3XQ73H@,3DQ-3<Y-#4@,3DQ-3<Y-#4@,3 T
M-30S.#$@/3X@(" R.38Q,C,R-BX*6S$M/C!=.B Q.#@R-3$Y," Q.#@R-3$Y
M," Q,#0U.3(T,R ]/B @(#(Y,C@T-#,S+@I;,2T^,%TZ(#$X.#(U,# R(#$X
M.#(U,# R(#$P-#4S.3@T(#T^(" @,CDR-S@Y.#8N"ELQ+3XP73H@,3DQ,S8R
M,C4@,3DQ,S8R,C4@,3 T-3@R-C8@/3X@(" R.34Y-#0Y,2X*6S M/C!=.B Q
M.#@S.3(R,2 Q.#@S.3(R,2 Q.#DR,34P," ]/B @(#,W-S8P-S(Q+@I;,"T^
M,%TZ(#$X.#,W,S,V(#$X.#,W,S,V(#$X.3$T-34X(#T^(" @,S<W-3$X.30N
M"ELP+3XP73H@,3DQ-3$V-#<@,3DQ-3$V-#<@,3DS,C,W.34@/3X@(" S.#0W
M-30T,BX*6S$M/C%=.B Q.#@R-30Q,R Q.#@R-30Q,R Q.#DP-S@S,R ]/B @
M(#,W-S,S,C0V+@I;,2T^,5TZ(#$X.#(Q.3DR(#$X.#(Q.3DR(#$X.3 V,S,U
M(#T^(" @,S<W,C@S,C<N"ELQ+3XQ73H@,3DQ,S(V,#0@,3DQ,S(V,#0@,3DS
M,3 Q-# @/3X@(" S.#0T,C<T-"X*+3X@6S!=6S%=6S$R-3 T-#$R72 @+3@N
M+38@6R @-"XV72 H,"DZ("@M.#8U-#DP.2 @,3<X,S V,"D*6S M/C%=.B R
M,#(S-#0X." R,#(S-#0X." Q,34P,C@W,2 ]/B @(#,Q-S,W,S4Y+@I;,"T^
M,5TZ(#(P,C,P.3 Y(#(P,C,P.3 Y(#$Q-#DY.#0S(#T^(" @,S$W,S W-3(N
M"ELP+3XQ73H@,C P,CDT-S4@,C P,CDT-S4@,3$T,C@V,S4@/3X@(" S,30U
M.#$Q,"X*6S$M/C!=.B R,#(Q,C0U-B R,#(Q,C0U-B Q,34Q-#,S-2 ]/B @
M(#,Q-S(V-SDQ+@I;,2T^,%TZ(#(P,C$P-S$T(#(P,C$P-S$T(#$Q-3 V.30Q
M(#T^(" @,S$W,3<V-34N"ELQ+3XP73H@,C P,3$R,34@,C P,3$R,34@,3$T
M,S8P,# @/3X@(" S,30T-S(Q-2X*6S M/C!=.B R,#(R,#@S,2 R,#(R,#@S
M,2 R,#0X-S(Q,2 ]/B @(#0P-S X,#0R+@I;,"T^,%TZ(#(P,C(W-S$Y(#(P
M,C(W-S$Y(#(P-#@X.#0X(#T^(" @-# W,38U-C<N"ELP+3XP73H@,C P,C$P
M-3(@,C P,C$P-3(@,C R-S X-3@@/3X@(" T,#(Y,3DQ,"X*6S$M/C%=.B R
M,#(Q-C<U.2 R,#(Q-C<U.2 R,#0W,SDQ-R ]/B @(#0P-CDP-C<V+@I;,2T^
M,5TZ(#(P,C W-C8S(#(P,C W-C8S(#(P-#<Q-C@W(#T^(" @-# V-SDS-3 N
M"ELQ+3XQ73H@,C P,#4S-#<@,C P,#4S-#<@,C R-3,Q,3(@/3X@(" T,#(U
M.#0U.2X*+3X@6S!=6S%=6S$S,38R-3,X72 @+3@N+3@@6R @-"XV72 H,"DZ
M("@M.#@Y.#$S." @,3 Q,S$T-"D*6S M/C%=.B R,#DR-38S-2 R,#DR-38S
M-2 Q,C0X,#4Q.2 ]/B @(#,S-# V,34T+@I;,"T^,5TZ(#(P.3(X-S@T(#(P
M.3(X-S@T(#$R-#@Q.#(X(#T^(" @,S,T,3 V,3(N"ELP+3XQ73H@,C$P.38X
M,3$@,C$P.38X,3$@,3(T-S8W-SD@/3X@(" S,S4W,S4Y,"X*6S$M/C!=.B R
M,#DP,CDR," R,#DP,CDR," Q,C0Y-C(Q,2 ]/B @(#,S,SDY,3,Q+@I;,2T^
M,%TZ(#(P.3 W.#(V(#(P.3 W.#(V(#$R-#@V-C Q(#T^(" @,S,S.30T,C<N
M"ELQ+3XP73H@,C$P-SDP-S(@,C$P-SDP-S(@,3(T-S<X,S<@/3X@(" S,S4U
M-CDP.2X*6S M/C!=.B R,#DR,38Y-B R,#DR,38Y-B R,3 W-#(Q-2 ]/B @
M(#0Q.3DU.3$Q+@I;,"T^,%TZ(#(P.3(P-34T(#(P.3(P-34T(#(Q,#<W,3(Q
M(#T^(" @-#$Y.3<V-S4N"ELP+3XP73H@,C$P.#DR-C0@,C$P.#DR-C0@,C$S
M,S<Y.#0@/3X@(" T,C0R-S(T."X*6S$M/C%=.B R,#DP-3@V,2 R,#DP-3@V
M,2 R,3 V-#0S-" ]/B @(#0Q.3<P,CDU+@I;,2T^,5TZ(#(P.#DY-C,R(#(P
M.#DY-C,R(#(Q,#8S-3 S(#T^(" @-#$Y-C,Q,S4N"ELQ+3XQ73H@,C$P-S8V
M,#0@,C$P-S8V,#0@,C$S,C,T,3<@/3X@(" T,C0P,# R,2X*+3X@6S!=6S%=
M6S$S.#4U,S S72 @+3@N+3<@6R @-"XV72 H,"DZ("@M.#<Q,S$S-2 @(#4Y
M.3 W,RD*6S M/C%=.B R,3DY-#@S-" R,3DY-#@S-" Q,S4X,34S-R ]/B @
M(#,U-3<V,S<Q+@I;,"T^,5TZ(#(Q.3DR.#(X(#(Q.3DR.#(X(#$S-3<X.#0U
M(#T^(" @,S4U-S$V-S,N"ELP+3XQ73H@,C(S-C8R.#@@,C(S-C8R.#@@,3,V
M-3 X-S @/3X@(" S-C Q-S$U."X*6S$M/C!=.B R,3DW,#<X-B R,3DW,#<X
M-B Q,S4Y-# T.2 ]/B @(#,U-38T.#,U+@I;,2T^,%TZ(#(Q.3<P-#@W(#(Q
M.3<P-#@W(#$S-3@U,3DV(#T^(" @,S4U-34V.#,N"ELQ+3XP73H@,C(S-#0S
M,3@@,C(S-#0S,3@@,3,V-3@X,# @/3X@(" S-C P,S$Q."X*6S M/C!=.B R
M,3DY,#,W,2 R,3DY,#,W,2 R,C W-3,R." ]/B @(#0T,#8U-CDY+@I;,"T^
M,%TZ(#(Q.3@W,# R(#(Q.3@W,# R(#(R,#<X.3 T(#T^(" @-#0P-C4Y,#8N
M"ELP+3XP73H@,C(S-C T,C(@,C(S-C T,C(@,C(U-#4W.#,@/3X@(" T-#DP
M-C(P-2X*6S$M/C%=.B R,3DW-C8R-" R,3DW-C8R-" R,C V.34V-" ]/B @
M(#0T,#0V,3@X+@I;,2T^,5TZ(#(Q.38X,#,Y(#(Q.38X,#,Y(#(R,#8V-S<Q
M(#T^(" @-#0P,S0X,3 N"ELQ+3XQ73H@,C(S-#(T,#$@,C(S-#(T,#$@,C(U
M,C@W.38@/3X@(" T-#@W,3$Y-RX*+3X@6S!=6S%=6S$T-3@T-3(Y72 @+3@N
M+38@6R @-"XV72 H,"DZ("@M.#8X,C8R,2 @(#,Q-#<Y,RD*6S M/C%=.B R
M,S(Q,3DR.2 R,S(Q,3DR.2 Q-#<S.34V,R ]/B @(#,W.34Q-#DR+@I;,"T^
M,5TZ(#(S,C$P-3@Q(#(S,C$P-3@Q(#$T-S,W,S4X(#T^(" @,S<Y-#<Y,SDN
M"ELP+3XQ73H@,C,S.30R,C@@,C,S.30R,C@@,30W,S@T.3 @/3X@(" S.#$S
M,C<Q."X*6S$M/C!=.B R,S$X-#DQ," R,S$X-#DQ," Q-#<T-#(P-" ]/B @
M(#,W.3(Y,3$T+@I;,2T^,%TZ(#(S,3@Y,C,S(#(S,3@Y,C,S(#$T-S0Q,#8R
M(#T^(" @,S<Y,S R.34N"ELQ+3XP73H@,C,S-S(Q-C<@,C,S-S(Q-C<@,30W
M-#8Y,3<@/3X@(" S.#$Q.3 X-"X*6S M/C!=.B R,S(P-C$Q.2 R,S(P-C$Q
M.2 R,S,V.3 T-2 ]/B @(#0V-3<U,38T+@I;,"T^,%TZ(#(S,C V,C<Y(#(S
M,C V,C<Y(#(S,S<R-#(U(#T^(" @-#8U-S@W,#0N"ELP+3XP73H@,C,S.3 S
M-C<@,C,S.3 S-C<@,C,V-3(Q.38@/3X@(" T-S T,C4V,RX*6S$M/C%=.B R
M,S$Y,#<U-R R,S$Y,#<U-R R,S,U-#$R." ]/B @(#0V-30T.#@U+@I;,2T^
M,5TZ(#(S,3@U-S$Q(#(S,3@U-S$Q(#(S,S4U-C4X(#T^(" @-#8U-#$S-CDN
M"ELQ+3XQ73H@,C,S-C@P-C0@,C,S-C@P-C0@,C,V,S$R,#@@/3X@(" T-CDY
M.3(W,BX*+3X@6S!=6S%=6S$U,S4R,3,U72 @+3@N+3<@6R @-"XV72 H,"DZ
M("@M.#<U-SDV." @(#$Y-3 W,"D*6S M/C%=.B R-#4X,#,U,2 R-#4X,#,U
M,2 Q-C Q,S@S.2 ]/B @(#0P-3DT,3DP+@I;,"T^,5TZ(#(T-3<V,3@P(#(T
M-3<V,3@P(#$V,#$S-3$X(#T^(" @-# U.#DV.3@N"ELP+3XQ73H@,C0S,30Y
M-S,@,C0S,30Y-S,@,34X-S8R-C<@/3X@(" T,#$Y,3(T,"X*6S$M/C!=.B R
M-#4U-3@W,B R-#4U-3@W,B Q-C R-3(T,R ]/B @(#0P-3@Q,3$U+@I;,2T^
M,%TZ(#(T-38P-#<V(#(T-38P-#<V(#$V,#$W-S0S(#T^(" @-# U-S@R,3DN
M"ELQ+3XP73H@,C0R.3(U,#(@,C0R.3(U,#(@,34X.#DW,C(@/3X@(" T,#$X
M,C(R-"X*6S M/C!=.B R-#4W-S V,2 R-#4W-S V,2 R-#<Q-C P,B ]/B @
M(#0Y,CDS,#8S+@I;,"T^,%TZ(#(T-3<W,C,Q(#(T-3<W,C,Q(#(T-S$T.3@R
M(#T^(" @-#DR.3(R,3,N"ELP+3XP73H@,C0S,#4X,C@@,C0S,#4X,C@@,C0T
M.3$S,3@@/3X@(" T.#<Y-S$T-BX*6S$M/C%=.B R-#4U-3DR-" R-#4U-3DR
M-" R-#8Y,34Q-" ]/B @(#0Y,C0W-#,X+@I;,2T^,5TZ(#(T-34U-#,P(#(T
M-34U-#,P(#(T-C@Y,3@U(#T^(" @-#DR-#0V,34N"ELQ+3XQ73H@,C0R.#,Q
M.34@,C0R.#,Q.34@,C0T-C(Q,3D@/3X@(" T.#<T-3,Q-"X*+3X@6S!=6S%=
M6S$V,38P,30R72 @+3@N+38@6R @-"XV72 H,"DZ("@M.#8S-#0W-R @(#$U
M.3(X,"D*6S M/C%=.B R-3DT,C$U." R-3DT,C$U." Q-S(Y-S$V-" ]/B @
M(#0S,C,Y,S(R+@I;,"T^,5TZ(#(U.30T-#4T(#(U.30T-#4T(#$W,CDV,C8V
M(#T^(" @-#,R-# W,C N"ELP+3XQ73H@,C8Q.3DW,30@,C8Q.3DW,30@,3<S
M-#(T,#8@/3X@(" T,S4T,C$R,"X*6S$M/C!=.B R-3DQ,SDV,B R-3DQ,SDV
M,B Q-S,Q-#0Q.2 ]/B @(#0S,C(X,S@Q+@I;,2T^,%TZ(#(U.3$X.3@W(#(U
M.3$X.3@W(#$W,S$T,3<X(#T^(" @-#,R,S,Q-C4N"ELQ+3XP73H@,C8Q-S4S
M.3(@,C8Q-S4S.3(@,3<S-3<Q-S @/3X@(" T,S4S,C4V,BX*6S M/C!=.B R
M-3DT,S@R,2 R-3DT,S@R,2 R-C$T-S@X,2 ]/B @(#4R,#DQ-S R+@I;,"T^
M,%TZ(#(U.3,X-S8X(#(U.3,X-S8X(#(V,30U-C,W(#T^(" @-3(P.#0T,#4N
M"ELP+3XP73H@,C8Q.30P.38@,C8Q.30P.38@,C8T-3$Y.34@/3X@(" U,C8T
M-C Y,2X*6S$M/C%=.B R-3DQ.3DY," R-3DQ.3DY," R-C$R-#0Y-R ]/B @
M(#4R,#0T-#@W+@I;,2T^,5TZ(#(U.3$V-C(Y(#(U.3$V-C(Y(#(V,3(X,3<S
M(#T^(" @-3(P-#0X,#(N"ELQ+3XQ73H@,C8Q-S(W.3D@,C8Q-S(W.3D@,C8T
M,S(V,3<@/3X@(" U,C8P-30Q-BX*+3X@6S!=6S%=6S$W,#$P-C<U72 @+3@N
M+3D@6R @-"XV72 H,"DZ("@M.#DU.# S-R @(#(T,30R,"D*6S M/C%=.B R
M-S(Y,#DV-2 R-S(Y,#DV-2 Q.#4Y.3 Q-" ]/B @(#0U.#@Y.3<Y+@I;,"T^
M,5TZ(#(W,CDV.#,V(#(W,CDV.#,V(#$X-3DX-C0X(#T^(" @-#4X.34T.#0N
M"ELP+3XQ73H@,C<V,C0W-C<@,C<V,C0W-C<@,3@W-C(P.3 @/3X@(" T-C,X
M-C@U-RX*6S$M/C!=.B R-S(V-3<X-" R-S(V-3<X-" Q.#8Q-C8X," ]/B @
M(#0U.#@R-#8T+@I;,2T^,%TZ(#(W,C8X.3$T(#(W,C8X.3$T(#$X-C$Q-3DW
M(#T^(" @-#4X.# U,3$N"ELQ+3XP73H@,C<V,#8X-C@@,C<V,#8X-C@@,3@W
M-S0R,S(@/3X@(" T-C,X,3$P,"X*6S M/C!=.B R-S(Y,34X-2 R-S(Y,34X
M-2 R-S4R-S$X-B ]/B @(#4T.#$X-S<Q+@I;,"T^,%TZ(#(W,C@V,#(Q(#(W
M,C@V,#(Q(#(W-3(S,3@P(#T^(" @-30X,#DR,#$N"ELP+3XP73H@,C<V,3<W
M.3 @,C<V,3<W.3 @,C<X.30P-S,@/3X@(" U-34Q,3@V,RX*6S$M/C%=.B R
M-S(W,3DS,B R-S(W,3DS,B R-S4P,C$P.2 ]/B @(#4T-S<T,#0Q+@I;,2T^
M,5TZ(#(W,C8V,S U(#(W,C8V,S U(#(W-3 S,C$X(#T^(" @-30W-CDU,C,N
M"ELQ+3XQ73H@,C<U.3DU,38@,C<U.3DU,38@,C<X-C4V,S<@/3X@(" U-30V
M-3$U,RX*+3X@6S!=6S%=6S$W.3 U.3<S72 @+3DN,"!;(" T+C9=("@P*3H@
M*"TY,# R.30W(" @,30S,38U*0I;,"T^,5TZ(#(X.#(X-C8S(#(X.#(X-C8S
M(#(P,3 R-C0P(#T^(" @-#@Y,S$S,#,N"ELP+3XQ73H@,C@X,S,S-#$@,C@X
M,S,S-#$@,C P.3DW-#<@/3X@(" T.#DS,S X."X*6S M/C%=.B R.#8Y,#DY
M-2 R.#8Y,#DY-2 R,# V.3(U-2 ]/B @(#0X-S8P,C4P+@I;,2T^,%TZ(#(X
M.# Q.3,S(#(X.# Q.3,S(#(P,3$X,C P(#T^(" @-#@Y,C Q,S,N"ELQ+3XP
M73H@,C@X,#4V,C4@,C@X,#4V,C4@,C Q,3,P,C,@/3X@(" T.#DQ.#8T."X*
M6S$M/C!=.B R.#8V.#DT," R.#8V.#DT," R,# X,# Y,R ]/B @(#0X-S0Y
M,#,S+@I;,"T^,%TZ(#(X.#(V-C(R(#(X.#(V-C(R(#(Y,#,V,S(U(#T^(" @
M-3<X-C(Y-#<N"ELP+3XP73H@,C@X,C4R,S@@,C@X,C4R,S@@,CDP,C<P,30@
M/3X@(" U-S@U,C(U,BX*6S M/C!=.B R.#8X-S(X.2 R.#8X-S(X.2 R.#@R
M,S8W-2 ]/B @(#4W-3$P.38T+@I;,2T^,5TZ(#(X.# T-#$R(#(X.# T-#$R
M(#(Y,# S,CDV(#T^(" @-3<X,#<W,#@N"ELQ+3XQ73H@,C@X,#(T,C0@,C@X
M,#(T,C0@,C@Y.3DY.3<@/3X@(" U-S@P,C0R,2X*6S$M/C%=.B R.#8V,S0R
M,R R.#8V,S0R,R R.#<Y,3 X-" ]/B @(#4W-#4T-3 W+@HM/B!;,%U;,5U;
M,3@X-#@S.3)=(" M."XM."!;(" T+C9=("@P*3H@*"TX.#$T-S@R(" @,38U
M-C8U*0I;,%U;,5T@=V]R:VEN9R!S970@<VEZ92!F;W5N9#H@.3$Y,3@Y-2P@
M8V]S=#H@-#8V-3(T.0HM+2TM+2TM+2TM+2TM+2TM+2TM+2T*?"!M:6=R871I
M;VX@8V]S="!M871R:7@@*&UA>%]C86-H95]S:7IE.B Y-#,W,3@T+"!C<'4Z
M("TQ($U(>BDZ"BTM+2TM+2TM+2TM+2TM+2TM+2TM+0H@(" @(" @(" @6S P
M72 @("!;,#%=(" @(%LP,ET@(" @6S S70I;,#!=.B @(" @+2 @(" @.2XS
M*# I(" Y+C,H,"D@(#DN,R@P*0I;,#%=.B @(#DN,R@P*2 @(" M(" @(" Y
M+C,H,"D@(#DN,R@P*0I;,#)=.B @(#DN,R@P*2 @.2XS*# I(" @("T@(" @
M(#DN,R@P*0I;,#-=.B @(#DN,R@P*2 @.2XS*# I(" Y+C,H,"D@(" @+2 @
M( HM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+0I\(&-A8VAE9FQU
M<V@@=&EM97,@6S%=.B Y+C,@*#DS,S T.3@I"GP@8V%L:6)R871I;VX@9&5L
M87DZ(#$V('-E8V]N9',*+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM
#+2T*
`
end

