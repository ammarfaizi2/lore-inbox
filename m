Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261299AbUJ3U5n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261299AbUJ3U5n (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 16:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261316AbUJ3U5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 16:57:43 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61361 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261299AbUJ3U5k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 16:57:40 -0400
Date: Sat, 30 Oct 2004 21:57:39 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: Linus Torvalds <torvalds@osdl.org>
Cc: parisc-linux@parisc-linux.org, linux-kernel@vger.kernel.org
Subject: [PATCH] kernel-parameters update for PA-RISC
Message-ID: <20041030205739.GL8958@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 - Add the PARISC tag (Thibaut Varene)
 - Mark some existing PA-RISC specific entries with it (Thibaut Varene)
 - Document pdcchassis (Thibaut Varene)

diff -urpNX dontdiff linux-2.6.10-rc1-bk9/Documentation/kernel-parameters.txt parisc-2.6-bk/Documentation/kernel-parameters.txt
--- linux-2.6.10-rc1-bk9/Documentation/kernel-parameters.txt	Sat Oct 30 09:14:21 2004
+++ parisc-2.6-bk/Documentation/kernel-parameters.txt	Sat Oct 30 09:31:21 2004
@@ -53,6 +53,7 @@ restrictions referred to are that the re
 	NFS	Appropriate NFS support is enabled.
 	OSS	OSS sound support is enabled.
 	PARIDE	The ParIDE subsystem is enabled.
+	PARISC	The PA-RISC architecture is enabled.
 	PCI	PCI bus support is enabled.
 	PCMCIA	The PCMCIA subsystem is enabled.
 	PNP	Plug & Play support is enabled.
@@ -394,7 +395,7 @@ running once the system is up.
 	eicon=		[HW,ISDN] 
 			Format: <id>,<membase>,<irq>
 
-	eisa_irq_edge=	[PARISC]
+	eisa_irq_edge=	[PARISC,HW]
 			See header of drivers/parisc/eisa.c.
 
 	elanfreq=	[IA-32]
@@ -933,6 +934,11 @@ running once the system is up.
 	pd.		[PARIDE]
 			See Documentation/paride.txt.
 
+	pdcchassis=	[PARISC,HW] Disable/Enable PDC Chassis Status codes at
+			boot time.
+			Format: { 0 | 1 }
+			See arch/parisc/kernel/pdc_chassis.c
+
 	pf.		[PARIDE]
 			See Documentation/paride.txt.
 
@@ -1250,7 +1256,7 @@ running once the system is up.
 	st0x=		[HW,SCSI]
 			See header of drivers/scsi/seagate.c.
 
-	sti=		[HW]
+	sti=		[PARISC,HW]
 			Format: <num>
 			Set the STI (builtin display/keyboard on the HP-PARISC
 			machines) console (graphic card) which should be used

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
