Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265895AbTBTNLo>; Thu, 20 Feb 2003 08:11:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265894AbTBTNLo>; Thu, 20 Feb 2003 08:11:44 -0500
Received: from yorktown.msoe.edu ([155.92.194.37]:12816 "EHLO
	yorktown.msoe.edu") by vger.kernel.org with ESMTP
	id <S265890AbTBTNLh>; Thu, 20 Feb 2003 08:11:37 -0500
Message-ID: <1045747279.379.5.camel@tranquility>
From: "Kline, Jonathan" <klinej@msoe.edu>
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.5.62 ACPI Oops
Date: Thu, 20 Feb 2003 07:21:20 -0600
X-Mailer: Internet Mail Service (5.5.2653.19)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hardware Info:
	Compaq Armada E500
	PIII 850
	256

	Running w/ ACPI enabled. 

 printing eip:
Feb 20 07:05:43 tranquility kernel: c01f5479
Feb 20 07:05:43 tranquility kernel: Oops: 0000
Feb 20 07:05:43 tranquility kernel: CPU:    0
Feb 20 07:05:43 tranquility kernel: EIP:    0060:[<c01f5479>]    Not
tainted
Feb 20 07:05:43 tranquility kernel: EFLAGS: 00010246
Feb 20 07:05:43 tranquility kernel: EIP is at
acpi_ns_map_handle_to_node+0x19/0x29
Feb 20 07:05:43 tranquility kernel: eax: 00000000   ebx: 2f2e150f   ecx:
00000000   edx: 00000006
Feb 20 07:05:43 tranquility kernel: esi: 2f2e150f   edi: c12bbdac   ebp:
c12bbd54   esp: c12bbd50
Feb 20 07:05:43 tranquility kernel: ds: 007b   es: 007b   ss: 0068
Feb 20 07:05:43 tranquility kernel: Process events/0 (pid: 3,
threadinfo=c12ba000 task=c12bec40)
Feb 20 07:05:43 tranquility kernel: Stack: c12bbd80 c12bbd6c c01f3f97
2f2e150f c12bbd80 c12bbdac 2f2e150f c12bbd9c 
Feb 20 07:05:43 tranquility kernel:        c0204672 2f2e150f c0210246
c12bbdac 00010000 c03c27cd c03c27c4 0000005e 
Feb 20 07:05:43 tranquility kernel:        c12bbdb0 c12bbdb0 2f2e150f
c12bbdcc c020a8e2 2f2e150f c12bbdac 00000000 
Feb 20 07:05:43 tranquility kernel: Call Trace:
Feb 20 07:05:43 tranquility kernel:  [<c01f3f97>]
acpi_get_data+0x34/0x61
Feb 20 07:05:43 tranquility kernel:  [<c0204672>]
acpi_bus_get_device+0x42/0x9a
Feb 20 07:05:43 tranquility kernel:  [<c0210246>]
acpi_bus_data_handler+0x0/0x35
Feb 20 07:05:43 tranquility kernel:  [<c020a8e2>]
acpi_power_get_context+0x46/0xa6
Feb 20 07:05:43 tranquility kernel:  [<c020086a>]
acpi_ut_trace+0x29/0x2b
Feb 20 07:05:43 tranquility kernel:  [<c020acb6>]
acpi_power_off_device+0x46/0x19d
Feb 20 07:05:43 tranquility kernel:  [<c020b010>]
acpi_power_transition+0x111/0x138
Feb 20 07:05:43 tranquility kernel:  [<c0204a28>]
acpi_bus_set_power+0x15f/0x273
Feb 20 07:05:43 tranquility kernel:  [<c0200800>]
acpi_ut_debug_print+0x87/0x9e
Feb 20 07:05:43 tranquility kernel:  [<c020e38f>]
acpi_thermal_active+0xbf/0x187
Feb 20 07:05:43 tranquility kernel:  [<c020e708>]
acpi_thermal_check+0x29d/0x2ea
Feb 20 07:05:43 tranquility kernel:  [<c020f579>]
acpi_thermal_notify+0xa6/0x105
Feb 20 07:05:43 tranquility kernel:  [<c01e654a>]
acpi_ev_notify_dispatch+0x54/0x7a
Feb 20 07:05:43 tranquility kernel:  [<c01deaf5>]
acpi_os_execute_deferred+0x3a/0x6c
Feb 20 07:05:43 tranquility kernel:  [<c0130755>]
run_workqueue+0x75/0xe0
Feb 20 07:05:43 tranquility kernel:  [<c01deabb>]
acpi_os_execute_deferred+0x0/0x6c
Feb 20 07:05:43 tranquility kernel:  [<c0130398>]
worker_thread+0x1b8/0x1f0
Feb 20 07:05:43 tranquility kernel:  [<c011e1a0>]
default_wake_function+0x0/0x20
Feb 20 07:05:43 tranquility kernel:  [<c011e1a0>]
default_wake_function+0x0/0x20
Feb 20 07:05:43 tranquility kernel:  [<c01301e0>]
worker_thread+0x0/0x1f0
Feb 20 07:05:43 tranquility kernel:  [<c01074cd>]
kernel_thread_helper+0x5/0x18
Feb 20 07:05:43 tranquility kernel: 
Feb 20 07:05:43 tranquility kernel: Code: 80 3b aa 0f 44 c3 5b 5d c3 a1
74 3f 4a c0 eb f6 55 89 e5 8b 

The oops, as decoded by ksymoops, is in teh attached file.

Cheers,
-- 
Jonathan Kline <klinej@msoe.edu>
Milwaukee School of engineering


begin 600 ksymoops
M:W-Y;6]O<',@,BXT+C@@;VX@:38X-B`R+C4N-C(N("!/<'1I;VYS('5S960-
M"B`@("`@+58@*'-P96-I9FEE9"D-"B`@("`@+6L@+W!R;V,O:W-Y;7,@*&1E
M9F%U;'0I#0H@("`@("UL("]P<F]C+VUO9'5L97,@*&1E9F%U;'0I#0H@("`@
M("UO("]L:6(O;6]D=6QE<R\R+C4N-C(O("AD969A=6QT*0T*("`@("`M;2`O
M8F]O="]3>7-T96TN;6%P+3(N-2XV,BTQ("AS<&5C:69I960I#0H-"D5R<F]R
M("AR96=U;&%R7V9I;&4I.B!R96%D7VMS>6US('-T870@+W!R;V,O:W-Y;7,@
M9F%I;&5D#0I.;R!M;V1U;&5S(&EN(&MS>6US+"!S:VEP<&EN9R!O8FIE8W1S
M#0I.;R!K<WEM<RP@<VMI<'!I;F<@;'-M;V0-"E=A<FYI;F<Z(&YU;&P@5%19
M(&9O<B`H)7,I(&EN("5S#0II;G1E<FYA;"!E<G)O<BP@:6YV86QI9"!M971H
M;V1I;G9A;&ED(&-O;7!R97-S960@9F]R;6%T("AO=&AE<BEI;G9A;&ED(&-O
M;7!R97-S960@9F]R;6%T("AE<G(],BEI;G9A;&ED(&-O;7!R97-S960@9F]R
M;6%T("AE<G(],2EU<VEN9R!P;VQL:6YG(&ED;&4@=&AR96%D<RX-"E!I9#H@
M)60L(&-O;6TZ("4R,',-"D5)4#H@)3`T>#I;/"4P.&QX/ET@0U!5.B`E9`T*
M($5&3$%'4SH@)3`X;'@@("`@)7,-"B!$4SH@)3`T>"!%4SH@)3`T>`T*4W1A
M8VLZ($-O9&4Z("!"860@14E0('9A;'5E+CQB860@9FEL96YA;64^:V5R;F5L
M($)51R!A="`E<SHE9"$-"CPV/G1E<W1I;F<@3DU)('=A=&-H9&]G("XN+B!C
M;VYS;VQE('-H=71S('5P("XN+@T*,3,Y-$9)0E)%23)/4T%402`@("`@("`@
M9&5V:6-E.B`E=0T*14%8.B`E,#AL>"!%0E@Z("4P.&QX($5#6#H@)3`X;'@@
M1418.B`E,#AL>`T*15-).B`E,#AL>"!%1$DZ("4P.&QX($5"4#H@)3`X;'A#
M4C`Z("4P.&QX($-2,CH@)3`X;'@@0U(S.B`E,#AL>"!#4C0Z("4P.&QX#0I7
M05).24Y'.B!D96%D('!R;V-E<W,@)3AS('-T:6QL(&AA<R!,1%0_(#PE<"\E
M9#X-"D5)4#H@("`@)3`T>#I;/"4P.&QX/ET@("`@)7,-"D5&3$%'4SH@)3`X
M;'@-"F5A>#H@)3`X;'@@("!E8G@Z("4P.&QX("`@96-X.B`E,#AL>"`@(&5D
M>#H@)3`X;'@-"F5S:3H@)3`X;'@@("!E9&DZ("4P.&QX("`@96)P.B`E,#AL
M>"`@(&5S<#H@)3`X;'@-"F1S.B`E,#1X("`@97,Z("4P-'@@("!S<SH@)3`T
M>`T*56AH=6@N($Y-22!R96-E:79E9"X@1&%Z960@86YD(&-O;F9U<V5D+"!B
M=70@=')Y:6YG('1O(&-O;G1I;G5E#0I.34DZ($E/0TL@97)R;W(@*&1E8G5G
M(&EN=&5R<G5P=#\I#0I5:&AU:"X@3DU)(')E8V5I=F5D(&9O<B!U;FMN;W=N
M(')E87-O;B`E,#)X(&]N($-052`E9"X-"CPV/B`J*BH@0G5I;&1I;F<@86X@
M4TU0(&ME<FYE;"!M87D@979A9&4@=&AE(&)U9R!S;VUE(&]F('1H92!T:6UE
M+@T*/#8^)7,@;6%C:&EN92!D971E8W1E9"X@36]U<V5P860@4F5S=6UE($)U
M9R!W;W)K87)O=6YD(&AO<&5F=6QL>2!N;W0@;F5E9&5D+@T*9F1I=E]B=6<@
M("`@("`@(#H@)7,-"FAL=%]B=6<@("`@("`@("`Z("5S#0IF,#!F7V)U9R`@
M("`@("`@.B`E<PT*8V]M85]B=6<@("`@("`@(#H@)7,-"CPV/D%-1"!+-B!S
M=&5P<&EN9R!"(&1E=&5C=&5D("T@/#8^2S8@0E5'("5L9"`E9"`H4F5P;W)T
M('1H97-E(&EF('1E<W0@<F5P;W)T(&ES(&EN8V]R<F5C="D-"CPW/B`@("`@
M96%X.B`E,#AX(&5B>#H@)3`X>"!E8W@Z("4P.'@@961X.B`E,#AX#0H\-SX@
M("`@(&5S:3H@)3`X>"!E9&DZ("4P.'@@96)P.B`E,#AX(&5S<#H@)3`X>`T*
M/#0^04-023H@3DU)(&YO="!C;VYN96-T960@=&\@3$E.5"`Q(0T*/#,^04-0
M23H@17)R;W(@<&%R<VEN9R!.34D@4U)#(&5N=')Y#0H\,SY!0U!).B!%<G)O
M<B!P87)S:6YG($Q!4$E#($Y-22!E;G1R>0T*/#,^5T%23DE.1SH@8F]G=7,@
M>F5R;R!)+T\@05!)0R!A9&1R97-S(&9O=6YD(&EN($U0('1A8FQE+"!S:VEP
M<&EN9R$-"CPV/D1E9F%U;'0@35`@8V]N9FEG=7)A=&EO;B`C)60-"CPS/E=!
M4DY)3D<Z(&)O9W5S('IE<F\@24\M05!)0R!A9&1R97-S(&9O=6YD(&EN($U0
M5$%"3$4L(&1I<V%B;&EN9R!)3R]!4$E#('-U<'!O<G0A#0I#4%4C)60Z($Y-
M22!A<'!E87)S('1O(&)E('-T=6-K(0T*3DU)(%=A=&-H9&]G(&1E=&5C=&5D
M($Q/0TM54"!O;B!#4%4E9"P@96EP("4P.&QX+"!R96=I<W1E<G,Z#0H\-SXP
M,3(S-#4V-S@Y86)C9&5F,#$R,S0U-C<X.6%B8V1E9@T*/#(^06EE964A(2$@
M(%)E;6]T92!)4E(@<W1I;&P@<V5T(&%F=&5R('5N;&]C:R$-"CPV/F%C=&EV
M871I;F<@3DU)(%=A=&-H9&]G("XN+CPT/DE/05!)0ULE9%TZ(&%P:6-?:60@
M)60@86QR96%D>2!U<V5D+"!T<GEI;F<@)60-"CPV/BXN+G1R>6EN9R!T;R!S
M970@=7`@=&EM97(@*$E243`I('1H<F]U9V@@=&AE(#@R-3E!("XN+B`\-CXN
M+BYT<GEI;F<@=&\@<V5T('5P('1I;65R(&%S(%9I<G1U86P@5VER92!)4E$N
M+BX\-CXN+BYT<GEI;F<@=&\@<V5T('5P('1I;65R(&%S($5X=$E.5"!)4E$N
M+BX\-#YT:6UE<B!D;V5S;B=T('=O<FL@=&AR;W5G:"!T:&4@24\M05!)0R`M
M(&1I<V%B;&EN9R!.34D@5V%T8VAD;V<A#0I787)N:6YG.B!3<&5C('9I;VQA
M=&EO;BX@(%!A9&1I;F<@<VAO=6QD(&)E(#!X,C`N#0I787)N:6YG.B!3<&5C
M('9I;VQA=&EO;BX@($1E=FEC92!0871H(&-H96-K<W5M(&EN=F%L:60N#0I7
M87)N:6YG.B!3<&5C('9I;VQA=&EO;BX@($ME>2!S:&]U;&0@8F4@,'A"141$
M+"!I<R`P>$1$0D4-"CPQ/BIP9&4@/2`E,#AL>`T*/#$^56YA8FQE('1O(&AA
M;F1L92!K97)N96P@3E5,3"!P;VEN=&5R(&1E<F5F97)E;F-E/#$^56YA8FQE
M('1O(&AA;F1L92!K97)N96P@<&%G:6YG(')E<75E<W1R96UA<%]A<F5A7W!T
M93H@<&%G92!A;')E861Y(&5X:7-T<PT*071T96UP=&5D('1O(&MI;&P@=&AE
M(&ED;&4@=&%S:R%!:65E+"!K:6QL:6YG(&EN=&5R<G5P="!H86YD;&5R(4%T
M=&5M<'0@=&\@:VEL;"!T87-K;&5T(&9R;VT@:6YT97)R=7!T#0H\,SYI;G1E
M<E]M;V1U;&5?<F5G:7-T97(Z(&1U<&QI8V%T92!I;5]N86UE("<E<R<\,SY!
M:65E+"!I;G1E<E]M;V1U;&5?<F5G:7-T97(Z(&-A;FYO="!K;6%L;&]C(&5N
M=')Y(&9O<B`G)7,G#0IK97)N96PO<V-H960N8R4M,3,N,3-S("`E,#AL6"`E
M-6QU("4U9"`E-F0@)35D("4W9"`E-60@*$PM5$Q"*0T*57-I;F<@9&5F875L
M=',@9G)O;2!K<WEM;V]P<R`M="!E;&8S,BUI,S@V("UA(&DS.#8-"B`H3D]4
M3$(I#0I787)N:6YG("A/;W!S7W)E860I.B!#;V1E(&QI;F4@;F]T('-E96XL
M(&1U;7!I;F<@=VAA="!D871A(&ES(&%V86EL86)L90T*#0I0<F]C.R`@:V5R
M;F5L+W-C:&5D+F,E+3$S+C$S<PT*#0H^/D5)4#L@,#`P,#`P,#@@0F5F;W)E
M(&9I<G-T('-Y;6)O;"`@(#P]/3T]/0T*#0I"86-K=')A8V4Z#0IF;&%G<SHP
M>"4P.&QX(&UA<'!I;F<Z)7`@;6%P<&5D.B5D(&-O=6YT.B5D#0I#1#`P,3PT
M/D)A9"!L;V=I8V%L('IO;F4@<VEZ92`E;&0-"G5N86)L92!T;R!R96%D(&DM
M;F]D92!B;&]C:VYL<U\E<V-P-#,W9G,O=61F+V)A;&QO8RYC/#<^541&+69S
M($1%0E5'("5S.B5D.B5S.B!B:70@)6QD(&%L<F5A9'D@<V5T#0I"14$P,51%
M03`Q=F]L4V5T261E;G1;72`]("<E<R<-"CPV/G=A<FYI;F<Z('!R;V-E<W,@
M8"5S)R!U<V5D('1H92!O8G-O;&5T92!B9&9L=7-H('-Y<W1E;2!C86QL#0I0
M:60Z("`@("5D#0H\-#Y787)N:6YG.B!D969E8W1I=F4@0T0M4D]-+B`@16YA
M8FQI;F<@(F-R=69T(B!M;W5N="!O<'1I;VXN#0H\-CY!0U!).B!,05!)0U].
M34D@*&%C<&E?:61;,'@E,#)X72!P;VQA<FET>5LP>"5X72!T<FEG9V5R6S!X
M)7A=(&QI;G1;,'@E>%TI#0I787)N:6YG.B!.;R!R97-U;'0@;V)J96-T('!U
M<VAE9"$@4W1A=&4])7`-"E1A<F=E="!I<R!N;W0@82!2969E<F5N8V4@;W(@
M0V]N<W1A;G0@;V)J96-T*BHJ*B!7<FET92!T;R!$96)U9R!/8FIE8W0Z("HJ
M*BHZ#0ID969A=6QT('-T871E.B`@("`@("`@("`@0R5D#0H\-#Y787)N:6YG
M.B!D978@*"5S*2!T='DM/F-O=6YT*"5D*2`A/2`C9F0G<R@E9"D@:6X@)7,-
M"CPS/F4Q,#`Z($-O<G)U<'1E9"!%15!23TT@;VX@:6YS=&%N8V4@(R5D#0H\
M,SYE,3`P.B!.;W0@86)L92!T;R!A;&QO8R!E=&AE<F1E=B!S=')U8W0-"CPU
M/F4Q,#`Z(%5S:6YG(&1E9F%U;'1S(&9O<B!A;&P@=F%L=65S#0H\-3YE,3`P
M.B!);G9A;&ED("5S('-P96-I9FEE9"`H)6DI+B!686QI9"!R86YG92!I<R`E
M:2TE:0T*/#4^93$P,#H@57-I;F<@9&5F875L="`E<R!O9B`E:0T*/#8^93$P
M,#H@57-I;F<@<W!E8VEF:65D("5S(&]F("5I#0H\-3YE,3`P.B!);G9A;&ED
M("5S('-P96-I9FEE9"`H)6DI+B!686QI9"!V86QU97,@87)E("5I+R5I#0H\
M-#YE,3`P.B`E<SH@375L=&EC87-T('-E='5P(&9A:6QE9`T*/#,^93$P,#H@
M<V5L9G1E<W0@9F%I;&5D+B!297-U;'1S.B`E>`T*/#,^93$P,#H@1F%I;&5D
M('1O(&%L;&]C871E(&UE;6]R>0T*/#,^93$P,#H@)7,@3DE#($QI;FL@:7,@
M57`@)60@36)P<R`E<R!D=7!L97@-"CPW/F4Q,#`Z("5S.B!C=5]S=&%R=#H@
M=&EM96]U="!W86ET:6YG(&9O<B!S8V(-"CPW/F4Q,#`Z("5S.B!C=5]S=&%R
M=#H@=&EM96]U="!W86ET:6YG(&9O<B!C=0T*/#<^93$P,#H@)7,Z(&4Q,#!?
M=V%I=%]E>&5C7W-I;7!L93H@9F%I;&5D#0H\-SYE,3`P.B`E<SH@<W1A<G1?
M<G4Z('=A:71?<V-B(&9A:6QE9`T*/#,^93$P,#H@)7,Z($9A:6QE9"!T;R!M
M87`@4$-)(&%D9')E<W,@,'@E;%@-"CPS/F4Q,#`Z(&4Q,#!?8V]N9FEG=7)E
M7V1E=FEC93H@<V5T=7`@:6%A9&1R(&9A:6QE9`T*/#,^93$P,#H@93$P,%]D
M96ES;VQA=&5?9')I=F5R.B!D979I8V4@8V]N9FEG=7)A=&EO;B!F86EL960-
M"CPT/F4Q,#`Z("5S.B!&:6QT97(@<V5T=7`@9F%I;&5D#0H\-3YE,3`P.B!E
M,3`P7V-O;F9I9U]L;V]P8F%C:U]M;V1E.B!);G9A;&ED(&%R9W5M96YT("=M
M;V1E)SH@)60-"CPS/F4Q,#`Z($Y#,S$S,R!.24,@8V%N(&]N;'D@<G5N(&%T
M(#$P,$UB<',@9G5L;"!D=7!L97@-"CPS/F4Q,#`Z(#4P,R!S97)I86P@8V]M
M<&]N96YT(&1E=&5C=&5D('=H:6-H(&1O97,@;F]T('-U<'!O<G0@,3`P36)P
M<PT*/#,^93$P,#H@0VAA;F=E('1H92!F;W)C960@<W!E960O9'5P;&5X('1O
M(&$@<W5P<&]R=&5D('-E='1I;F<-"CPV/F4Q,#`Z(#4P,R!S97)I86P@8V]M
M<&]N96YT(&1E=&5C=&5D('=H:6-H(&-A;FYO="!A=71O;F5G;W1I871E#0H\
M-CYE,3`P.B!S<&5E9"]D=7!L97@@9F]R8V5D('1O(#$P36)P<R`O($AA;&8@
M9'5P;&5X#0H\,SYE,3`P.B!30T)?4E5#7U-405)4(&9A:6QE9"$-"CPS/F4Q
M,#`Z(%-#0E]254-?3$]!1%]"05-%(&9A:6QE9"$-"CPS/F4Q,#`Z(%-#0E]#
M54-?3$]!1%]"05-%(&9A:6QE9`T*/#<^93$P,#H@0VAE8VL@<F5C96EV960@
M;&]O<&)A8VL@<&%C:V5T($]+#0H\,SYE,3`P.B!C:&5C:R!L;V]P8F%C:R!P
M86-K970@9F%I;&5D(&%T.B`E>`T*/#<^93$P,#H@3&]O<&)A8VL@<&%C:V5T
M(')E8V5I=F5D#0H\,SYE,3`P.B!,;V]P8F%C:R!P86-K970@;F]T(')E8V5I
M=F5D#0H\-#XE<SH@9FER;7=A<F4@04Q,3T,@8G5G(&1E=&5C=&5D("AO;&0@
M4WEM8F]L(&9I<FUW87)E/RDN(%1R>6EN9R!T;R!W;W)K(&%R;W5N9"XN+B`\
M-SYO<FEN;V-O7VQO8VLH*2!C86QL960@=VET:"!H=U]U;F%V86EL86)L92`H
M9&5V/25P*0T*/#,^*BHJ5T%23DE.1RHJ*CH@0F]G=7,@:6YT97)R=7!T(')E
M<&]R=&5D+B!0<F]B86)L>2!A(&)U9R!I;B!T:&4@3&EN=7@@04-020T*/#4^
M8W,Z('5N86)L92!T;R!M87`@8V%R9"!M96UO<GDA#0H\-CYC<SH@;65M;W)Y
M('!R;V)E(#!X)3`V;'@M,'@E,#9L>#H\-3YC<SH@351$(')E<75E<W0@=&EM
M960@;W5T(0T*/#4^8W,Z(&1O7VUT9%]R97%U97-T(&EN=&5R<G5P=&5D(0T*
M/#4^8W,Z('-E='5P7W)E9VEO;G,Z(&MM86QL;V,@9F%I;&5D(0T*/#4^8W,Z
M('-O8VME="`E<#H@=6YS=7!P;W)T960@=F]L=&%G92!K97D-"CPU/F-S.B!S
M;V-K970@)7`@=&EM960@;W5T(&1U<FEN9R!R97-E="X@(%1R>2!I;F-R96%S
M:6YG('-E='5P7V1E;&%Y+@T*/#8^8W,Z(&-B7V%L;&]C*&)U<R`E9"DZ('9E
M;F1O<B`P>"4P-'@L(&1E=FEC92`P>"4P-'@-"CPU/F1S.B!U;F%B;&4@=&\@
M8W)E871E(&EN<W1A;F-E(&]F("<E<R<A#0H\-3YD<SH@=6YA8FQE('1O(&)I
M;F0@351$("<E<R<@=&\@<V]C:V5T("5D(&]F9G-E="`P>"5X#0H\-3YD<SH@
M=6YA8FQE('1O(&)I;F0@)R5S)R!T;R!S;V-K970@)60-"CPU/F1S.B!#87)D
M(%-E<G9I8V5S(')E;&5A<V4@9&]E<R!N;W0@;6%T8V@A#0H\-3YD<SH@;F\@
M<V]C:V5T(&1R:79E<G,@;&]A9&5D(0T*23H@($EF(STE,F0@06QT/24R9"`C
M15!S/24R9"!#;',])3`R>"@E+35S*2!3=6(])3`R>"!0<F]T/24P,G@@1')I
M=F5R/25S#0H\-SY705).24Y'.B!54T(@36%S<R!3=&]R86=E(&1A=&$@:6YT
M96=R:71Y(&YO="!A<W-U<F5D#0I).B!"=7,])3`T>"!696YD;W(])3`T>"!0
M<F]D=6-T/24P-'@@5F5R<VEO;CTE,#1X#0H@($%C8V5P=&%B;&4@8V]N9FEG
M=7)A=&EO;@T*86-P:5]E=F5N=%]I;FET26YV86QI9"!D96)U9R!O<'1I;VX-
M"FYO8W1X/#8^6V1R;5T@1&5B=6<@;65S<V%G97,@3TX-"F4Q,#!4>$1E<V-R
M:7!T;W(@8V]U;G12>$1E<V-R:7!T;W(@8V]U;G1S<&5E9"]D=7!L97@@;6]D
M94)I="!%<G)O<B!2871E(&-O=6YT6'-U;5)8('9A;'5E=6-O9&4@=F%L=65F
M;&]W(&-O;G1R;VP@=F%L=65)1E,@=F%L=65#4%4@<V%V97(@8G5N9&QE(&UA
M>"!V86QU93PS/F4Q,#`Z('-E;&9T97-T('1I;65O=70-"CPW/F4Q,#`Z('-E
M;&9T97-T($]++@T*/#,^93$P,#H@:'<@:6YI="!F86EL960-"CPS/F4Q,#`Z
M(&-O;F9I9R!73TP@9F%I;&5D#0H\,SYE,3`P.B!-1$D@<F5A9"!T:6UE;W5T
M#0HL(%5$34$H,38I+"!51$U!*#(U*2P@541-02@S,RDL(%5$34$H-#0I+"!5
M1$U!*#8V*2P@541-02@Q,#`I+"!51$U!*#$S,RDL(%5$34$H;6]D92`W*2P@
M*%4I1$U!+"!"54<@1$U!($]&1BP@1$U!+"!"54<E<SH@1$U!(&EN=&5R<G5P
M="!R96-O=F5R>0T*8V1D82!X82]F;W)M,B!C9"]R=R!D=F0M<F%M('=R:71E
M<B`\,SYS<CH@;W5T(&]F(&UE;6]R>2X-"F%C8V5S<SH@)7,-"F%C.3<@<V5R
M:6%L(&)U<R!B=7-Y#0I!1#$X6%@@8V]N9FEG=7)A=&EO;@T*86,Y-R,E9"TE
M9&%C.3<C)60M)61R96=S86,Y-R,E9')E9W-A8SDW(R5D3&EN92U/=70@4&QA
M>6)A8VL@4W=I=&-H3&EN92U/=70@4&QA>6)A8VL@5F]L=6UE/#,^:6YV86QI
M9"!Q=6ER:R!T>7!E("5D#0H\,SY00TDZ($))3U,@0E5'(",E>%LE,#AX72!F
M;W5N9`T*/#8^;W!R;V9I;&4Z('5S:6YG($Y-22!I;G1E<G)U<'0N#0IM8V%S
M=%]S;VQI8VET=6-A<W1?<V]L:6-I=&%P<%]S;VQI8VET<F5T<F%N<U]T:6UE
M8F%S95]R96%C:&%B;&5?=&EM961E;&%Y7V9I<G-T7W!R;V)E7W1I;65G8U]S
M=&%L95]T:6UE=6YR97-?<6QE;G!R;WAY7W%L96YA;GEC87-T7V1E;&%Y<')O
M>'E?9&5L87EL;V-K=&EM96=C7VEN=&5R=F%L9V-?=&AR97-H,6=C7W1H<F5S
M:#)G8U]T:')E<V@S;F5I9VAW:7)E;&5S<SPV/B5S.B!A8W1I=F%T:6]N(&9A
M:6QE9`T*=&-P:6YC;'5D92]N970O=&-P+FAN970O:7!V-"]T8W!?9&EA9RYC
M;F5T+VEP=C0O<F%W+F-R87=N970O:7!V-"]U9'`N8SPW/G5D<"!C;W)K(&%P
M<"!B=6<@,@T*/#<^=61P(&-O<FL@87!P(&)U9R`S#0H\-#Y787)N:6YG.B!K
M9G)E95]S:V(@;VX@:&%R9"!)4E$@)7`-"CPT/E=A<FYI;F<Z(&MF<F5E7W-K
M8B!P87-S960@86X@<VMB('-T:6QL(&]N(&$@;&ES="`H9G)O;2`E<"DN#0H\
M,CY$96%D(&QO;W`@;VX@=FER='5A;"!D979I8V4@)7,L(&9I>"!I="!U<F=E
M;G1L>2$-"B!F86-E('QB>71E<R`@("!P86-K971S(&5R<G,@9')O<"!F:69O
M(&9R86UE(&-O;7!R97-S960@;75L=&EC87-T?&)Y=&5S("`@('!A8VME=',@
M97)R<R!D<F]P(&9I9F\@8V]L;',@8V%R<FEE<B!C;VUP<F5S<V5D#0H@9F%C
M92!\('1U<R!\(&QI;FL@;&5V96P@;F]I<V4@?"`@;G=I9"`@8W)Y<'0@("!F
M<F%G("!R971R>2`@(&UI<V,@?"!B96%C;VX-"CPR/D)U9R!I;B!I<%]R;W5T
M95]I;G!U=%]S;&]W*"DN(%!L96%S92P@<F5P;W)T#0H-"C$@=V%R;FEN9R!A
M;F0@,2!E<G)O<B!I<W-U960N("!297-U;'1S(&UA>2!N;W0@8F4@<F5L:6%B
%;&4N#0H=
`
end
