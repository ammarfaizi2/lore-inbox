Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264881AbUJEUcf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264881AbUJEUcf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 16:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264991AbUJEUcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 16:32:35 -0400
Received: from spirit.analogic.com ([208.224.221.4]:52230 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S264881AbUJEUc3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 16:32:29 -0400
From: "Johnson, Richard" <rjohnson@analogic.com>
Reply-To: "Johnson, Richard" <rjohnson@analogic.com>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, "Johnson, Richard" <rjohnson@analogic.com>,
       linux-kernel@vger.kernel.org
Date: Tue, 5 Oct 2004 16:34:59 -0400 (EDT)
Subject: Re: Linux-2.6.5-1.358 and Fedora
In-Reply-To: <1097004565.9975.25.camel@laptop.fenrus.com>
Message-ID: <Pine.LNX.4.53.0410051609590.3240@quark.analogic.com>
References: <1097004565.9975.25.camel@laptop.fenrus.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Oct 2004, Arjan van de Ven wrote:

> On Tue, 2004-10-05 at 21:15, Jesper Juhl wrote:
> > On Tue, 5 Oct 2004, Johnson, Richard wrote:
>
> > Only do that if you are sure your systems bootloader configuration is able
>
> > to deal with it. Maybe Fedora is configured so that "make install" can
> > work, I wouldn't know I'm a Slackware user myself.
>
> on Fedora, make install will do the bootloader thing automatically
>
>
> > Could it be you accidentally installed your new modules in the same
> > location as the old ones or that your initrd holds modules compiled for a
> > different kernel than the one you just build - did you remember to update
> > your initrd?
>
> it can't be an accident; the kernel source that ship in Fedora have a
> special "custom" added to the EXTRAVERSION to prevent accidents where
> people who are learning and follow a kernel building howto overwrite the
> "known good" kernel, but instead things get installed in a parallel dir
> with a different EXTRAVERSION.
>

Well something is going on because the module libraries are different.

I just reinstalled everything on that system and just did a `make modules`
again. I did not dare do `make modules_install` yet. I will clone
the /lib/modules/2.6.5-1.358 directory first so I have something
to copy from the recovery disk.

> If Richard overwrote his modules anyway he must have hacked the Makefile
> himself to deliberately cause this, at which point... well saw wind
> harvest storm ;)
>
>

No. I did nothing but what I reported. I never even looked at
the makefile contents.


I think it's a `insmod` problem. It did some kind of compare
which looks okay to the eye, but barfs.



