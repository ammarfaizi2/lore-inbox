Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262212AbSJJXvE>; Thu, 10 Oct 2002 19:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262215AbSJJXvE>; Thu, 10 Oct 2002 19:51:04 -0400
Received: from host194.steeleye.com ([66.206.164.34]:14605 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S262212AbSJJXvD>; Thu, 10 Oct 2002 19:51:03 -0400
Message-Id: <200210102356.g9ANulX11746@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: torvalds@transmeta.com
cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Compile fix for i386 timer patches
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 10 Oct 2002 16:56:46 -0700
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This one's a small fix that allows timer_pit.c to compile under certain local 
apic configurations.  A similar patch has been in the ac tree since 2.5.40-ac3.

James
You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.739, 2002-10-10 16:50:20-07:00, jejb@mulgrave.(none)
  fix compile failure in timer_pit.c


 timer_pit.c |    3 +++
 1 files changed, 3 insertions(+)


diff -Nru a/arch/i386/kernel/timers/timer_pit.c b/arch/i386/kernel/timers/timer
_pit.c
--- a/arch/i386/kernel/timers/timer_pit.c	Thu Oct 10 16:52:32 2002
+++ b/arch/i386/kernel/timers/timer_pit.c	Thu Oct 10 16:52:32 2002
@@ -7,7 +7,10 @@
 #include <linux/module.h>
 #include <linux/device.h>
 #include <asm/timer.h>
+#include <asm/smp.h>
+#include <asm/mpspec.h>
 #include <asm/io.h>
+#include <asm/arch_hooks.h>
 
 extern spinlock_t i8259A_lock;
 extern spinlock_t i8253_lock;

===================================================================


This BitKeeper patch contains the following changesets:
+
## Wrapped with gzip_uu ##


begin 664 bkpatch11714
M'XL(`,`2ICT``[6446O;,!#'GZ-/<9"7C1%;LBS9,4O)VHVM=+"0T>>BR(KM
MQ+*,9'<=^,-/3D<ZPBC-6.U##W^?SG=__=`4;IVRV62G=ALTA2_&==E$]W5A
MQ;T*WC2F46^]OC;&ZV%IM`K'U/#R)NPJK>PL"ACR"2O1R1+NE779A`3TJ'0_
M6Y5-UI\^WW[]L$9HL8"K4C2%^JXZ6"Q09^R]J'.W%%U9FR;HK&B<5IT(I-'#
M,76(,([\RTA",>,#X3A.!DER0D1,5(ZC..7Q4[56-45?/5^.8.(7RFDZT#3E
M<_012)#0.>`H)-@'$)XQG$5XAI,,8QCG7IY8`^\(S#"ZA/\[R!62L*T>P.]M
MJUK!5E1U;Q54#1Q<OVNK+I#H!NB<)@RMGDQ%LS,?A+#`Z`)VIFQ<U]?+W@75
M1A_:%E:68453'NZ5;53]>.0N_*.'HY4D]9V0@<64D(%+GK-\LQ$L31.<_-V[
ML\I'E&'"!L8(9P>,7K!Y!.Q5QT*%5<5R;XTHSR\\9Y$?*$X31@_HQ:?@$?8L
M>/2UP!-Y#KIRKFH*#YRL^UPYC]JC]=]@9G\<PJ.S>LDI_`.1UW.(T/3WO^&]
M<#ITN@W*BQ-1MZY5<M2O1]=.OHZ]W97&[-V8<;R19*GDWO5ZL8D2R6.^1;\`
(@721200%````
`
end


