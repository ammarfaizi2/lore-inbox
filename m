Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265887AbUATX0W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 18:26:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265892AbUATX0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 18:26:21 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:59874 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265887AbUATXZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 18:25:16 -0500
Date: Wed, 21 Jan 2004 00:25:07 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, James.Bottomley@SteelEye.com
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [2.6 patch] show "Fusion MPT device support" menu only if BLK_DEV_SD
Message-ID: <20040120232507.GC6441@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With BLK_DEV_SD=n, I see a "Fusion MPT device support" menu I can't 
enter.

The simple patch below removes the "Fusion MPT device support" menu if 
BLK_DEV_SD=n.

Please apply
Adrian

--- linux-2.6.1-mm5/drivers/message/fusion/Kconfig.old	2004-01-21 00:19:12.000000000 +0100
+++ linux-2.6.1-mm5/drivers/message/fusion/Kconfig	2004-01-21 00:19:29.000000000 +0100
@@ -1,9 +1,9 @@
 
 menu "Fusion MPT device support"
+	depends on BLK_DEV_SD
 
 config FUSION
 	tristate "Fusion MPT (base + ScsiHost) drivers"
-	depends on BLK_DEV_SD
 	---help---
 	  LSI Logic Fusion(TM) Message Passing Technology (MPT) device support
 	  provides high performance SCSI host initiator, and LAN [1] interface
