Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292730AbSDQPyF>; Wed, 17 Apr 2002 11:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292855AbSDQPyE>; Wed, 17 Apr 2002 11:54:04 -0400
Received: from ns1.alcove-solutions.com ([212.155.209.139]:25545 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S292730AbSDQPyC>; Wed, 17 Apr 2002 11:54:02 -0400
Date: Wed, 17 Apr 2002 17:54:00 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [BKPATCH 2.4] sonypi driver: off-by-one bug in parameter passing.
Message-ID: <20020417155400.GD1519@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch fixes a trivial off-by-one bug which could corrupt
memory when arguments are passed to the sonypi driver on the
kernel command line.

Marcelo, please apply.

Stelian.


You can import this changeset into BK by piping this whole message to
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.419, 2002-04-17 16:04:55+02:00, stelian@popies.net
  fix an off by one bug in command line parameter parsing


 sonypi.c |    2 +-
 sonypi.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/drivers/char/sonypi.c b/drivers/char/sonypi.c
--- a/drivers/char/sonypi.c	Wed Apr 17 16:06:16 2002
+++ b/drivers/char/sonypi.c	Wed Apr 17 16:06:16 2002
@@ -779,7 +779,7 @@
 
 #ifndef MODULE
 static int __init sonypi_setup(char *str)  {
-	int ints[6];
+	int ints[7];
 
 	str = get_options(str, ARRAY_SIZE(ints), ints);
 	if (ints[0] <= 0) 
diff -Nru a/drivers/char/sonypi.h b/drivers/char/sonypi.h
--- a/drivers/char/sonypi.h	Wed Apr 17 16:06:16 2002
+++ b/drivers/char/sonypi.h	Wed Apr 17 16:06:16 2002
@@ -35,7 +35,7 @@
 #ifdef __KERNEL__
 
 #define SONYPI_DRIVER_MAJORVERSION	 1
-#define SONYPI_DRIVER_MINORVERSION	11
+#define SONYPI_DRIVER_MINORVERSION	12
 
 #include <linux/types.h>
 #include <linux/pci.h>

===================================================================


This BitKeeper patch contains the following changesets:
+
## Wrapped with gzip_uu ##


begin 664 bkpatch14806
M'XL(`%B!O3P``]U586O;,!3\;/V*!_E88DNR+#D>&=V:LH5N27#H8(Q15%N.
M31,YV$K7@'_\Y&0TT&0A#1N,V<86#^E\[^YD=^"V5E7DU$;-"ZE1!SZ6M8F<
M9;DL5.UJ96PI+DM;\O)RH3Q3Z*)<>0^JTFKNS0N]>NI2ER$[;2)-DL.CJNK(
M(:[_7#'KI8J<^/K#[:=W,4+]/ESE4L_45!GH]Y$IJT<Y3^M+:?)YJ5U325TO
ME)%N4BZ:YZD-Q9C:,R#"QP%O",=,-`E)"9&,J!13%G*&?C5RN6O@)00C@OA!
M+PB:`#.,T0"(RT@/,/4P\X@`PB/,HB"XP#3"&/81X8)"%Z/W\&>I7Z$$LN()
MI(8RR^!^#:56<+^:0:'!`BZD3L$JKF`I*VE?HZIV5!=ZAF[`-D,XFNRT1=U7
M'@AAB=%;BVE=.]Q26A6MOUZ2R\JK2[U>%FZR:Z]'L$\:*S#CC1_@+!0B9)B%
M81+P`SH>@VM=LDL#VA#&??%Z6OD^K;`G&I\G/2981H7(.$G%J;3RE[08XT)L
MTGRPBS;9?T?(0Q$_)J1%(IA1OA&2;^*^'W9Z).P$NN0?"_LV$V/H5C\VEPWO
MY+`/9^R"@0@I$#3</IQ"&\O)U-_$]S>_]3L_P^\3$WJJW_E+O]N$_B=^;S?;
M"7[GY_CMAZW=FWLG55E+8CH>?9T,[P;Q\,MU?/=Y.!K'=C`=CD<.H;N?79*K
5Y*%>+?HL3)7],*3H)YR)C>]1!P``
`
end
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
