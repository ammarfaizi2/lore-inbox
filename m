Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263237AbSJHNyt>; Tue, 8 Oct 2002 09:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263241AbSJHNyJ>; Tue, 8 Oct 2002 09:54:09 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:62100 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S263239AbSJHNxj>;
	Tue, 8 Oct 2002 09:53:39 -0400
Date: Tue, 8 Oct 2002 15:59:15 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [patch] Input - Fix serial mouse wheel, increase timeout [18/23]
Message-ID: <20021008155915.Q18546@ucw.cz>
References: <20021008154631.G18546@ucw.cz> <20021008154733.H18546@ucw.cz> <20021008154824.I18546@ucw.cz> <20021008154904.J18546@ucw.cz> <20021008155003.K18546@ucw.cz> <20021008155045.L18546@ucw.cz> <20021008155125.M18546@ucw.cz> <20021008155236.N18546@ucw.cz> <20021008155651.O18546@ucw.cz> <20021008155825.P18546@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021008155825.P18546@ucw.cz>; from vojtech@suse.cz on Tue, Oct 08, 2002 at 03:58:25PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.
'bk pull bk://linux-input.bkbits.net/linux-input' should work as well.

===================================================================

ChangeSet@1.573.1.52, 2002-10-07 11:13:20+02:00, aderesch@fs.tum.de
  Increase the resync timeout for serial mice, and fix MZ wheel direction.


 sermouse.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

===================================================================

diff -Nru a/drivers/input/mouse/sermouse.c b/drivers/input/mouse/sermouse.c
--- a/drivers/input/mouse/sermouse.c	Tue Oct  8 15:25:38 2002
+++ b/drivers/input/mouse/sermouse.c	Tue Oct  8 15:25:38 2002
@@ -155,7 +155,7 @@
 
 				case SERIO_MZ:
 					input_report_key(dev, BTN_MIDDLE, (data >> 4) & 1);
-					input_report_rel(dev, REL_WHEEL, (data & 7) - (data & 8));
+					input_report_rel(dev, REL_WHEEL,  (data & 8) - (data & 7));
 					break;
 			}
 					
@@ -204,7 +204,7 @@
 {
 	struct sermouse *sermouse = serio->private;
 
-	if (time_after(jiffies, sermouse->last + HZ/20)) sermouse->count = 0;
+	if (time_after(jiffies, sermouse->last + HZ/10)) sermouse->count = 0;
 	sermouse->last = jiffies;
 
 	if (sermouse->type > SERIO_SUN)

===================================================================

This BitKeeper patch contains the following changesets:
1.573.1.52
## Wrapped with gzip_uu ##


begin 664 bkpatch17980
M'XL(`-+<HCT``[V4;6O;,!#'7T>?XJ`P$AK;DOR<DI*M#4M9QTI&&?1-4>5S
M[-8/19:3=OC#3TZZ=I31/4\V/I\EG>_N_T-[<-Z@F@S6];5&F9$]6-2-G@R:
MMD%;?C;^LJZ-[V1UB<[#*N?JQLFKVU83,W\FM,Q@C:J9#)CM/G[1][<X&2SG
M;\]/7R\)F4[A*!/5"C^BANF4Z%JM19$T,Z&SHJYLK435E*B%+>NR>US:<4JY
MN7P6NM0/.A90+^PD2Q@3'L.$<B\*/+)"5'I6Y%5[9Y5!=&/7:O4L"*,TI)$;
MF^W<YS$CQ\!L/W1M\^1`N<.H0T-@;,+<":?[E$\H!9&@PD9FL[2Q=5O:"<(^
M`XN2-_!W*S@B$DXJJ5`T"#I#,+^]KR3HO,2ZU9#6"HQ2N2B@S"6.050)I/D=
MO+^`38980)(KE#HWF9!WP+T@\LG94\^)]8N#$"HH.80'S6=ZDQ?Y*M-V*S>&
MC"Y1>2_Z#@2GK`TPCDEP^V++7=4A=9E+(X]W//2CJ&-7TA71E>_3%#WFQ=]I
M[\_$W4H9,Y<%7<!X3+=TO;RO1^Y?5O)GP;G/F!]PKR_'C[=DAL^19,$+2'*P
M^/]&<OP"?CM9/H"E-MO;X'3V`X5^`]!CYD?`R,G.#/JQC7VI\+96O2F&":['
ML)R?7GY:S.>G8X!A(K2`5Q"-P'ITPM'H@!SSOMGD9&<&>0K#OM1+D6I4P^L\
M37-LQO`U9>NP$(V&?5A<&*%&HV\F9-U6YI0#>O!T0LH,Y4W3EE,91V$DF2!?
)`-.UEW1\!0``
`
end
