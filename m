Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262219AbVBBCus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262219AbVBBCus (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 21:50:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262214AbVBBCsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 21:48:55 -0500
Received: from [211.58.254.17] ([211.58.254.17]:49545 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S262221AbVBBCsc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 21:48:32 -0500
Date: Wed, 2 Feb 2005 11:48:30 +0900
From: Tejun Heo <tj@home-tj.org>
To: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: [PATCH 2.6.11-rc2 06/29] ide: IDE_CONTROL_REG cleanup
Message-ID: <20050202024830.GG621@htj.dyndns.org>
References: <20050202024017.GA621@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050202024017.GA621@htj.dyndns.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 06_ide_start_request_IDE_CONTROL_REG.patch
> 
> 	Replaced HWIF(drive)->io_ports[IDE_CONTROL_OFFSET] with
> 	equivalent IDE_CONTROL_REG in ide-io.c.


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-ide-export/drivers/ide/ide-io.c
===================================================================
--- linux-ide-export.orig/drivers/ide/ide-io.c	2005-02-02 10:27:15.996184821 +0900
+++ linux-ide-export/drivers/ide/ide-io.c	2005-02-02 10:28:03.340503581 +0900
@@ -884,7 +884,7 @@ static ide_startstop_t start_request (id
 		if (rc)
 			printk(KERN_WARNING "%s: bus not ready on wakeup\n", drive->name);
 		SELECT_DRIVE(drive);
-		HWIF(drive)->OUTB(8, HWIF(drive)->io_ports[IDE_CONTROL_OFFSET]);
+		HWIF(drive)->OUTB(8, IDE_CONTROL_REG);
 		rc = ide_wait_not_busy(HWIF(drive), 10000);
 		if (rc)
 			printk(KERN_WARNING "%s: drive not ready on wakeup\n", drive->name);
