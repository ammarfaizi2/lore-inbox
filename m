Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265885AbSKOIBe>; Fri, 15 Nov 2002 03:01:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265886AbSKOIBd>; Fri, 15 Nov 2002 03:01:33 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:41857 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S265885AbSKOIBb>;
	Fri, 15 Nov 2002 03:01:31 -0500
Date: Fri, 15 Nov 2002 09:08:18 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: vojtech@suse.cz
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [patch] Input - Rescan serio only if valid reason [1/13]
Message-ID: <20021115090818.A16761@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.
'bk pull bk://linux-input.bkbits.net/linux-input' should work as well.

===================================================================

ChangeSet@1.738.14.1, 2002-10-11 22:02:05+02:00, vojtech@suse.cz
  Rescan a serio port in serio.c only when a character comes from it
  only in case it's a valid character (correct parity, no timeout).


 serio.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

===================================================================

diff -Nru a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
--- a/drivers/input/serio/serio.c	Fri Nov 15 08:32:09 2002
+++ b/drivers/input/serio/serio.c	Fri Nov 15 08:32:09 2002
@@ -139,8 +139,9 @@
 {       
         if (serio->dev && serio->dev->interrupt) 
                 serio->dev->interrupt(serio, data, flags);
-	else
-		serio_rescan(serio);
+	else 
+		if (!flags)
+			serio_rescan(serio);
 }
 
 void serio_register_port(struct serio *serio)

===================================================================

This BitKeeper patch contains the following changesets:
1.738.14.1
## Wrapped with gzip_uu ##


begin 664 bkpatch16583
M'XL(`/FBU#T``[64;6_:,!#'7\>?XJ:^6%%'XLLC86+JUD[;M$E%3'T]&>=H
M4B!&MJ%BRH>?"91V5"O:4V)%.OM_EWOX)2=P;4CWO96ZM21+=@(?E;%]SRP-
M^?*[LT=*.3LHU9R"G2H83X.J7BPM<^=#864)*]*F[Z$?[7?L>D%];_3^P_67
MMR/&!@.X*$5]0U_)PF#`K-(K,2O,N;#E3-6^U:(V<[+"EVK>[*5-R'GH[@2S
MB"=I@RF/LT9B@2ABI(*'<2^-V2ZQ\UW:!_[($3%STJR)>CQ*V"6@GT4]'V,?
M@8<!\@`1PK#/W4K.-D\.!S'A#*'+V3OXMYE?,`DC,E+4(,"-HE*P4-I"56\M
M7X*J9VNX*VFCD*700EK2X%Y&!B9:S:&R;*=R7E(8<CLOC5.[/*OBD<^I5%J3
MM+`0NK+K5U`KL-6<U-)V?/897'=XRH8/DV+=W[P8XX*S-T>:5.AJ`TRPR2RX
M56MC*SD-=O4^:ES,>=+P.,W3AJ1(QCE-BEZ&1.)P.ON0+9?;4#\%W##0!L8F
M"O,X;8E\QNDXHW]?Q!-LCQ7!\S!!SJ.PUT28YWD+,CY%&'^%<`3=\+\@?+6A
M3]]SO"5X`K8D&*\MN1-)KK3BGE>HS!;.EKIV'E?0U7?M<A0-GQO-'T!YB7$(
M(?N$<001\VCFOA'F>2[%TQ>3F;@Q'6=Y;?QOVRI.6Z/S^N$7)TN24[.<#WH4
.B:S@DOT`"X2/]CT%````
`
end
