Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319219AbSHMXst>; Tue, 13 Aug 2002 19:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319221AbSHMXss>; Tue, 13 Aug 2002 19:48:48 -0400
Received: from www.wotug.org ([194.106.52.201]:10546 "EHLO
	gatemaster.ivimey.org") by vger.kernel.org with ESMTP
	id <S319219AbSHMXsq>; Tue, 13 Aug 2002 19:48:46 -0400
Date: Wed, 14 Aug 2002 00:50:39 +0100 (BST)
From: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
X-X-Sender: ruthc@sharra.ivimey.org
To: linux-kernel@vger.kernel.org
Subject: RFC [PATCH] pdc202xx configure help
Message-ID: <Pine.LNX.4.44.0208140046260.25777-100000@sharra.ivimey.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folks,

I've been working on the pdc202 driver having had some problems getting my new 
gigabyte MB running sweetly. The following patch fixes the configure help to 
be, well, more helpful. I hope this is useful.

In the text, I have referred to the two configure options I have renamed in 
another patch that I'll be submitting tonight also. These can, of couse, be 
left as-is.

Ruth

diff -U6 -r -x .*.flags -x *.o -x .depend linux-2.4.19/Documentation/Configure.help 2.4.19-ri1/linux/Documentation/Configure.help
--- linux-2.4.19/Documentation/Configure.help	Sat Aug  3 01:39:42 2002
+++ 2.4.19-ri1/linux/Documentation/Configure.help	Sat Aug 10 23:08:39 2002
@@ -1167,26 +1167,33 @@
 
   Case 430HX/440FX PIIX3 need speed limits to reduce UDMA to DMA mode
   2 if the BIOS can not perform this task at initialization.
 
   If unsure, say N.
 
-PROMISE PDC20246/PDC20262/PDC20265/PDC20267/PDC20268 support
+PROMISE PDC20246/PDC20262/PDC20265/PDC20267/PDC20268/PDC20275/PDC20276 support
 CONFIG_BLK_DEV_PDC202XX
   Promise Ultra33 or PDC20246
   Promise Ultra66 or PDC20262
   Promise Ultra100 or PDC20265/PDC20267/PDC20268
+  Promise Ultra133 or PDC20275/PDC20276
 
   This driver adds up to 4 more EIDE devices sharing a single
   interrupt. This add-on card is a bootable PCI UDMA controller. Since
   multiple cards can be installed and there are BIOS ROM problems that
   happen if the BIOS revisions of all installed cards (three-max) do
   not match, the driver attempts to do dynamic tuning of the chipset
   at boot-time for max-speed.  Ultra33 BIOS 1.25 or newer is required
-  for more than one card. This card may require that you say Y to
+  for more than one card, and this card may require that you say Y to
   "Special UDMA Feature".
+
+  If you have a RAID-capable controller, such as the PDC20276, it will
+  be used as a plain IDE controller unless you say Y to 'Do not use
+  software RAID device as plain IDE controller' and also say Y to the
+  Promise software IDE RAID controller. If you do this, the IDE driver
+  detects the controller during startup, but ignores it.
 
   If you say Y here, you need to say Y to "Use DMA by default when
   available" as well.
 
   Please read the comments at the top of
   <file:drivers/ide/pdc202xx.c>.

-- 
Ruth Ivimey-Cook
Software engineer and technical writer.


