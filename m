Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270857AbRIJNNP>; Mon, 10 Sep 2001 09:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270947AbRIJNMz>; Mon, 10 Sep 2001 09:12:55 -0400
Received: from lan212095014004.ibk.telering.at ([212.95.14.4]:36121 "HELO
	lan212095014004.ibk.telering.at") by vger.kernel.org with SMTP
	id <S270857AbRIJNMp>; Mon, 10 Sep 2001 09:12:45 -0400
Message-ID: <853DD5D67AF0D411A3300000D1DD5C3B260EEE@dsw89.wattens.swarovski.com>
From: Suessmilch Bernd <Bernd.Suessmilch@SWAROVSKI.COM>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: 2.4.x, mlockall() and pthreads: exceptionally huge memory demands
Date: Mon, 10 Sep 2001 15:12:56 +0200
X-Mailer: Internet Mail Service (5.5.2650.21)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo kernel-list,

I have written an application that uses mlockall() in conjunction
with posix-threads. I realized that under Kernel 2.4.x (tested
on 2.4.5-pre1 and 2.4.10-pre6, pentium III, no swap) each thread
consumes an exceptionally huge amount of memory (about 2MB).
When I omit the mlockall()-call each thread consumes only about
24KB.
Running the same application under kernel 2.2.x  each thread
consumes about 12KB of memory (with memory locked).
The attached program illustrates this behavior. 

May this be a bug in the mlockall() implementation of 2.4.x and is
this behavior already known (I found no hint in the archive)?
Please reply with CC to my personal e-mail address
(Bernd.Suessmilch@swarovski.com) since I did not subscribe to this list.

Kind regards,
Bernd


begin 600 mlockall_musg.c
M+RHJ*BHJ*BHJ*BHJ*BHJ*BHJ*BHJ*BHJ*BHJ*BHJ*BHJ*BHJ*BHJ*BHJ*BHJ
M*BHJ*BHJ*BHJ*BHJ*BHJ*BHJ*BHJ*BHJ*BHJ*BH**B!M;&]C:V%L;%]M=7-G
M+F,@+2!D96UO;G-T<F%T97,@;&%R9V4@;65M;W)Y('5S86=E('=H96X@=7-I
M;F<@("`@("`@("`@("H**B`@("`@("`@("`@("`@("`@("!M;&]C:V%L;"@I
M('=I=&@@<'1H<F5A9',@("`@("`@("`@("`@("`@("`@("`@("`@("`@("H*
M*B`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@("`@("`@("`@("H**B!C;VUP:6QE<B!O<'1I
M;VYS.B!C8R`M;R!M;&]C:V%L;%]M=7-G(&UL;V-K86QL7VUU<V<N8R`M;'!T
M:')E860@("`@("`@("H**B!U<V%G93H@+B]M;&]C:V%L;%]M=7-G("`@("`@
M("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("H*
M*B!C;VUM96YT.B!R=6X@:6X@<VEN9VQE+75S97(M;6]D92!A<R!R;V]T("`@
M("`@("`@("`@("`@("`@("`@("`@("`@("`@("H**B`@("`@("`@.B!M86ME
M('-U<F4L(")H96%D(B!I<R!I;B!Y;W5R("10051(("`@("`@("`@("`@("`@
M("`@("`@("`@("`@("H**BHJ*BHJ*BHJ*BHJ*BHJ*BHJ*BHJ*BHJ*BHJ*BHJ
M*BHJ*BHJ*BHJ*BHJ*BHJ*BHJ*BHJ*BHJ*BHJ*BHJ*BHJ*BHJ*BHJ*BHJ*B\*
M"B\J"BHJ(&EN8VQU9&5S"BHO"B-I;F-L=61E(#QP=&AR96%D+F@^("`@("`@
M+RH@4$]325@M5&AR96%D<R`J+PHC:6YC;'5D92`\<WES+VUM86XN:#X@("`@
M("\J(&UL;V-K86QL*"D@*B\*(VEN8VQU9&4@/'-T9&EO+F@^("`@("`@(`HC
M:6YC;'5D92`\97)R;F\N:#X*"B\J"BHJ(&1E9FEN97,**B\*(V1E9FEN92!.
M(#@*"B-D969I;F4@4TQ%15!4(#$P"@HC9&5F:6YE($A)1TA%4U1?4%))3U))
M5%D@,0HC9&5F:6YE($A)1TA?4%))3U))5%D@,PHC9&5F:6YE($Q/5U]04DE/
M4DE462`T"@HO*@HJ*B!P<F]T;W1Y<&5S"BHO"G-T871I8R!V;VED("!S=&%R
M=&5R7W1H<F5A9"AV;VED*3L*<W1A=&EC('9O:60@(&%?=&AR96%D*&EN="`J
M*3L*"B\J"BHJ(&=L;V)A;"!V87)I8FQE<PHJ+PIS=&%T:6,@<'1H<F5A9%]T
M('-T87)T97)?=&%S:U]P<W@["G-T871I8R!P=&AR96%D7W0@=&%S:VQI<W1?
M<'-X6TY=.R`*"B\J"BHJ(&EN;&EN92!F=6YC=&EO;G,**B\*<W1A=&EC(&EN
M;&EN92!V;VED(&1S=U]P97)R;W(H8VAA<BH@<W1R+"!I;G0@97)R;W)?;G5M
M8F5R*0I["B`@9G!R:6YT9BAS=&1E<G(L("(E<SH@)7,@*"5D*5QN(BP@<W1R
M+"!S=')E<G)O<BAE<G)O<E]N=6UB97(I+"!E<G)O<E]N=6UB97(I.PI]"@HO
M*BHJ*BHJ*BHJ*BHJ*BHJ*BHJ*BHJ*BHJ*BHJ*BHJ*BHJ*BHJ*BHJ*BHJ*BHJ
M*BHJ*BHJ*BHJ*BHJ*BHJ*BHJ*BHJ*BHJ*@HJ(&UA:6X@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@
M("`@("`@*@HJ*BHJ*BHJ*BHJ*BHJ*BHJ*BHJ*BHJ*BHJ*BHJ*BHJ*BHJ*BHJ
M*BHJ*BHJ*BHJ*BHJ*BHJ*BHJ*BHJ*BHJ*BHJ*BHJ*BHJ+PII;G0@;6%I;BAI
M;G0@87)G8RP@8VAA<B`J87)G=EM=*0I["B`@:6YT('-T871E.R`@+RH@<W1A
M=&4@;V8@4WES=&5M8V%L;',@*B\*("!I;G0@:3L*("!S=')U8W0@<V-H961?
M<&%R86T@;7E?<V-H960["@H@("\J"B`@*BH@26YI=&EA;&EZ871I;VX*("`J
M+PH@(&EF("AM;&]C:V%L;"A-0TQ?0U524D5.5"!\($U#3%]&55154D4I(#X@
M,"`I('L@+RH@;&]C:R!P86=E<R!I;B!M96UO<GD@*B\*("`@('!E<G)O<B@B
M;6QO8VLB*3L*("`@(&5X:70H,2D["B`@?0H@(`H*("`O*@H@("HJ('-E="!S
M8VAE9"!A='1R:6)U=&4@;V8@;6%I;@H@("HO"B`@;7E?<V-H960N<V-H961?
M<')I;W)I='D@/2!S8VAE9%]G971?<')I;W)I='E?;6%X*%-#2$5$7T9)1D\I
M("T*("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@
M("`@("`@("`@("`@2$E'2$535%]04DE/4DE463L*(&EF("@H<W1A=&4@/2!S
M8VAE9%]S971S8VAE9'5L97(H,"P@4T-(141?1DE&3RP@)FUY7W-C:&5D*2D@
M(3T@,"D@>PH@("`@9'-W7W!E<G)O<B@B<V-H961?<V5T<V-H961U;&5R*&AP
M*2(L('-T871E*3L*("`@(&5X:70H,2D["B`@?2`*"B`@+RH*("`J*B!C<F5A
M=&4@=&%S:W,*("`J+PH@(&9O<B`H:2`](#`[(&D@/"!..R!I*RLI('L*("`@
M(&EF("@H<W1A=&4@/2!P=&AR96%D7V-R96%T92@F=&%S:VQI<W1?<'-X6VE=
M+"!.54Q,+"AV;VED*B@J*2AV;VED*BDI"@D)"0D)"2`@("!A7W1H<F5A9"P@
M3E5,3"DI("$](#`I('L*("`@("`@9'-W7W!E<G)O<B@B<'1H<F5A9%]C<F5A
M=&4H85]T:')E860I(BP@<W1A=&4I.PH@("`@("!E>&ET*#$I.PH@("`@?0H@
M("`@<')I;G1F*")-96UO<GD@=7-A9V4@869T97(@<W1A<G0@;V8@=&%S:R`C
M)61<;B(L(&DI.PH@("`@<WES=&5M*")H96%D("UN(#(@+W!R;V,O;65M:6YF
M;R(I.PH@('T*"B`@+RH*("`J*B!W86ET+BXN"B`@*B\*("!S;&5E<"@S("H@
M4TQ%15!4*3L*"B`@"B`@<F5T=7)N*#`I.PI]"B\J"BHJ(%1A<VLM1G5N:W1I
M;VYE;@HJ+PH*+RHJ*BHJ*BHJ*BHJ*BHJ*BHJ*BHJ*BHJ*BHJ*BHJ*BHJ*BHJ
M*BHJ*BHJ*BHJ*BHJ*BHJ*BHJ*BHJ*BHJ*BHJ*BHJ*BHJ*BHJ*BH**B!T:')E
M860M9G5N8W1I;VX@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@("`@("H**BHJ*BHJ*BHJ*BHJ*BHJ*BHJ*BHJ
M*BHJ*BHJ*BHJ*BHJ*BHJ*BHJ*BHJ*BHJ*BHJ*BHJ*BHJ*BHJ*BHJ*BHJ*BHJ
M*BHJ*BHJ*B\*<W1A=&EC('9O:60@85]T:')E860H:6YT("II*0I["B`@:6YT
M('-T871E.R`*("!S=')U8W0@<V-H961?<&%R86T@;7ES8VAE9#L@+RH@4V-H
M961U;&EN9R!087)A;65T97(@*B\*"B`@+RH*("`J*B!0<FEO<FET865T('-E
M='IE;@H@("HO"B`@;7ES8VAE9"YS8VAE9%]P<FEO<FET>2`]('-C:&5D7V=E
M=%]P<FEO<FET>5]M87@H4T-(141?1DE&3RD@+2!,3U=?4%))3U))5%D["B`@
M:68H*'-T871E(#T@<V-H961?<V5T<V-H961U;&5R*"`P+"!30TA%1%]&249/
M+"`F;7ES8VAE9"`I(#T]("TQ("DI('L*("`@(&1S=U]P97)R;W(H(G-C:&5D
M7W-E='-C:&5D=6QE<BAA7W1H<F5A9"DB+"!S=&%T92D["B`@("!E>&ET*#$I
M.PH@('T*"B`@<VQE97`H4TQ%15!4*3L*"B`@<'1H<F5A9%]E>&ET*$Y53$PI
$.PI]"@==
`
end
