Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264143AbTFVXoD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 19:44:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264218AbTFVXoD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 19:44:03 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:9746 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264143AbTFVXoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 19:44:01 -0400
Date: Mon, 23 Jun 2003 00:58:05 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       David Woodhouse <dwmw2@cambridge.redhat.com>
Subject: [PATCH] Fix incorrect operator precidence
Message-ID: <20030623005805.D16537@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	David Woodhouse <dwmw2@cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- orig/drivers/mtd/mtd_blkdevs.c	Sat Jun 14 22:33:57 2003
+++ linux/drivers/mtd/mtd_blkdevs.c	Mon Jun 23 00:43:14 2003
@@ -46,7 +46,7 @@
 	nsect = req->current_nr_sectors;
 	buf = req->buffer;
 
-	if (!req->flags & REQ_CMD)
+	if (!(req->flags & REQ_CMD))
 		return 0;
 
 	if (block + nsect > get_capacity(req->rq_disk))

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