What is this???  VVVVVVVVVV
>
> begin 600 winmail.dat
> M>)\^(@L3`0:0"``$```````!``$``0>0!@`(````Y`0```````#H``$(@`<`
> M&````$E032Y-:6-R;W-O9G0@36%I;"Y.;W1E`#$(`0F``0`A````-4,V-S,S
> M-C9&-D$P-$(T-S@R-C0U148Q-$1"0C9!.$8`.P<!((`#``X```#4!PH`!0`/
> M`"(`"0`"`"8!`06``P`.````U`<*``4`#P`=`!H``@`R`0$$@`$`(0```%)E
> M.B!,:6YU>"TR+C8N-2TQ+C,U."!A;F0@1F5D;W)A`#<)`0V`!``"`````@`"
> M``$#D`8`J`@``",````#`/T_Y`0``!X`4``!````$@```&%R:F%N=D!R961H
> M870N8V]M````'@#\/P$````!`````````!X`@8&&`P(``````,````````!&
> M`0```!(```!8`"T`30!A`&D`;`!E`'(```````$````B````6&EM:6%N($5V
> M;VQU=&EO;B`Q+C0N-B`H,2XT+C8M,BD@````0``Y``!O^I\1J\0!'@"=@88#
> M`@``````P````````$8!````+````%@`+0!/`'(`:0!G`&D`;@!A`&P`00!R
> M`'(`:0!V`&$`;`!4`&D`;0!E`````0```#T````P-2!/8W0@,C`P-"`Q.3HS
> M-#HP-RXP,C4S("A55$,I($9)3$5424U%/5LT-SE%,T,U,#HP,4,T04(Q,ET`
> M````'@`Q0`$````2````87)J86YV0')E9&AA="YC;VT````#`!I````!`!X`
> M,$`!````$@```&%R:F%N=D!R961H870N8V]M`````P`90````0`#`-X_KV\`
> M``(!"1`!````T@,``,X#``##!0``3%I&==,''04#``H`<F-P9S$R->(R`T-T
> M97@%00$#`??_"H`"I`/D!Q,"@`_S`%`$5C\(50>R$24.40,!`@!C:.$*P'-E
> M=#(&``;#$27V,P1&$[<P$BP1,PCO"?>V.Q@?#C`U$2(,8&,`4#,+"0%D,S86
> M4`NF($\E`Z!4"E`L(`'0,#0`+3$P+3`U(&%!!4`R,3HQ-1U02D4'D'`2@4IU
> M:`,@=]L#8`ZP.@JB"H`^'.<>`)Q/8QXQ'8$>H6]H`(#;`B`=4%(-X!/A9!][
> M'^B`;'D@9&\@=!/@<P5`!I`@>0A@'A`8("`><PAP)5`D\07`<WESO0ZP;00@
> M!N`?H!>P802!PB`%H&YF:6<(<!X@WFD"("2P!"`!H&PE4!_FWG0D4`$`!T`?
> M<&DD<"2P1'0N!=!A>6(E4$;["8`%L&$H$B=&"8`E8"15>B(`P&LE4`N`)C`'
> M0&RN(B<P`Y(?]7<%L&L=4())+@%U;&1N)P5`B&MN;P?@22=M'A"C!@`+8&-K
> M=R4R=100A07`;28@96QF+B,:_R?Q*I0=4"QZ*9$S021#)5#7)IDD<`N`9QX0
> M=2D@`,#W)]`M4"T0>2,:'^8(42[`CRGA)H`EHQX08V-I`0#?`C`UTBRV*[$E
> MPVX'T01ASRZP!Y$+@#/C<V$'@"B7]Q>P+5`GTV$$(#/R!O`BD/\"(`>1!;$D
> M<R7#"X`IL"*!GF@]$00@.E8%H&UP`Q!?*[$"$`7`*N`?YF0&D&;_!)`XH2\0
> M!)$P\"1B.N0]46TDXVHP<#?!=0,0(I`M^T$A.:,@&"`'@`;0-+(D4+AU<&0>
> M("B(/BD_(QJ_-[$M42[Q*F$#D3A6.S/CMT'5(>`(<&,E4"1S<S3P[G`ZPBJ5
> M$^!V2'$?Y![A\SAP*7$B8T-A`W`M,";P#P$`(I`I(3/R15A44@!!5D524TE/
> M3GTI$G`8($O@0:$X5@0@=^\T`!@@'^0>\&\+4"504("_)%`E,BAP"L`#`#42
> M;D`R?RT0+T$JX$'50Z,U`C[@=_4I(6]+X'(?@"FP2F)0Q=8B+R(#H&<FH&0M
> M,$'4_QU00Z`DH2S1*6!-T33R!"#^9Q0@.1DZT2K@"K$Y8C.A_&ER'^0IHRK@
> M03A.:C$K_DDDT"(V5.0?H3[0*"$Z5MT`<'DP("0@-`%M0V)+P_\3X#``3<(T
> M`2HP+)`G<"APGQ_D-/`F8##Q*11L:43QWT61)!$M4#!Q--)S'5`>(?=0@")!
> M3U!O"X`J`&6`'W#[,/!)\6$'X`/P4L!B!0K`ETO@0W%-,7(OD#LI-A\$"GUI
> M(```'@!P``$````=````3&EN=7@M,BXV+C4M,2XS-3@@86YD($9E9&]R80``
> M```"`7$``0```!8````!Q*L20P8]@SL_S4)#S:E(XE-@5FLO```+`/(0`0``
> M``(!^3\!````=@````````#<IT#(P$(0&K2Y"``K+^&"`0`````````O3SU!
> M3D%,3T=)0R]/53U-141%6$-(+T-./4-/3D9)1U52051)3TXO0TX]0T].3D5#
> M5$E/3E,O0TX]24Y415).150@34%)3"!#3TY.14-43U(@*$1204-/*0```!X`
> M^#\!````'@```$EN=&5R;F5T($UA:6P@4V5R=FEC92`H1%)!0T\I````'@`X
> M0`$````@````24Y415).150@34%)3"!#3TY.14-43U(@*$1204-/*0`"`?L_
> M`0```$``````````@2L?I+ZC$!F=;@#=`0]4`@```0!!<FIA;B!V86X@9&4@
> M5F5N`%--5%``87)J86YV0')E9&AA="YC;VT`'@#Z/P$````1````07)J86X@
> M=F%N(&1E(%9E;@`````>`#E``0```!(```!A<FIA;G9`<F5D:&%T+F-O;0``
> M`$``!S`Y2P9#$JO$`4``"#!.)MU($JO$`1X`/0`!````!0```%)E.B``````
> M'@`=#@$````=````3&EN=7@M,BXV+C4M,2XS-3@@86YD($9E9&]R80`````>
> M`#40`0```"T````\,3`Y-S`P-#4V-2XY.3<U+C(U+F-A;65L0&QA<'1O<"YF
> M96YR=7,N8V]M/@`````#`#8```````L`*0``````"P`C```````#``808S5L
> M"@,`!Q!E`P```P`0$``````#`!$0`````!X`"!`!````90```$].5%5%+#(P
> M,#0M,3`M,#5!5#(Q.C$U+$I%4U!%4DI52$Q74D]413I/3E1512PU3T-4,C`P
> M-"Q*3TA.4T].+%))0TA!4D174D]413I/3DQ91$]42$%424993U5!4D5355)%
> M64\``````@%_``$````M````/#$P.3<P,#0U-C4N.3DW-2XR-2YC86UE;$!L
> 787!T;W`N9F5N<G5S+F-O;3X`````[$(=
> `
> end
>


There is another problem, discovered on another system. If



Richard B. Johnson
Project Engineer
Analogic Corporation
Penguin : Linux version 2.2.15 on an i586 machine (330.14 BogoMips).
