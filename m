Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263413AbSJHOAJ>; Tue, 8 Oct 2002 10:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263362AbSJHN5d>; Tue, 8 Oct 2002 09:57:33 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:3221 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S263315AbSJHN5I>;
	Tue, 8 Oct 2002 09:57:08 -0400
Date: Tue, 8 Oct 2002 16:02:41 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [patch] Input - Change extra key mappings for MS Keyboards [22/23]
Message-ID: <20021008160241.U18546@ucw.cz>
References: <20021008155003.K18546@ucw.cz> <20021008155045.L18546@ucw.cz> <20021008155125.M18546@ucw.cz> <20021008155236.N18546@ucw.cz> <20021008155651.O18546@ucw.cz> <20021008155825.P18546@ucw.cz> <20021008155915.Q18546@ucw.cz> <20021008160001.R18546@ucw.cz> <20021008160100.S18546@ucw.cz> <20021008160148.T18546@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021008160148.T18546@ucw.cz>; from vojtech@suse.cz on Tue, Oct 08, 2002 at 04:01:48PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.
'bk pull bk://linux-input.bkbits.net/linux-input' should work as well.

===================================================================

ChangeSet@1.573.1.57, 2002-10-08 10:08:34+02:00, vojtech@suse.cz
  Change PC-keyboard mappings to follow MS Keyboards - a de facto
  standard for extended keys.


 drivers/char/keyboard.c        |   14 +++++++-------
 drivers/input/keyboard/atkbd.c |   10 +++++-----
 include/linux/input.h          |    1 +
 3 files changed, 13 insertions(+), 12 deletions(-)

===================================================================

diff -Nru a/drivers/char/keyboard.c b/drivers/char/keyboard.c
--- a/drivers/char/keyboard.c	Tue Oct  8 15:25:10 2002
+++ b/drivers/char/keyboard.c	Tue Oct  8 15:25:10 2002
@@ -917,14 +917,14 @@
 	 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79,
 	 80, 81, 82, 83, 43, 85, 86, 87, 88,115,119,120,121,375,123, 90,
 	284,285,309,298,312, 91,327,328,329,331,333,335,336,337,338,339,
-	367,294,293,286,350, 92,334,512,116,377,109,111,373,347,348,349,
-	360, 93, 94, 95, 98,376,100,101,357,316,354,304,289,102,351,355,
-	103,104,105,275,281,272,306,106,274,107,288,364,358,363,362,361,
-	291,108,381,290,287,292,279,305,280, 99,112,257,258,113,270,114,
+	367,288,302,304,350, 92,334,512,116,377,109,111,373,347,348,349,
+	360, 93, 94, 95, 98,376,100,101,321,316,354,286,289,102,351,355,
+	103,104,105,275,287,279,306,106,274,107,294,364,358,363,362,361,
+	291,108,381,281,290,272,292,305,280, 99,112,257,258,359,270,114,
 	118,117,125,374,379,115,112,125,121,123,264,265,266,267,268,269,
-	271,273,276,277,278,282,283,295,296,297,299,300,301,302,303,307,
-	308,310,313,314,315,317,318,319,320,321,322,323,324,325,326,330,
-	332,340,341,342,343,344,345,346,356,359,365,368,369,370,371,372 };
+	271,273,276,277,278,282,283,295,296,297,299,300,301,293,303,307,
+	308,310,313,314,315,317,318,319,320,357,322,323,324,325,326,330,
+	332,340,365,342,343,344,345,346,356,113,341,368,369,370,371,372 };
 
 #ifdef CONFIG_MAC_EMUMOUSEBTN
 extern int mac_hid_mouse_emulate_buttons(int, int, int);
diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	Tue Oct  8 15:25:10 2002
+++ b/drivers/input/keyboard/atkbd.c	Tue Oct  8 15:25:10 2002
@@ -55,11 +55,11 @@
 	252,253,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
 	254,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,255,
 	  0,  0, 92, 90, 85,  0,137,  0,  0,  0,  0, 91, 89,144,115,  0,
-	136,100,255,  0, 97,149,164,  0,156,  0,  0,140,115,  0,  0,125,
-	  0,150,  0,154,152,163,151,126,112,166,  0,140,  0,147,  0,127,
-	159,167,139,160,163,  0,  0,116,158,  0,150,165,  0,  0,  0,142,
-	157,  0,114,166,168,  0,  0,  0,155,  0, 98,113,  0,148,  0,138,
-	  0,  0,  0,  0,  0,  0,153,140,  0,255, 96,  0,  0,  0,143,  0,
+	217,100,255,  0, 97,165,164,  0,156,  0,  0,140,115,  0,  0,125,
+	173,114,  0,113,152,163,151,126,128,166,  0,140,  0,147,  0,127,
+	159,167,115,160,164,  0,  0,116,158,  0,150,166,  0,  0,  0,142,
+	157,  0,114,166,168,  0,  0,  0,155,  0, 98,113,  0,163,  0,138,
+	226,  0,  0,  0,  0,  0,153,140,  0,255, 96,  0,  0,  0,143,  0,
 	133,  0,116,  0,143,  0,174,133,  0,107,  0,105,102,  0,  0,112,
 	110,111,108,112,106,103,  0,119,  0,118,109,  0, 99,104,119
 };
