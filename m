Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262025AbULHDDI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262025AbULHDDI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 22:03:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262019AbULHDDE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 22:03:04 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:58632 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262023AbULHDCv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 22:02:51 -0500
Date: Wed, 8 Dec 2004 04:02:46 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Mike Castle <dalgoda@ix.netcom.com>, linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>, jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org
Subject: [2.4 patch] let SCSI_SATA_NV depend on EXPERIMENTAL
Message-ID: <20041208030246.GP5496@stusta.de>
References: <20041205165908.GA25139@thune.sonic.net> <20041208025248.GN5496@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041208025248.GN5496@stusta.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff,

Mike Castle <dalgoda@ix.netcom.com> noticed that CONFIG_SCSI_SATA_NV in 
2.4 is marked as "(EXPERIMENTAL)", but doesn't depend on EXPERIMENTAL.

Since it depends on EXPERIMENTAL in 2.6, I'd sugget the patch below to 
add this dependency in 2.4, too.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.4.29-pre1-full/drivers/scsi/Config.in.old	2004-12-08 03:53:07.000000000 +0100
+++ linux-2.4.29-pre1-full/drivers/scsi/Config.in	2004-12-08 03:53:26.000000000 +0100
@@ -72,7 +72,7 @@
 dep_tristate '  AHCI SATA support (EXPERIMENTAL)' CONFIG_SCSI_SATA_AHCI $CONFIG_SCSI_SATA $CONFIG_PCI $CONFIG_EXPERIMENTAL
 dep_tristate '  ServerWorks Frodo / Apple K2 SATA support (EXPERIMENTAL)' CONFIG_SCSI_SATA_SVW $CONFIG_SCSI_SATA $CONFIG_PCI $CONFIG_EXPERIMENTAL
 dep_tristate '  Intel PIIX/ICH SATA support' CONFIG_SCSI_ATA_PIIX $CONFIG_SCSI_SATA $CONFIG_PCI
-dep_tristate '  NVIDIA SATA support (EXPERIMENTAL)' CONFIG_SCSI_SATA_NV $CONFIG_SCSI_SATA $CONFIG_PCI
+dep_tristate '  NVIDIA SATA support (EXPERIMENTAL)' CONFIG_SCSI_SATA_NV $CONFIG_SCSI_SATA $CONFIG_PCI $CONFIG_EXPERIMENTAL
 dep_tristate '  Promise SATA TX2/TX4 support (EXPERIMENTAL)' CONFIG_SCSI_SATA_PROMISE $CONFIG_SCSI_SATA $CONFIG_PCI $CONFIG_EXPERIMENTAL
 dep_tristate '  Promise SATA SX4 support (EXPERIMENTAL)' CONFIG_SCSI_SATA_SX4 $CONFIG_SCSI_SATA $CONFIG_PCI $CONFIG_EXPERIMENTAL
 dep_tristate '  Silicon Image SATA support (EXPERIMENTAL)' CONFIG_SCSI_SATA_SIL $CONFIG_SCSI_SATA $CONFIG_PCI $CONFIG_EXPERIMENTAL
