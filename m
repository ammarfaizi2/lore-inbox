Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263189AbTLSOuC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 09:50:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263299AbTLSOuC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 09:50:02 -0500
Received: from smtp9.us.dell.com ([143.166.148.136]:57040 "EHLO
	smtp9.us.dell.com") by vger.kernel.org with ESMTP id S263189AbTLSOtz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 09:49:55 -0500
Date: Fri, 19 Dec 2003 08:49:33 -0600 (CST)
From: Matt Domsch <Matt_Domsch@dell.com>
X-X-Sender: mdomsch@humbolt.us.dell.com
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Meelis Roos <mroos@linux.ee>
cc: Anton Altaparmakov <aia21@cam.ac.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.23-bk bogus edd changeset - Re: 2.4.23 compile error in edd
In-Reply-To: <Pine.GSO.4.44.0312191305180.8311-100000@math.ut.ee>
Message-ID: <Pine.LNX.4.44.0312190847310.31005-100000@humbolt.us.dell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes, this works fine for me with current 2.4.

Thanks much.

Marcelo, please do a

	bk pull http://mdomsch.bkbits.net/linux-2.4-edd

This will update the following files:

 Documentation/i386/zero-page.txt |    8 +++++---
 include/asm-i386/edd.h           |    2 +-
 2 files changed, 6 insertions, 4 deletions

through these ChangeSets:

<Matt_Domsch@dell.com> (03/12/19 1.1207)
   zero-page.txt: note 0x228 as in use by unknown

<Matt_Domsch@dell.com> (03/12/10 1.1206)
   EDD: move DISK80_SIG_BUFFER to 0x2cc in empty_zero_page
   
   Apparently 0x228 is used by something else; leastwise that
   address causes some systems to fail to decompress the kernel.

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

You can import this changeset into BK by piping this whole message to
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.1206, 2003-12-10 11:44:50-06:00, Matt_Domsch@dell.com
  EDD: move DISK80_SIG_BUFFER to 0x2cc in empty_zero_page
  
  Apparently 0x228 is used by something else; leastwise that
  address causes some systems to fail to decompress the kernel.


 Documentation/i386/zero-page.txt |    2 +-
 include/asm-i386/edd.h           |    2 +-
 2 files changed, 2 insertions, 2 deletions


diff -Nru a/Documentation/i386/zero-page.txt b/Documentation/i386/zero-page.txt
--- a/Documentation/i386/zero-page.txt	Fri Dec 19 08:46:46 2003
+++ b/Documentation/i386/zero-page.txt	Fri Dec 19 08:46:46 2003
@@ -66,7 +66,7 @@
 0x21c	unsigned long	INITRD_SIZE, size in bytes of ramdisk image
 0x220	4 bytes		(setup.S)
 0x224	unsigned short	setup.S heap end pointer
-0x228	4 bytes		DISK80_SIG_BUFFER (setup.S)
+0x2cc	4 bytes		DISK80_SIG_BUFFER (setup.S)
 0x2d0 - 0x600		E820MAP
 0x600 - 0x800		EDDBUF (setup.S) for disk signature read sector
 0x600 - 0x7d4		EDDBUF (setup.S)
diff -Nru a/include/asm-i386/edd.h b/include/asm-i386/edd.h
--- a/include/asm-i386/edd.h	Fri Dec 19 08:46:46 2003
+++ b/include/asm-i386/edd.h	Fri Dec 19 08:46:46 2003
@@ -43,7 +43,7 @@
 
 #define READ_SECTORS 0x02
 #define MBR_SIG_OFFSET 0x1B8
-#define DISK80_SIG_BUFFER 0x228
+#define DISK80_SIG_BUFFER 0x2cc
 
 #ifndef __ASSEMBLY__
 

===================================================================


This BitKeeper patch contains the following changesets:
1.1206
## Wrapped with gzip_uu ##


M'XL( %8/XS\  ]V5VVZ;0!"&K[U/,5)N6E7 GL#@RE4.3M,HK1HYRE5566L8
M!QH.%KLD<<7#=Z%MDB9NG$:I5!70(E:SP[_S?P-;<*JQ'@T^*&-FDZK0<4JV
MX%VES6B08)Z[<578B6E5V0DOK0KTBJ0/\^;G'B:)EV=E<^5P5SKVB=C88V7B
M%"ZPUJ,!<\7UC%DM<328[A^<OM^9$C(>PUZJRC,\00/C,3%5?:'R1&\KD^95
MZ9I:E;I HSH)[75HRRGE]O394% _:%E Y;"-6<*8D@P3RF482/*E2DMMFGR[
MT6XV+^[G$(S3@(7"E[R5D1223("YW210X3'N,0J,C:0<^=2AP8A2N%6C[9^U
M@5<<'$IVX7GE[Y$8]B>3$135!<+D\.0HI+.3PX/9[NG;M_M3^S:@5SR.(2L!
MBZ59S;YB7<V6Z@SM2GOM+)>JQM+DJRZ0AY!I:#0F,%^!MBZ:-"O/ '.-KR%'
MI<UEIA%,JHQ=K)*D1JTA5G:)[N-!K[3!0G=O7J@L[^X)VJTM^TB3(IQC76+N
MDB.00S_DY/C&7^+\X4$(592\65OR3S\ _-QF99PW"7I*%TXFPJ#CT4U[=VG$
M!8M\;MUE-**L'08R0,X6*E%,LF2Q-O5#&1EGE VE%):74(K JGO8\TD5-X6U
M0)FL*KT^6V>2TYGDFJO;*$@JAJTOA6!M.*<1AO-(\"1FEH7U.A^3^Q?%$9>R
M[[GU.^P:\._5^NFI[08H$S[ED2VZD-^;5-SM4,$?[% &#ONG.M1V2$_01W#J
MR_ZRQ!__QIHG],Y$!L#(83]N);C(RG4*>WD]$YMHVOQY?A[6-W#R..AO$1,Q
MG_?$R/^ F+Z#[Q"SJ2)/82>(.G;ZL9<SD/:?85 /!O<EO]!HFJ5[\O+FOQ^G
6&)_KIAB'B_DBD)$@WP#1-7?38P@     
 
You can import this changeset into BK by piping this whole message to
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.1207, 2003-12-19 08:44:45-06:00, Matt_Domsch@dell.com
  zero-page.txt: note 0x228 as in use by unknown


 zero-page.txt |    6 ++++--
 1 files changed, 4 insertions, 2 deletions


diff -Nru a/Documentation/i386/zero-page.txt b/Documentation/i386/zero-page.txt
--- a/Documentation/i386/zero-page.txt	Fri Dec 19 08:47:02 2003
+++ b/Documentation/i386/zero-page.txt	Fri Dec 19 08:47:02 2003
@@ -66,10 +66,12 @@
 0x21c	unsigned long	INITRD_SIZE, size in bytes of ramdisk image
 0x220	4 bytes		(setup.S)
 0x224	unsigned short	setup.S heap end pointer
+0x228	4 bytes		unknown, but writing this in setup.S makes
+			kernel fail to decompress on some systems
 0x2cc	4 bytes		DISK80_SIG_BUFFER (setup.S)
 0x2d0 - 0x600		E820MAP
-0x600 - 0x800		EDDBUF (setup.S) for disk signature read sector
-0x600 - 0x7d4		EDDBUF (setup.S)
+0x600 - 0x7ff		EDDBUF (setup.S) for disk signature read sector
+0x600 - 0x7de		EDDBUF (setup.S)
 
 0x800	string, 2K max	COMMAND_LINE, the kernel commandline as
 			copied using CL_OFFSET.

===================================================================


This BitKeeper patch contains the following changesets:
1.1207
## Wrapped with gzip_uu ##


M'XL( &8/XS\  \U4RV[4,!1=QU]QI6Y D,1VG*<TJ+132@6(JE77R)/<F423
MV*/8Z0/EXW%#:3NB8@KJ L>;7-W'.><>>0\N#/:%]T5:^VVN.U/69 \^:F,+
MK\*V#4K=N<"9UBX0UKK#L*NFM'"Q#K&JPK91P[7/ ^&[/^)R3Z4M:[C$WA0>
M"Z+[B+W98.&='1U??'Y_1LAL!H>U5"L\1PNS&;&ZOY1M9?:EK5NM MM+93JT
M\A;">)\Z<DJY^V*61C1.1I90D8XEJQB3@F%%N<@201[QV?_%8[M)Q#BC+!4B
MIJ-(XXR3.;" <9H"C4+&0Y8#S0HA"A'[-"DHA:>:PAL&/B4'\++X#TD)W['7
M_D:N,+#7M@"E+0*]YCP#::!1,!B$Q0T,:JWTE2*?P-'(*3E]T)7X?WD(H9*2
M=SO(S'4Y=*BLM(U681-E2;B%]1%'0:-TC$44L3%;T!RS11[QJF2.Y)-R/JOW
M[>IR)@3GT1AG@F>3FW95[C;9R_!ZVGO/Y359,N*CR+D0DR7C;3_R@D=_]*, 
MG_\??ORYFZ_@]U?3=?XZW;FF?_#L29(!)Q,43S@(%HWGW<%X"XO!PE7?V$:M
MP-;-!-6@'3;!.71RC89XGK?&7F$+2]FT3CFHT(FTZ=$8T"[;/7M@;HS%SI!Y
MRMRPDY1/(Q.W!M^ID"Z7GG<TGQ]<?(!7=]U?PU+W4#5F#:99*6F''J%'6;GQ
BI5O/X_(*?R]_>$S+&LNU&;I9E49IGB5(?@"U)U#ZN 4     
 

