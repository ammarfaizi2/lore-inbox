Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265878AbTF3Uba (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 16:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265882AbTF3UbP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 16:31:15 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:23755 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265877AbTF3UaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 16:30:15 -0400
Date: Mon, 30 Jun 2003 22:44:29 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Pam.Delaney@lsil.com
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       trivial@rustcorp.com.au
Subject: [2.5 patch] postfix a constat in mptbase.c with ULL
Message-ID: <20030630204429.GK282@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The patch below postfixes a constant in mptbase.c that is on 32 bit 
archs too big for a long with ULL.

Please apply
Adrian

--- linux-2.5.73-not-full/drivers/message/fusion/mptbase.c.old	2003-06-23 23:07:57.000000000 +0200
+++ linux-2.5.73-not-full/drivers/message/fusion/mptbase.c	2003-06-23 23:08:27.000000000 +0200
@@ -1279,7 +1279,7 @@
 	u32		 psize;
 	int		 ii;
 	int		 r = -ENODEV;
-	u64		 mask = 0xffffffffffffffff;
+	u64		 mask = 0xffffffffffffffffULL;
 
 	if (pci_enable_device(pdev))
 		return r;
