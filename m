Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262235AbVBBEJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262235AbVBBEJg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 23:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262227AbVBBEJZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 23:09:25 -0500
Received: from [211.58.254.17] ([211.58.254.17]:53898 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S262247AbVBBDC4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 22:02:56 -0500
Date: Wed, 2 Feb 2005 12:02:54 +0900
From: Tejun Heo <tj@home-tj.org>
To: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: [PATCH 2.6.11-rc2 18/29] ide: comment fixes
Message-ID: <20050202030254.GC1187@htj.dyndns.org>
References: <20050202024017.GA621@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050202024017.GA621@htj.dyndns.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 18_ide_comment_fixes.patch
> 
> 	Comment fixes.


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-ide-export/drivers/ide/ide-dma.c
===================================================================
--- linux-ide-export.orig/drivers/ide/ide-dma.c	2005-02-02 10:27:15.202313614 +0900
+++ linux-ide-export/drivers/ide/ide-dma.c	2005-02-02 10:28:05.642130143 +0900
@@ -227,7 +227,9 @@ EXPORT_SYMBOL_GPL(ide_build_sglist);
  *	the PRD table that the IDE layer wants to be fed. The code
  *	knows about the 64K wrap bug in the CS5530.
  *
- *	Returns 0 if all went okay, returns 1 otherwise.
+ *	Returns the number of built PRD entries if all went okay,
+ *	returns 0 otherwise.
+ *
  *	May also be invoked from trm290.c
  */
  
Index: linux-ide-export/drivers/ide/ide-taskfile.c
===================================================================
--- linux-ide-export.orig/drivers/ide/ide-taskfile.c	2005-02-02 10:28:05.463159181 +0900
+++ linux-ide-export/drivers/ide/ide-taskfile.c	2005-02-02 10:28:05.642130143 +0900
@@ -853,8 +853,8 @@ ide_startstop_t flagged_taskfile (ide_dr
 		hwif->OUTB(taskfile->high_cylinder, IDE_HCYL_REG);
 
         /*
-	 * (ks) In the flagged taskfile approch, we will used all specified
-	 * registers and the register value will not be changed. Except the
+	 * (ks) In the flagged taskfile approch, we will use all specified
+	 * registers and the register value will not be changed, except the
 	 * select bit (master/slave) in the drive_head register. We must make
 	 * sure that the desired drive is selected.
 	 */
