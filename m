Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030313AbWAaDaS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030313AbWAaDaS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 22:30:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030314AbWAaDaR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 22:30:17 -0500
Received: from spooner.celestial.com ([192.136.111.35]:35295 "EHLO
	spooner.celestial.com") by vger.kernel.org with ESMTP
	id S1030306AbWAaDaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 22:30:15 -0500
Date: Mon, 30 Jan 2006 22:36:22 -0500
From: Kurt Wall <kwall@kurtwerks.com>
To: LKML <linux-kernel@vger.kernel.org>, jgarzik@pobox.com,
       linux-ide@vger.kernel.org
Subject: (Fixed whitespace) Fix make mandocs for libata-core.c
Message-ID: <20060131033622.GR1501@kurtwerks.com>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>,
	jgarzik@pobox.com, linux-ide@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Operating-System: Linux 2.6.16-rc1krw
X-Woot: Woot!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"make mandocs" complains when on libata-core.c because several
functions have undescribed parameters. This patch adds silences those
warnings by adding descriptions for the undescribed parameters.

Signed-off-by: Kurt Wall <kwall@kurtwerks.com>

--- ./linux-2.6.16-rc1/drivers/scsi/libata-core.c.orig	2006-01-21 09:30:59.000000000 -0500
+++ ./linux-2.6.16-rc1/drivers/scsi/libata-core.c	2006-01-30 22:34:04.000000000 -0500
@@ -4163,6 +4163,8 @@
 /**
  *	ata_port_start - Set port up for dma.
  *	@ap: Port to initialize
+ *	@dev: Device whose port will be prepared for DMA
+ *	@cmd: Command to issue
  *
  *	Called just after data structures for each port are
  *	initialized.  Allocates space for PRD table.
@@ -4224,6 +4226,8 @@
 
 /**
  *	ata_device_resume - wakeup a previously suspended devices
+ *	@ap: port to which command is being issued
+ *	@dev: device to wake up from suspended state
  *
  *	Kick the drive back into action, by sending it an idle immediate
  *	command and making sure its transfer mode matches between drive
@@ -4246,6 +4250,8 @@
 
 /**
  *	ata_device_suspend - prepare a device for suspend
+ *	@ap: port to wich command is being issued
+ *	@dev: device to prepare for suspend
  *
  *	Flush the cache on the drive, if appropriate, then issue a
  *	standbynow command.
