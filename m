Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275392AbTHIT4P (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 15:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275393AbTHIT4P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 15:56:15 -0400
Received: from xs4all.vs19.net ([213.84.236.198]:61403 "EHLO spaans.vs19.net")
	by vger.kernel.org with ESMTP id S275392AbTHIT4L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 15:56:11 -0400
Date: Sat, 9 Aug 2003 21:56:07 +0200
From: Jasper Spaans <jasper@vs19.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Message-ID: <20030809195607.GA8171@spaans.vs19.net>
References: <shsisp7fzkg.fsf@charged.uio.no> <Pine.LNX.4.44.0308081738380.3739-100000@home.osdl.org> <20030809004559.GA17257@spaans.vs19.net>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20030809004559.GA17257@spaans.vs19.net>
Attach: /home/spaans/JasperSpaans.vcf
Organization: http://www.insultant.nl/
X-Copyright: Copyright 2003 C. Jasper Spaans - All Rights Reserved
X-message-flag: Warning! The sender of this mail thinks you should use a more secure email client!
User-Agent: Mutt/1.5.4i
X-SA-Exim-Mail-From: spaans@spaans.vs19.net
Subject: [PATCH] Fix up fs/nfs/inode.c wrt flavo[u]r
Content-Type: text/plain; charset=iso-8859-15
X-SA-Exim-Version: 3.0+cvs (built Mon Jul 28 22:52:54 EDT 2003)
X-SA-Exim-Scanned: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 09, 2003 at 02:45:59AM +0200, Jasper Spaans wrote:
> As I stated before, I'll whip up a patch. However, it's 2:45 localtime here
> right now, and I need to catch some sleep.

Here goes; this is the least intrusive version I could make which still
makes sense.


 fs/nfs/inode.c             |   16 ++++++++--------
 include/linux/nfs4_mount.h |    4 ++--
 include/linux/nfs_mount.h  |    2 +-
 3 files changed, 11 insertions(+), 11 deletions(-)

For those who want to look at this without using bitkeeper, a plaintext
patch is available at 

http://jsp.vs19.net/tmp/flavour.txt


This BitKeeper patch contains the following changesets:
1.1150
## Wrapped with uu ##


M(R!5<V5R.@EJ87-P97(*(R!(;W-T.@EV<S$Y+FYE= HC(%)O;W0Z"2]H;VUE
M+W-P86%N<R]B:R]L:6YU>"TR+C8*"B,@4&%T8V@@=F5R<SH),2XS"B,@4&%T
M8V@@='EP93H)4D5'54Q!4@H*/3T@0VAA;F=E4V5T(#T]"G1O<G9A;&1S0&%T
M:&QO;BYT<F%N<VUE=&$N8V]M?$-H86YG95-E='PR,# R,#(P-3$W,S U-GPQ
M-C T-WQC,60Q,6$T,65D,#(T.#8T"G1M;VQI;F% 8V%B;&5S<&5E9"YC;VU\
M0VAA;F=E4V5T?#(P,#,P.# Y,38T,#$W?#,R.#8V"D0@,2XQ,34P(# S+S X
M+S Y(#(Q.C,W.C(P*S R.C P(&IA<W!E<D!V<S$Y+FYE=" K-" M, I"('1O
M<G9A;&1S0&%T:&QO;BYT<F%N<VUE=&$N8V]M?$-H86YG95-E='PR,# R,#(P
M-3$W,S U-GPQ-C T-WQC,60Q,6$T,65D,#(T.#8T"D,*8R!#:&%N9V4@<W!E
M;&QI;F<@;V8@9FQA=F]U<B!T;R!F;&%V;W(@:6X@9G,O;F9S+VEN;V1E+F,@
M86YD('1H92!H96%D97)S('1H:7,@9FEL92!I;F-L=61E<PIC( IC(%1H:7,@
M<')E=F5N=',@86YY(&-O;F9U<VEO;B!T:&%T(&UI9VAT(&%R:7-E(&)E8V%U
M<V4@8F]T:"!S<&5L;&EN9W,@87)E('5S960@:6X@=&AE('-A;64@<V]U<F-E
M(&9I;&4N"DL@,C<Q.34*4"!#:&%N9V53970*+2TM+2TM+2TM+2TM+2TM+2TM
M+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM"@HP83 */B!T;W)V86QD
M<T!A=&AL;VXN=')A;G-M971A+F-O;7Q":71+965P97(O971C+VEG;F]R97PR
M,# R,#(P-3$W,S U-GPQ-S<U,7QF83<Q8S5E9#,P,&$S8V9C(&IA<W!E<D!V
M<S$Y+FYE='Q":71+965P97(O971C+VEG;F]R97PR,# S,#@P.3$Y,S8P,7PV
M,S U-0H^('1O<G9A;&1S0&%T:&QO;BYT<F%N<VUE=&$N8V]M?&EN8VQU9&4O
M;&EN=7@O;F9S7VUO=6YT+FA\,C P,C R,#4Q-S,Y-#!\,C8V,C!\-SED,3<Q
M-#1A,C=C-#%E92!J87-P97) =G,Q.2YN971\:6YC;'5D92]L:6YU>"]N9G-?
M;6]U;G0N:'PR,# S,#@P.3$Y,S8P,7PV-#,S-PH^('1R;VYD+FUY:VQE8G5S
M=$!F>7,N=6EO+FYO6W1O<G9A;&1S77QI;F-L=61E+VQI;G5X+VYF<S1?;6]U
M;G0N:'PR,# R,3 Q-C R,S T-7PV-#4Q.7QC8F-A8SEF8C%B9C-E,C9D(&IA
M<W!E<D!V<S$Y+FYE='QI;F-L=61E+VQI;G5X+VYF<S1?;6]U;G0N:'PR,# S
M,#@P.3$Y,S8P,7PP.3 R-@H^('1O<G9A;&1S0&%T:&QO;BYT<F%N<VUE=&$N
M8V]M?&9S+VYF<R]I;F]D92YC?#(P,#(P,C U,3<S.3,X?# Y,S8S?#-F,#,Y
M,C=A8V9D8F0T82!J87-P97) =G,Q.2YN971\9G,O;F9S+VEN;V1E+F-\,C P
M,S X,#DQ.3,V,#%\-C(X,#$*"CT]($)I=$ME97!E<B]E=&,O:6=N;W)E(#T]
M"G1O<G9A;&1S0&%T:&QO;BYT<F%N<VUE=&$N8V]M?$)I=$ME97!E<B]E=&,O
M:6=N;W)E?#(P,#(P,C U,3<S,#4V?#$W-S4Q?&9A-S%C-65D,S P83-C9F,*
M=&]R=F%L9'- :&]M92YO<V1L+F]R9WQ":71+965P97(O971C+VEG;F]R97PR
M,# S,#@P,C$W,S0U,7PU-C(R-PI$(#$N-C4@,#,O,#@O,#D@,C$Z,S8Z,#$K
M,#(Z,# @:F%S<&5R0'9S,3DN;F5T("LS("TP"D(@=&]R=F%L9'- 871H;&]N
M+G1R86YS;65T82YC;VU\0VAA;F=E4V5T?#(P,#(P,C U,3<S,#4V?#$V,#0W
M?&,Q9#$Q830Q960P,C0X-C0*0PIC($%D9&5D(&9S+VYF<R]I;F]D92YC?B!I
M;F-L=61E+VQI;G5X+VYF<S1?;6]U;G0N:'X@:6YC;'5D92]L:6YU>"]N9G-?
M;6]U;G0N:'X@=&\@=&AE(&EG;F]R92!L:7-T"DL@-C,P-34*3R M<G<M<G<M
M<BTM"E @0FET2V5E<&5R+V5T8R]I9VYO<F4*+2TM+2TM+2TM+2TM+2TM+2TM
M+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM"@I),3,Y(#,*9G,O;F9S
M+VEN;V1E+F-^"FEN8VQU9&4O;&EN=7@O;F9S-%]M;W5N="YH?@II;F-L=61E
M+VQI;G5X+VYF<U]M;W5N="YH?@H*/3T@9G,O;F9S+VEN;V1E+F,@/3T*=&]R
M=F%L9'- 871H;&]N+G1R86YS;65T82YC;VU\9G,O;F9S+VEN;V1E+F-\,C P
M,C R,#4Q-S,Y,SA\,#DS-C-\,V8P,SDR-V%C9F1B9#1A"FIA<W!E<D!V<S$Y
M+FYE=%MT;W)V86QD<UU\9G,O;F9S+VEN;V1E+F-\,C P,S W,3<Q.3$P,S9\
M-C,Y,#<*1" Q+C@U(# S+S X+S Y(#(Q.C,V.C Q*S R.C P(&IA<W!E<D!V
M<S$Y+FYE=" K." M. I"('1O<G9A;&1S0&%T:&QO;BYT<F%N<VUE=&$N8V]M
M?$-H86YG95-E='PR,# R,#(P-3$W,S U-GPQ-C T-WQC,60Q,6$T,65D,#(T
M.#8T"D,*8R!#:&%N9V4@<W!E;&QI;F<@;V8@9FQA=F]U<B!T;R!F;&%V;W(@
M:6X@9G,O;F9S+VEN;V1E+F,*2R V,C@P,0I/("UR=RUR=RUR+2T*4"!F<R]N
M9G,O:6YO9&4N8PHM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM
M+2TM+2TM+2TM+2TM+2T*"D0T.#$@,0I)-#@Q(#$*"6EF("@A*&1A=&$M/F9L
M86=S("8@3D937TU/54Y47U-%0T9,059/4BDI"D0Q,CDY(#$*23$R.3D@,0H)
M"0ED871A+3YF;&%G<R F/2!^3D937TU/54Y47U-%0T9,059/4CL*1#$S-3<@
M,0I),3,U-R Q"@ER<&-?875T:&9L879O<E]T(&%U=&AF;&%V;W(["D0Q-#$P
M(#,*23$T,3(@,PH)875T:&9L879O<B ](%)00U]!551(7U5.25@["@EI9B H
M9&%T82T^875T:%]F;&%V;W)L96X@(3T@,"D@>PH)"6EF("AD871A+3YA=71H
M7V9L879O<FQE;B ^(#$I"D0Q-#$T(#$*23$T,30@,0H)"6EF("AC;W!Y7V9R
M;VU?=7-E<B@F875T:&9L879O<BP@9&%T82T^875T:%]F;&%V;W)S+"!S:7IE
M;V8H875T:&9L879O<BDI*2!["D0Q-#(P(#$*23$T,C @,0H)"0D)('-E<G9E
M<BT^<G!C7V]P<RT^=F5R<VEO;BP@875T:&9L879O<BD["@H]/2!I;F-L=61E
M+VQI;G5X+VYF<U]M;W5N="YH(#T]"G1O<G9A;&1S0&%T:&QO;BYT<F%N<VUE
M=&$N8V]M?&EN8VQU9&4O;&EN=7@O;F9S7VUO=6YT+FA\,C P,C R,#4Q-S,Y
M-#!\,C8V,C!\-SED,3<Q-#1A,C=C-#%E90IF8W5S86-K0&9C=7-A8VLN8V]M
M6W1O<G9A;&1S77QI;F-L=61E+VQI;G5X+VYF<U]M;W5N="YH?#(P,#,P-S$W
M,3<R.#$U?#8T-#(R"D0@,2XU(# S+S X+S Y(#(Q.C,V.C Q*S R.C P(&IA
M<W!E<D!V<S$Y+FYE=" K,2 M,0I"('1O<G9A;&1S0&%T:&QO;BYT<F%N<VUE
M=&$N8V]M?$-H86YG95-E='PR,# R,#(P-3$W,S U-GPQ-C T-WQC,60Q,6$T
M,65D,#(T.#8T"D,*8R!#:&%N9V4@<W!E;&QI;F<@;V8@9FQA=F]U<B!T;R!F
M;&%V;W(@:6X@9G,O;F9S+VEN;V1E+F,@86YD(&AE861E<G,*2R V-#,S-PI/
M("UR=RUR=RUR+2T*4"!I;F-L=61E+VQI;G5X+VYF<U]M;W5N="YH"BTM+2TM
M+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+0H*
M1#8P(#$*238P(#$*(V1E9FEN92!.1E-?34]53E1?4T5#1DQ!5D]2"3!X,C P
M, DO*B U("HO"@H]/2!I;F-L=61E+VQI;G5X+VYF<S1?;6]U;G0N:" ]/0IT
M<F]N9"YM>6ML96)U<W1 9GES+G5I;RYN;UMT;W)V86QD<UU\:6YC;'5D92]L
M:6YU>"]N9G,T7VUO=6YT+FA\,C P,C$P,38P,C,P-#5\-C0U,3E\8V)C86,Y
M9F(Q8F8S93(V9 IT<F]N9"YM>6ML96)U<W1 9GES+G5I;RYN;UMT;W)V86QD
M<UU\:6YC;'5D92]L:6YU>"]N9G,T7VUO=6YT+FA\,C P,C$P,38P,C,P-#9\
M,#DR-C *1" Q+C(@,#,O,#@O,#D@,C$Z,S8Z,#$K,#(Z,# @:F%S<&5R0'9S
M,3DN;F5T("LR("TR"D(@=&]R=F%L9'- 871H;&]N+G1R86YS;65T82YC;VU\
M0VAA;F=E4V5T?#(P,#(P,C U,3<S,#4V?#$V,#0W?&,Q9#$Q830Q960P,C0X
M-C0*0PIC($-H86YG92!S<&5L;&EN9R!O9B!F;&%V;W5R('1O(&9L879O<B!I
M;B!F<R]N9G,O:6YO9&4N8R!A;F0@:&5A9&5R<PI+(#DP,C8*3R M<G<M<G<M
M<BTM"E @:6YC;'5D92]L:6YU>"]N9G,T7VUO=6YT+F@*+2TM+2TM+2TM+2TM
M+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM"@I$-30@,@I)
M-34@,@H):6YT(&%U=&A?9FQA=F]R;&5N.PD)"2\J(#$@*B\*"6EN=" J875T
M:%]F;&%V;W)S.PD)"2\J(#$@*B\*"B,@4&%T8V@@8VAE8VMS=6T]9C@S,SDW
#,S0*
--  
Jasper Spaans                 http://jsp.vs19.net/contact/

<==      Het bedrijf van de appelcomputer is niet      ==>
<==    verantwoordelijk voor de omzettingsprecisie.    ==>
