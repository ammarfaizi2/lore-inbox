Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030317AbWAaDbD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030317AbWAaDbD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 22:31:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030321AbWAaDbA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 22:31:00 -0500
Received: from spooner.celestial.com ([192.136.111.35]:36831 "EHLO
	spooner.celestial.com") by vger.kernel.org with ESMTP
	id S1030317AbWAaDa7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 22:30:59 -0500
Date: Mon, 30 Jan 2006 22:37:06 -0500
From: Kurt Wall <kwall@kurtwerks.com>
To: LKML <linux-kernel@vger.kernel.org>, jgarzik@pobox.com,
       linux-ide@vger.kernel.org
Subject: (Fixed Whitespace) Fix make mandocs on libata-scsi.c
Message-ID: <20060131033706.GS1501@kurtwerks.com>
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

"make mandocs" complains when on libata-scsi.c because
ata_scsi_simulate() has undescribed parameters. This patch adds silences 
this warnings by adding descriptions for the undescribed parameters.

Signed-off-by: Kurt Wall <kwall@kurtwerks.com>

--- ./linux-2.6.16-rc1/drivers/scsi/libata-scsi.c.orig	2006-01-21 09:30:59.000000000 -0500
+++ ./linux-2.6.16-rc1/drivers/scsi/libata-scsi.c	2006-01-30 22:34:44.000000000 -0500
@@ -2492,7 +2492,8 @@
 
 /**
  *	ata_scsi_simulate - simulate SCSI command on ATA device
- *	@id: current IDENTIFY data for target device.
+ *	@ap: Port to which command is being sent
+ *	@dev: Device to which to send command
  *	@cmd: SCSI command being sent to device.
  *	@done: SCSI command completion function.
  *
