Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314451AbSG2K0i>; Mon, 29 Jul 2002 06:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314514AbSG2K0i>; Mon, 29 Jul 2002 06:26:38 -0400
Received: from ns1.alcove-solutions.com ([212.155.209.139]:41858 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S314451AbSG2K0g>; Mon, 29 Jul 2002 06:26:36 -0400
Date: Mon, 29 Jul 2002 12:29:44 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       frank@schusdziarra.de
Subject: [BK PATCH 2.4.19-rc4] sonypi driver patchlet
Message-ID: <20020729102944.GE29876@tahoe.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	frank@schusdziarra.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch adds support for the 'Help' button which can be found 
in VAIO PCG-NV105 models (maybe NV109 models as well).

Credits go to Frank Schusdziarra for this patch.

Marcelo, please apply this as soon as possible. I feel that
this patch is trivial enough to go into rc5 without distrurbing
anything else... but feel free to queue it for 2.5.20 if you 
disagree.

Thanks,

Stelian.

You can import this changeset into BK by piping this whole message to
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.655, 2002-07-29 12:14:37+02:00, stelian@popies.net
  Do recognize the help button found in VAIO PCG-NV105 models (maybe NV109 as well).
  
  Credits go to Frank Schusdziarra.


 drivers/char/sonypi.h  |    1 +
 include/linux/sonypi.h |    1 +
 2 files changed, 2 insertions(+)


diff -Nru a/drivers/char/sonypi.h b/drivers/char/sonypi.h
--- a/drivers/char/sonypi.h	Mon Jul 29 12:16:20 2002
+++ b/drivers/char/sonypi.h	Mon Jul 29 12:16:20 2002
@@ -214,6 +214,7 @@
 /* The set of possible back button events */
 static struct sonypi_event sonypi_backev[] = {
 	{ 0x20, SONYPI_EVENT_BACK_PRESSED },
+	{ 0x3b, SONYPI_EVENT_HELP_PRESSED },
 	{ 0x00, 0x00 }
 };
 
diff -Nru a/include/linux/sonypi.h b/include/linux/sonypi.h
--- a/include/linux/sonypi.h	Mon Jul 29 12:16:20 2002
+++ b/include/linux/sonypi.h	Mon Jul 29 12:16:20 2002
@@ -75,6 +75,7 @@
 #define SONYPI_EVENT_LID_OPENED			37
 #define SONYPI_EVENT_BLUETOOTH_ON		38
 #define SONYPI_EVENT_BLUETOOTH_OFF		39
+#define SONYPI_EVENT_HELP_PRESSED		40
 
 /* get/set brightness */
 #define SONYPI_IOCGBRT		_IOR('v', 0, __u8)

===================================================================


This BitKeeper patch contains the following changesets:
+
## Wrapped with gzip_uu ##


begin 664 bkpatch17004
M'XL(`/0513T``^V544_;,!2%G^M?<25>-HVFOHX;-Y$ZP:`#-`15.Y#VA%S'
M)5'3N$H<H"S[[W-;1#54BF#;R[3$3U=71U_N/<?9@8M2%U&CM#I+94YVX-B4
M-FK,S"S5I9=KZTH#8URIE9BI;MDT3TW5FN@BUUDK2_/JKLD\3EQ;7UJ5P(TN
MRJB!GO]8L?.9CAJ#WM'%Z?Z`D&X7#A*97^NAMM#M$FN*&YG%Y9ZT269RSQ8R
M+Z?:2D^9:?W86C-*F7O;*'S:#FH,*!>UPAA1<M0Q9;P3<#*5A=*9V9MEE9K,
MO3@M;6&<4JZ536_D4SW!`H:4<U[[#,.0'`)Z0;L-E+6H:+$0D$7((U]\H"RB
M%![FM+>>#WQ@T*3D$_S9[S@@"@X-%%J9ZSR]UV`3#8G.9C"JK#4YC$V5QY#F
M<+E_<@[]@Z/FV272-DQ-K+,2WDWE?*1A40M!EG"KL^R]YT3=.2ATG-H2KHV#
MAL^.<P)#E51E?)_*HI`>^0(^4H&DOUX5:;[R(81*2C[";&&"S4-)<Y55L5[9
MJ%6:?#Y+O60]H1"ICS7GB*+VJ>1C-E+HMX4<!>&&56S5$\RI(6)8HQ^P%\#B
M(EWXN*4263S/A9W0<04JY,*A"3$.,!:;N+;(K;&<B$^7\=C8OHC*WR$FKR/F
M"V(_](5;3"`ZR\@@_IH8C##<DAC\%Q.SVM\Y-(O;Y7$)Z&]>Y1NB=,(P`"2-
M[T#O_-$N#,_/OO5/KGJ7O;.O5\>]T_Y5?]`;#GN'\&-WZ:'-47C!1+^3QP?=
MY^[=;=(^^A0IY9T::8>QU27\WU"K>^J)H3;/\2V.$L(9:B?6XS37S_NIT>!T
9_7-7B5:3LIIV.QBT`U0C\A.B$QZ700@`````
`
end
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
