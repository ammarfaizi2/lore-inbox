Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318561AbSHVJFQ>; Thu, 22 Aug 2002 05:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318572AbSHVJFQ>; Thu, 22 Aug 2002 05:05:16 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:55243 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S318561AbSHVJFP>;
	Thu, 22 Aug 2002 05:05:15 -0400
Date: Thu, 22 Aug 2002 11:09:18 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [patch] Two minor fixes for the PPC input conversion.
Message-ID: <20020822110918.A25229@ucw.cz>
References: <20020820153813.A13034@ucw.cz> <20020821191034.A6014@ucw.cz> <20020821191227.B6014@ucw.cz> <20020821223222.A19016@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020821223222.A19016@ucw.cz>; from vojtech@suse.cz on Wed, Aug 21, 2002 at 10:32:22PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.
'bk pull bk://linux-input.bkbits.net/linux-input' should work as well.

===================================================================

ChangeSet@1.513, 2002-08-22 11:07:41+02:00, Franz.Sirl-kernel@lauterbach.com
  Two minor fixes on top of the PPC final input conversion.

 adbhid.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

===================================================================

diff -Nru a/drivers/macintosh/adbhid.c b/drivers/macintosh/adbhid.c
--- a/drivers/macintosh/adbhid.c	Thu Aug 22 11:08:09 2002
+++ b/drivers/macintosh/adbhid.c	Thu Aug 22 11:08:09 2002
@@ -37,7 +37,6 @@
 #include <linux/init.h>
 #include <linux/notifier.h>
 #include <linux/input.h>
-#include <linux/kbd_ll.h>
 
 #include <linux/adb.h>
 #include <linux/cuda.h>
@@ -51,6 +50,8 @@
 #define KEYB_KEYREG	0	/* register # for key up/down data */
 #define KEYB_LEDREG	2	/* register # for leds on ADB keyboard */
 #define MOUSE_DATAREG	0	/* reg# for movement/button codes from mouse */
+
+extern struct pt_regs *kbd_pt_regs;
 
 static int adb_message_handler(struct notifier_block *, unsigned long, void *);
 static struct notifier_block adbhid_adb_notifier = {

===================================================================

This BitKeeper patch contains the following changesets:
+
## Wrapped with gzip_uu ##


begin 664 bkpatch25220
M'XL(`/FI9#T``[V46V_3,!3'G^M/<:2],37Q<2Y.@HH*'3`$$E7'WI`FUW&;
MT"2N8J<=4SX\;E4VA`;A)FP_^/ARCO[G_.PSN#:JS48[_<DJ69`SN-3&9B/3
M&>7).V<OM':V7^A:^:=3_G+CE\VVL\3MSX65!>Q4:[(1>L']BOV\5=EH\?+U
M];OG"T(F$Y@5HEFK*V5A,B%6MSM1Y68J;%'IQK.M:$RMK/"DKOO[HSVCE+D>
M(0]H%/<8TY#W$G-$$:+**0N3."2OW.T[[ZILJ_%&M8VJII7HK&J70A:/.4P8
M,AI0EO24!IR3"T`OP@`H\VGB,P:(&>59B.>4993"D'\X1QA3\@+^K:P9D?!A
MKZ$N&]W"JKQ5!G3C@FQ!K\`6"N;SF5MO1`7'@H#4S:$4I0M-WCH5/"'SA\23
M\6\V0JB@Y-F`K+PM#T']6LBRL=H4OLB719E[\AN=(<6X#S")PCY<(5<4HR1-
M>1RE^6!Z!R,DC-&4\H#W%`/D1]Q^?&>8O[]51$XO96KW956N"^MU<N_>TZ!C
MSB+$*&:A`Q-C/(*9?H]EP'\92P9C_"]8KMSL*Y"/HG@HRWL8M_OC<&C-?U*A
M/P#U(J2`Y$T4`",?B;IU:6C`V+:3%K;VIE5K`T\VR_SF9#Q]^+QDH>3&=/4D
0B9<!9VE,O@#-M3R,%P4`````
`
end

-- 
Vojtech Pavlik
SuSE Labs
