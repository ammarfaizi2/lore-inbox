Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030305AbWAaDZU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030305AbWAaDZU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 22:25:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030304AbWAaDZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 22:25:20 -0500
Received: from spooner.celestial.com ([192.136.111.35]:31199 "EHLO
	spooner.celestial.com") by vger.kernel.org with ESMTP
	id S1030303AbWAaDZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 22:25:18 -0500
Date: Mon, 30 Jan 2006 22:31:24 -0500
From: Kurt Wall <kwall@kurtwerks.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org
Subject: Fix make mandocs for ata_piix.c
Message-ID: <20060131033124.GQ1501@kurtwerks.com>
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

"make mandocs" complains when on ata_piix.c because
piix_check_450nx_errata() has undescribed parameters. This patch silences
this warning by adding descriptions for the undescribed parameters.

Signed-off-by: Kurt Wall <kwall@kurtwerks.com>

--- ./linux-2.6.16-rc1/drivers/scsi/ata_piix.c.orig	2006-01-30 21:24:16.000000000 -0500
+++ ./linux-2.6.16-rc1/drivers/scsi/ata_piix.c	2006-01-30 22:30:39.000000000 -0500
@@ -624,6 +624,7 @@
 
 /**
  *	piix_check_450nx_errata	-	Check for problem 450NX setup
+ *	@ata_dev: ATA device to check
  *	
  *	Check for the present of 450NX errata #19 and errata #25. If
  *	they are found return an error code so we can turn off DMA
-- 
Finagle's First Law:
	If an experiment works, something has gone wrong.
