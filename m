Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261832AbTD0Vo0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 17:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261835AbTD0Vo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 17:44:26 -0400
Received: from smtp-out.comcast.net ([24.153.64.116]:33031 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S261832AbTD0VoV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 17:44:21 -0400
Date: Sun, 27 Apr 2003 17:55:09 -0400
From: rmoser <mlmoser@comcast.net>
Subject: Re: Re:  Swap Compression -- Try 2
To: =?UNKNOWN?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: linux-kernel@vger.kernel.org
Message-id: <200304271755090220.025D0BF5@smtp.comcast.net>
MIME-version: 1.0
X-Mailer: Calypso Version 3.30.00.00 (3)
Content-type: multipart/mixed; boundary="Boundary_(ID_oE6WJtupPuiwF7HfQnBuPA)"
References: <200304251848410590.00DEC185@smtp.comcast.net>
 <20030426091747.GD23757@wohnheim.fh-wedel.de>
 <200304261148590300.00CE9372@smtp.comcast.net>
 <20030426160920.GC21015@wohnheim.fh-wedel.de>
 <200304262224040410.031419FD@smtp.comcast.net>
 <20030427090418.GB6961@wohnheim.fh-wedel.de>
 <200304271324370750.01655617@smtp.comcast.net>
 <20030427175147.GA5174@wohnheim.fh-wedel.de>
 <200304271431250990.01A281C7@smtp.comcast.net>
 <20030427190444.GC5174@wohnheim.fh-wedel.de>
 <200304271752340880.025AB0DF@smtp.comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary_(ID_oE6WJtupPuiwF7HfQnBuPA)
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7BIT

ERRRRRHHHHM!!!!!!!!!!....
...*blush*  I should attatch files when I try to upload them.  Let's
try this again!

Well here's some new code.  I'll get to work on a userspace app
to compress files.  This code ONLY works on fcomp-standard
and does only one BruteForce (bmbinary is disabled) search for
redundancy.  This means three things:

1 - There's no support for messing with the pointer size and mdist/
analysis buffer size (max pointer distance)
2 - The compression ratios will not be the best.  The first match,
no matter how short, will be taken.  If it's less than 4 bytes, it will
return "no match" to the fcomp_push function.
3 - It will be slow.  BruteForce() works.  Period.  The code is too
simple for even a first-day introductory C student to screw up, and
there are NO bugs unless I truly AM a moron.  bmbinary() should
work, and the function it was coded from works in test, but neither
have been written out and proven to work by logic diagram.  It's
fast (infinitely faster than BruteForce()), but I'll try it when I feel that
the rest of the code is working right.

This should be complete for fcomp-standard.  A little alteration will
allow the fcomp-extended to work.  *Wags tail* this past two days
has been fun ^_^;

--Bluefox Icy

--Boundary_(ID_oE6WJtupPuiwF7HfQnBuPA)
Content-type: application/octet-stream; name=fcomp.tar.bz2
Content-transfer-encoding: x-uuencode
Content-disposition: attachment; filename=fcomp.tar.bz2

begin 755 fcomp.tar.bz2
M0EIH.3%!62936?80L;4`()5_K/ZX(@!________?^O____\"```0``0`"&`G
MK[P'N'C>X^U]W=-=SGR]7G=?30(!2E0]L%1\]W%WW'=@N#ZM[WWLZ][8KPOO
M;([U-W>^VVX5V][Z`;"MVN>WT%9M+KY<)5?6/9+[K9V;6S>H[';*V#ZEI][G
M>`^WU]#Y=:9N$D0(`!!">A-,2-,E/VH4]3VIZ:IZ)^34FGJ::9/2/U0]0V4&
M@#$$!`B:$TU3R8D]1Y1ZF$](-``T``````!*8DBFJ?JG^IHU)Z:3U'E--!ZG
MJ!Z@:`:&C0``&F@#0`"%)$IA-)XJ/!3TU'DGE-/4]338HR>IM-$T``T``!H`
MT$21"F3`(IZI_JH_U3U-J833U3QJGDF(]1IA/28C3U!IH>D-`/4`(DA!!---
M&IA%3\R4>10_0H\4?J9/5&@T`::-`-#)A&#\0^']W[.KK7=_\95`[E8A=S"#
MR,'=4WQ<0\JM14$L9^VVDYT!J[8@&4!A!8GFI"$""2$S1*9A(=PTAI(0W;('
M(0+`1-U0.>5Q:I(IJE:J8HJ&2J2J(@B8F&1H*2@(AJ(I@EB`#_,J9#39F514
MT5,E5K+#`A&AI@(DB60A":$BIB0HF@B*D7(<!@EB2"$EH*)E+P0`ZH12!5'O
M++ZC^N<[7N_QI?9-TS_"7C[=.WVUHMM]I:M)7W1L\Y^&$9U[^QS\IE>3U-V\
M=OX0_%^/E,32S#+>V1G^.4YRM-/9.L;/2E5N!)F@B?-=6T/4X]Y-Z8]3\WB?
M!B5!FIJXURZ(`X>9UFR)UL.U9^P<T8)98=/\'7+=V54.GB]J'>D-:MC^F):1
MVA)1>G/E2%DX?'1'BYWSHXS+W:,X74O%N&C;5=MH";+=RLI/#,$,J$(4)<V%
MI'8X&0A&-QW*UTA)I"#TU+]]*.R%%AA">%3QMN@-X;1"OG08E0P/\\+*&H@4
M0\E6+E!QK3$`Z6UI#PU4>_&MQG>Z.ZO6VK9CV[R4MGY[UWFH]/I<[GV9J0;1
M@0A"'S^F[T?DRLAQFO,^?SF"&WY^_)Z^XI;P35Q_YLB=HQXH=@3(F-^L.J[$
M@5X4\/#FY<N73]<('R,=_7@,Q!2.KCD2Z!AA>5EI4%32U'R<?BHK5?O7$4DN
M5Q^M5+N3JM?/3VTB%]87S`(D,]%EAA-THD(PD8PE6_QD]W+VQR#I[3T6SS1I
MU!=[8'LB^'/QD]`G,(@B;,LK""8""J;8@J<>+];7Z1Z1NV,86;-6A)35$@2Q
M9M'5'@YQ7"I:*:/8#,'JJ\J.R04#9I5@IB+T>C1L!6$CJM')M,](MOBC34M9
MF.H?'PI;/<[MAMQY16T0*@<"!5FEH(AF-R]E&1ZM*[\"[9$PO;+(S_V.G?U+
MV'/A8-1COT0^]&Q9Q$L:F/[+>ZQ0A@3/%!:\:@PA_42AR?L8O][%=KW\>8$\
M*:3("'?7L**B'B#I*&Z#8:.$_7+^3OD1)./,>;7>MH?=&L_66!!8$#\VE;2'
M,YAMXWT7L^8Z^PN1VD"H>S%"WA<@P8B#8A&<L-2&J)#4%&H+1EI05$M!*(,A
M1X'?S<74>)T=3QF9CVVG-D/DDAZ'M\['MC?5$(A"217$@OHS'\;+)>8B+O,O
M&%JD?&VS&=BFU01':;44ZCR6O7,@<K=[54F<&EH_FR[_H\?3AS=A9V.>0DR<
M46GNH034H>;'U:O@35M*OZ,"7]+L@1L1#]O+&[0&T>(`3A,XRH+H93=K&WK8
M#(183L_*\8!W&YH/HO(<X5,#;$<FI-BD'*R>I66EBPO-Z9F3,V_[!Y6]1,#N
MO<,93(]7U7#;I7\+I4S;C8+3N'^)C&UMQ%V\PAX7NXG"(=YV.5,#,=UW<_JB
M\_/#(JSK=,P**ZK5S;M$AIQ*(0"T.,.39^BQ^$<ZZASAE8D3?2\.G1!W(C#)
MJ[,F=:ZYMAL3#XST8:H)+P%_(;5!2S$$DT<W1AJM=C;;QD:#'C'TO(;1*T,#
MO\-M$JT(&6:4#?+-,]9ATI72,:WDF:[>W9Y84.VS#`K:_R7:JZ46F&"F)K36
M]Y/N!K]U8M/#NY8"H*P#4'&L$*@O2V_+`\P@%@QJ<*V.!P:Q+&6*W%3B$G3I
MX8^9NJL30GE>P6C.[U&FWS3@'P:L%.--=?F>I(+OD=][]`QDYZJ_0B)XJ_IL
M>K+JADGK3</T`V;])@X,H+X5;<>/[C/\[?]Z^Q>Z=)*L4)+R%%D*S:?VMUAP
M?KUYE7TP$'0DP=D:5[H9S!<^5Y=^>=\UUN%-7M$.P0`6TW'@GIQDG(&43%2S
MC)GAB:JQAJ2-,&([LO5=_J;AV&OM#*`LOK=+:-3Q<76JJS9M;L'+L@;88=?3
M&!"#`NP<`2](C3.FP4#JIN'%;M`1V;3>ID:!+47.+(='.5UH(<O>]WJN0PXA
M@G.K,.Q'<X]#BA4',E#$&X%V!KOW=?R&Z^@T-GL`D+.&]*'C4'9&?W7GMO3K
MBE@<1X4X<5!13X9V*V.^L7,JGKIOLP@]@:^,OL(15A_-9/[\[^9`/T(^L_CD
M=F<TIL$0@0]A&CD"#-BX;J;WQOCH6P63:-P);7<*VFZJC3Y>>3@M6*QRCZ0(
MH3:(;0D&+0-*/`UNN59;C<I7^E9<[=6^7?9=>WM6N'K\M:,^;#.BJUHM[OQQ
M&<'*EV'>A7``P'?5=/EP44W$5JDV#I\N#+#Q^<8TG;F^$(A80$T3N4H^O=)$
MY&&ANG'OE\=`OX.^YR"6CA5;-0A4N$(6V0NG#.-](N829%4.SK$4$XF/&=5%
MF9LKV+Z5'FR@.A!5LCB&$3Y*=$_MS%(<+9(<KGWN!C=NE+SRI]0.N&'*I19[
M.[ORLR'@YE@*+"X$7$I184JC;'$[12YE=PR.6:OE^?+(!H&4H<0DNJ^D&--R
MJ2NS5*8T9/51!8,%X(::Q?E[/=2O7@1Y;=>GL6V[)R.&\E;9&@KZ,Y\]-<)&
M"R3+9B]70D%R89EM4>*UVN3V3R4<Y3%G-SMCM`I=@4Z.B'<**^7KO8@2;![=
MA$&3"@#N!W9I!;>E'(H/((K2NT<Y9O/:_@IWJ%%2Y/MJD=)M8IC3H<B(O(/Y
M+(4U&KXYO9;)ZH<#"6D1A,Z;BMF@59R@L"F[FH5.'JK&)Q@K,X!L8O>H+0)>
M&/B0FD!KNX3<T^AN14X>!)'GYZ1[%P7!-QMM<>79L[^;>V<5ZEMP^34UYN;5
MOFG*1;QQ*.ADS3$J0'\$3(",^3WVN+Z.!T9CXL7>M&:`44-\,<N(EB&'2M;<
M&-3NRHDA:BH./<%%IKE3L0OM19%63+:>-H'BJHW&\RB<"5Y0F*1@V6]^QGLU
MAQPK<Z544"GEKX@:"U/"DA\2C=Y:3LPQ):%;;22D`PI0O(EZ4/;9[%5[YO;4
MW&*%)!B$;5XZ'/?CH4=;:I.L?#3%`=G#OM4;JQZ$8\[$-WVUPQF]^6<@>"%U
M^CNF4$U>K5\[YL>Q7I5@-K&N`NI3AE':<C-T>96;T-CH+1\'::]ATTUQE]G.
MM@IJ[/2RVFHOUUB`KW6;0E97/KKT"BOEYC>14%>V&+;2AL_#8.5>ZS&ZVS<5
MH.9HQ2&.IA>\J^@KSC3'0:,6EVS@#3IHZHM)Q=B&=U<3+*>.6N==V&3Z679R
M+7Z5HU5VKYU575V)[X.-S5.LF'B]]AMC8_#PV9,R0F8%%'38:AV%ED[FK]A]
M;!QY_\RN>YO9^`]UA9;TWP_'$P87YC>0('S'ML^-H3#Y;&)\JL/X'7F,%\5'
MG+!:+S=^>S"3BQ[8<>IIM$[0[<QZ"(?#''M=Q,LCO6#$'&/1)%U>..40A<)+
M@0A<$(11STFV#'5#`'\6(X";(O3"/"-$3=408/6T`U"E$C[M'-(P9QG&#F]9
M^:WZ;UZ3U3/:Q\IQZG@>O^6+0]YAZOW*N6.L/N8K^X4SW]CF+>W4.C4;7A=M
M>5DRPD5C*)YG*<[NW.];?JC2[HJGT5/>LY=)OL^BCC)@?C4$[]K7&Y/<;'8=
M$H#>NCX%`QH$7#A@X0#%%-3ZKWF_N'U"IA6!`Z/*AL6@-A1"$0(&T@42W#EK
MSV#&DZD@4A1XR$.O"4#*/+YN^=<3#*#OS,OB\HM=PHHG1JU8NI.@E8'$.&FU
MG)I[O]NFS+1-2WC[[5YVQSIX?8_Z%3@M-/"V^Z8D0_#-R%LDC.SXNZ@<6RJ!
M4`@R!_IMC]0GRW@[\]6L'&KQ<I629]>&?WNI[U.'>ZEJ@/21)<4%.;W#^($`
M?'.HWIJP#B/L.18ZM.2A("2J&0:JA6HA*I#L(9W$SNA#.Z%NPSOKCJDLU\WJ
M@([<M_Z*K[>+9<)R,8R@;V@[W<93WF;^^G1!N9^FZT;@[45[=6=(>FANRK8O
M5RHG)CVZ6Y8%I@/>6E:VQJ)JX+RG)I-J0(N?.I*1F%KPMU6"\G"K9/J^4++5
M,JM],HA;ZK)APD5LI]/1:L-;JP9LZMLMEBI4+\:E#'YY*)+=!9G./J8S+GQ.
MJ8QD@,SV7[E6X![*Q[=Z^.=@9,(A`B!\?EH>1@\H3%1$24E504ECA'\"P]`2
MX%,%1M'YH#"=23$0,03!DIDQ%%4&29!5`T41)31$$0)0TE"5D9F9%''Q$8^W
MV.XCH^&!<A'TN(]N1I2\_-=X@Z3X_OS(,8V9:]V*9D'?N;I/ZTD##!,+_L&I
MJRRA0B?WJ^C`H/:KWBA<.#QJQ`@X(&7#@8?1@AP:V/93TYXV(7#U8>G#3B9$
M05^H,7(CICDZ`%<3$R-UF:FI.U.'M(%`7EZC+`2P+(D,#"$6"B34%;!5-2HG
MG((C:A$&!H$\FV+P+?#RG:XO1VH@ERUJKEOT_$Y)%S(:7"_.Z%C\C!,8:>O&
M_NWC9UY`WE&L?N0TE'SS)?><M#.%^$=0U:):M)EOHPU/R=X?#M9.D5,"AC,,
MK/HVR=KS&!742(+8:&+1[K(?V"9<X9&I]I7IPI>KS>:<#"=1H?20(!'2\N>/
MIZ[]*7N,M-N05'VQX9CPA;!\G`NKA]8AUVYJ-^=.1C?>1G?A`Y7G6,AF7:7`
M<1N911=QL-JR12HS^FYC9T`)]'A*/H*2K5*0&3Z4_+?HNR(XD((HR$=(27&H
MBXXJ*,[;78#7O[/6[F-WWAG0IYQ/812+T@$='<E\.S$]"_:>;\C^\3'O^13O
M%][N![[$//$',/G]&Z_T^-=:L%+!"#V?.4P#Y](V`@R,/B'E'_.T<Q@NN#(S
MDBZ!W^GZEQ4R8]9#)B/F(0@>\^9*>"P3;[@</-%?:._(;0^`PKU11-X,)I=)
MT:(Z13%@#([4J)!-ER"T.8]4'T]/[*$UJXCG&(&#X;S_1/A3C(8^43\@/6#3
M]#C>6$D!/$>]YG%7JZSK?+S$'O4-%[C:IX\_(>U/PF,,`^6')AYHM#'M=T&G
MD/0MULN'[[D(43IP.!W$*@A<>J6KC1<>T=$HIC4$J+4IE0<<!*<K4A<8]"3U
MAM8?@NFQ\5>1:226=%@1!L84_/@KR5:MTW-O-[W>CJ'NF+P>UZ`S-ESUY&[+
MX*-6X8R><,E5+,AIUV7@<3[3ZX?97<>#K;J]U\_XQ\9A0''HYE+(OS(^<"41
M[H;<TP&1F!B8L';P,2D(D)J@I<S$=8^7;9TA\"1#?$8!^GZ_N/:5S1[-5%17
M,S#X(5LJY104>&4?)6>9LK*-GO:-#GS`1UC#L6-ITT>M-_S'^]#@EJ3)QC`8
M!26?VP+T&6.`93D'$07;QI-F<U3LCH#$M`:&+P0+1-T&XO**!E"P,K&*$2M.
M5>Y?X9A,C</8%8A;%C."-H(+%8Q"]RV:/*A['4W10V3J#";=AJ%H-1IXBB5L
ML9S4/&/J.9.,D76^>E]96,,S#%CQ4$JS";.&:$AQ$K6:IYP/JBJII/*E`BM<
M#"ER<QE#(.$)!\6\GJ6MN-YQ0.$D0D!\T:B4"P$'JXX+333<R=)(1)_CXL&4
M4]<?3M-;*.\TH"@@[$-KY!^<+C<^(H#`J[*1D/IW5=W.2"^5_-![.0ON+,S+
M@CA(025;5]<"?:`%K`!&&LC@!Z"S4I"3@-2@:7^!P&5RYLE*OM@Q6*N(]_^7
M*=/EVEKJ.0X`<9U+,57JG3@DD"2*!ID#-\W#-M`:*_C8@(!!(`6,ZH".B02M
M)>@,-:8@PD,$[8!Q*91(K`@<DFAD99ZW-A",W1H)U.H-!&8.:A#9Z@'.G`B(
MJJ@AH)@FHB)FJJJI!B(@B!H)FJI)J9A)P)G34\FL=F'UPD*II(AWVC,WY\4Z
MPQ$<)31H_7H=/U9F4G02@WNF^UX26H-FI5R`6T=:TS31J,#8L,M2AJ$U*]ZX
M]@8D%(ITAY+""[U"S%*U%#>&T6@&W*6ZO#UL`/*`GP@=?9:VFPX=$-U-B._"
M(XI;0!-=*:B_UIU-2:8'W1SO*')HZ'&P10\'G$I>SBCF"Y##J<PLH)0EY8H@
M'@^5G=DP1WL!XL&3*^9Z4I,CX.A$4-L28'F?^9]?H^2KLBO*/50S/P[@5U$,
M$]L-9B2P\7R9#4!PH]%)"(K8"RP`KIM'77!SBP-1CD;FX,ZD7A$B4`+H;K`G
M&()<BVKN:!@1KJQ---7)A#S2,>:*P6&J,MN=8.H`;@Z7<<&^*S"L60;=J,_'
M$B?C5?9`&^K'2^@?(<M/)B!5$<T`TRY.R@5+`9AZ:TH;HABI0(&*1O9A&,\&
MZ,@,M$7U-*FDM0Z30\YB&&-9JQE,9U%=S]C.A5-=802"2"28EPD@Q%D4]TXR
M79.FQ;FMZTK-^5P(&$;I`3%N]:S#DN8W&^@+.N20(:XN,^*"@&MYK`/DPI-'
M'DG3!\S]UZH(2N^VBK]@F&7BX:5-K-X)\@)+A'Q*<+XA.#N\J]T-T:4J81`3
MWDUFE8)DE&-_M9$N1^FQ!40Z4&80/J(B*?SX\UO.]J`F:];>Y'E/0QO6[-E_
M'`-.)R>4XP#FG%)A.SLS(>(4D@ECF-JAPCX)F5[+F2G4L6,P[ISJ%Y:S;U/H
MB=7:GOSJ0:=CJNKR=]1Y-[N&#C)D$&9`T=A!*>7@0R(22GL8"M9<NA6&FK4A
MIF]OLM%#RJ@SB_R-*26>>I'`=_(*'*#B08(H/"]0#LXT@*C*;`H,&VHPQ%A<
M3'@G+`62`Y]52/+6T.M[=X89V0)*.XMM$,K[MO*(.L8O1VM,L!O`80+A`2\7
MVE?)<VG`W'/[<H*HJBJ#2@--*3X.FKW:21;BH&HUA!`,""5`8"0E3=B4'*$V
MY7:1J(`:CE7DA[[G_<;;_6EFHR)*A"8#C+,/N<,,OA^K^K_W)\?`>*"AB4Y5
M*H*V;0LM-0B%"7A(A]/=CL\8J<CBB=;SL%[.H/6D^J#[Q#X!<QY\+Q#I@/PG
MS0+@LG3I2,0B64@.X+&I"=5SM.J@N[A4D!Q*@!*MD2KD]94+)QR>01HL9EH)
M1*"E\['0`T8F<&D6Q]KQ3XZW-6.K)AXL7&J9VS%AABIMM89&]H"^+2G=+534
MP9_@[$\"R%$"$#D6+PYWYS$9/4P8$6#3*86BH'$JIMT.0)0)IVDBU3DO.ZQ>
M<9>3(/"5PJK*R18=7ETKF+;[N*I@>79-WVXR=@Q1U*A!4*,BH2<_&X:&C6$S
M()K*"1AS@.LM,7`N/TV[YSM=31P>H2'%$A$M$,R3%+LD&^8X%8IB<9F-TW1C
M@O.Z$L%+#&T9`"@D0.&$U\#0LM_E;GAX/JR]'I30'1G<7#6(<8IP@!EIBA'0
M^[I=+;6>%OI>MUXNBG09'#F/T3$ENZC9IL=AQCOB),Z"MX)/=P9.0/=0+'4A
MB'UCESONY9$+AJ+B,4Y1,5<S/O4(#"\!U:]>VH<6%!ZXHJJ%U`:CXIH>@(=/
M+MWD290X81OVF`JF@(0&@"$*+#W0(76BRPQ#,UJ(3@"!<Y]2/4*8F(GH`]HS
M7%EV1^MT\=<##$"@"C`@PB$)(D)HJ22B&`H(^1F4]/.`TI0#YV9J28T&T'JD
MX?<*Y1+D4N16H,@.-#<ZG>!T0_;PUWI70ZF>G;JSIR<$`(_M-(AF/F3M84GK
M(+&)OO="&#T$DT^!3N-Q-E<;SZ"G67=M(%H;:H;$TH)ZRVAE`ESYC('K=F:^
MYRPA:Y+&$,U<IG1P&7.S8M:DPLFJ"1:AF>ST'800A`K;LQ\S(2'NG>6.J`;2
MQ<,MR<[>BX@R@4]V>)QTDN[:<.+9#CFJ;][!>QXHAX$&$.OO.@VH&<+OV,AO
MP6D+ISZS./PT9:S;681@9IUI3H@S95TSIV9,5N!VCH,Q*,S',*,,SIS`/(SA
M#L4.."X/RC(OUZQB;F1<Z&KWY0V3A8[^M+YK*\D=)=#9K3Y+%SR&TW=MOU`;
M+MLSR!/7\5K<J?7+-%)8AZ6@S4Q`3F'$IV1^.=\+0B$0RC4'VA$/4$1RS*#)
MRH2Q%3!*;Q/=^,T6#A$A/W0-URA,ZTTIX9F.</5&S`G2%5D\#B:[MN0J]2>#
M&[)R_"TF$"!"ZB9D3O8J+KJU("UUP,]YH%@P;(84E3JCHJ0\`00,):FH@CP6
MFQ<[E`DZ*K':S(R<M]49KJZ,-5NYN-4Q2`3RNG=XD(KHLO;@&%TA<0/7,TL4
MZA`AL,%CN)#*PP,;SP+B&D7`3.#(G,.&G`F3'0=^V@*V9,ULM(8:!;)W(TF]
M;$X#@AX];.G;$W))/99+0+9QUU2OE(P-=2'6L61(-P3&`R2(L&)F53JBX\SV
M7#8G`&4!O/P0FO1$XF[*1#:]`P'=*8>#`?-,B!PAF.KO!W@8LRK=,^PJB3OK
M,,91`B!`CJ!P*(MI31E\=7Q'?FQ[O#GIJ5-GY*.<2`=Y#6V*=G;AIX<'-L-M
M!0[239)DAI$MF_6VSC'(F[/.;#VJ@Q#F4*U9/M%@D8AB=;[T3D<E%YF!MFGD
MS>5,O&>Y%9%(1C`60="&O5S/K6;`WY5L>.&S;%"7,54,(H#M)SP53#OG@ZWN
M6G?SFC(NK?"<0<V$.+BJE:02:Z_G*(?@YX-ZS]3.$MF=Z[R*\D4+V35!4`]6
M/19(480F0[#M1H`W&Q6#0R@0G2[%;P*5(?F3JJR!SPF)4R3@89KD*\B,QU,4
MYT"N@P:M@AXC&\"N58>8]0XY>XB..I%RC*2&7-G0<FXGR?],99&58(:6H.D#
MM90)RW'R;P.Z2`P]%-0#V6UI\,ILEFK`,E377Q`:-$HG,>F#UAO(Q!^"R+D7
M9[A9\NVXV,^#EY0VB3S0'B8S(QI]B,O?G#::9/9T&FKE8Z>EPS(,'KFF+S7<
MQN2\^\%&B,6"P#O](1E@**A1)R0#XN6ZY",+D"0B220>"9C"D-B#F03.8)E5
M%$4)5ZF%.$-21I@,"(FG`20R4<SVT8^3XOCTT&`,G!#Z24VA-VKK>U-[_40#
M6%HVQUOL33N9=C#3KK)WSO+C]`[=5)6Y478%1G,]Y[@!83.\M+OU5RQZ"R#2
M;B0;QD&H2#"#%"P$VZ'"_M<%L='5%MVD9`-+,:&-P0D)O&D&@U-\,N@&G:.N
MVW`V/TCL1U3:=F^#DUBBH`2-\*:\O8F3F3%9AH&Z=\87J\8%E/1S&[N9<@Y,
M$@RXPI@3MCTOK&NH,;MM.;AHL0$NP[BUZV&:UI`:W8=B^2HP"UGR<C7(%*'Y
M[&8+H.K1#?04[*Q5(6,5?0OI<UEB&A#0*!#H!RS6458NGU@^?5JY](K>0;[&
MAQI>19$:^S07QN:7(EN;T-K272"N4:K(%AC5L!"UXJ929!AW\P]$(&]//Y7]
MTL0,C^#8<1YPIA4(R[FJ5POD;82&\"Q0&_HIMTM)-NC+!'``H*BGGS'8YY,\
M#O@V+$Z^B2!8QB8`**AUO%[L;YG'4GJE0WL/;--?-];5PU'!``VC?%T'"%4:
M5PL5RI8ZD5VKHE;;)5TC&)EJ"IE((&D!"5U%NIQ:!?7<F0,@I`_#)'RVRME&
MH(:QXT'>@\PP2C<0H-L*4O2^`+(5")[\:"`&#C7-F*A#38[INX.`\&)8XEN6
M5N3ICY(&>,O`4SAA'85488TX:$0$4$JU#'&%&/.M//GWY!KY+V-PM`4XW;49
MUHA`0%P-"C1ZL8N%%`AKC0M4@L40+T%/2V#B)TJ'1$+7378XJ$+Z[,K@X0"3
MI(7T!8`F$VEZ0'$L+A5O2Q?0:5D%\7N&I1,FI:"+HYD&B6C':]$`,:8.2R$5
M6'">HLT6@279JY<"B#X>3I,/!5E%H&82=RU@F(G+Z!P,A)%DD61`02,%N%2F
ML7D@THR&+#UQ0"!PJ8LQLA8TDP8,KNRV>%J8``8@QNFS.]@*Q`H6!G%)!7!:
M#!`,$QF!@-Q%7U+0!H4KF"Y=2MV)648#*);AIC#?:KE@M%'U2HI(KJ9[LY<'
M?NS8BZ\QJ\*'(]9IL(QQ#`@YI-A0[$J=F0(P0)!$]WP*`=`Z=;(6ZH7C8'2"
M&'?34`B;EW\!87.BL7V0HY3.I'E?.SU;ZOL`"#%4DD`PNPHA?2Z'(N/OD(L@
M`N<`,ZQ;=NTQNIQ&\RX46RVAN579H&XY$'4F^[[&I34G*1#_1WE4?!`3+.U<
MN:#N.DA1&XZS),_#OL@GM0[%+.SGUO_3=M'6&S0-R?(W`*GRD#5L<.@+$<N:
MJX/5%CGNJJRHI7\-5L54?\",;,#`>U2-LJI(HW`.(]KUVRVK2&<OX;K8C:BB
M$IEH^$)(0PL7LW`X7X=XP,&$$C(,B1"!?0'F2@=\<H'+*B$4+.A2-B*0@GY=
M:;!20#?[Z"E]71E_TH7,\@2Y[@(ONET!Y'>@Z._1J33G`".Z5G)2`<Z<HB1F
MZSX[.C;(L]60Y@B@0'*;5<BDK6HJ1LX>QO5MI5C2M\LHT9]F<=B@Z^8`#(.Y
C>GA)`"1)"1B[@0!^&3Q4;`NT$`3!H=(?_%W)%.%"0]A"QM0
`
end

--Boundary_(ID_oE6WJtupPuiwF7HfQnBuPA)--