diff -Nru a/include/linux/input.h b/include/linux/input.h
--- a/include/linux/input.h	Tue Oct  8 15:25:10 2002
+++ b/include/linux/input.h	Tue Oct  8 15:25:10 2002
@@ -332,6 +332,7 @@
 #define KEY_CANCEL		223
 #define KEY_BRIGHTNESSDOWN	224
 #define KEY_BRIGHTNESSUP	225
+#define KEY_MEDIA		226
 
 #define KEY_UNKNOWN		240
 

===================================================================

This BitKeeper patch contains the following changesets:
1.573.1.57
## Wrapped with gzip_uu ##


begin 664 bkpatch17864
M'XL(`+;<HCT``[5775/C-A1]CG^%9GAI9YU$5Y]V.G2@L-LR=*<,S#[TJ>/8
M"DD),6,[L+N3_O>>ZX2$KRR4+<"-K2O=HZ,KG:NP(S[5H1ITKLN_FY"/HQWQ
M6UDW@TX]KT,O_XKV:5FBW1^7EZ&_&M4?7O0GLZMY$Z'_)&ORL;@.53WH4$^O
M/<V7JS#HG+[_]=/O^Z=1M+LK#L;9[#R<A4;L[D9-65UGTZ+>RYKQM)SUFBJ;
MU9>AR7IY>;E8#UTH*15^+7DMK5N0D\8O<BJ(,D.AD,HDSD0K8GLKV@_B24I/
M7CFI%]8FUD>'@GK6ZQY_"JGZ)/LR$20',AEH\TZJ@93B`:9XIT571K^(_Y?Y
M092O$B-.#KH7X<NPS*I"7&975Y/9>8W9Q*B<3LL;\?%,'*^Z:]$5F2B"&&5Y
M4P*A;K)9P7&CLA+A<Q-F12@$T.I>="RL45Y%)YL-B+K_\2>*9":CGY]9^V26
M3^=%Z$\GL_GGY0GIC>_F(36T<,90LAAI-4R4=FX49,B0_(<[N!T+NYGPKY8+
MIQ.K0.LVN+F93"?GXZ8WSV\8I*@F?#"7X?W;Y/:SYF)8]/(E,R\U:9D8N:`T
M(5H,AT4:E`P%:9=Z_8C8"S#O,%0^L?1LXFXQ\W%6K2%O";:I,U(:'-Z4TD4P
M>2&#&ZIB%$8C[;8R?`KM#C5I4FE:86X)>%ZFW\4[^@"LK[VS237%N:]F8;HW
MS>9-J(99/GX>/B6EB%C3RX6PIBEYI&:Y3<U>=/U;JOG;"A8_L'Z[K7[7ZOV1
MQ=HNY@_1K6[:/VCO9-L&O4+&AZF2PD1'J=)X=+3SL4J26$L%,[&V,A8IWK6)
M+:D8"8ZU]S')%.^$=QUKXV&(,6G,"!RA809F8>CQ#A$2A@@%8Q1K,).#`8EG
ML_!;"P22&AX#L['RL`2<?`H^C(((SWWP80;MF"-F<.#A@.((""HEC(`W(43#
M4HDHA2>OBA&9(Z\`/@LD1K`IQH`CF9BS8H7FK'@\.LH#`RM5GF=G-@DP$)O`
MAS6J%/Z4&3%+">,YP4BR><X*LR'T$#R809.%(6_$?D0I](&)5F"H,$9AC,(8
MA4QIR0@:/0:C'+R&WSGS&&6XS?E$=AC=((^.,P)4K$=[WB4E_OFIE?:39?1Y
M87]')7]T%W\#"VG'.;$*6$JO-(R#^6(-TUO=R/M%(8[?__G7Q_>'1_L0Y?*B
M>:#*)Q?V"DT>06V"HITBC":SL)FWTU'*W2O03]\YO)UO>`,^VM"7W8`>EXPA
MO@$],-KJG+Y\9ZWHVC?;V7I^=5563?MEZ>ZW*BZ_RPM[2_U]>L6O*<,V$38Z
M<@J?'46^+9<*Y5`(+E5H0_:$8L=M@M1;/[\;+EEVTU9M"46QXD+6>E`4R*)T
M.WZB,**DD$K0=FN$Y=.O$+A@$<HAX3)@;&1O/?<2$0@HF4LN<HVTX:1:A!4>
M>/`(<LG]4>O5)2W'UN=63YUP&5?W<3>1>LVZS5'Z</XERN:_D7P<\HMZ?KFK
0\F+DAH:B?P&/,F5EZ`P`````
`
end
