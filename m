Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262830AbTEGEQS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 00:16:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262834AbTEGEQS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 00:16:18 -0400
Received: from [203.145.184.221] ([203.145.184.221]:39950 "EHLO naturesoft.net")
	by vger.kernel.org with ESMTP id S262830AbTEGEQR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 00:16:17 -0400
Subject: [PATCH 2.5.69-ac1] kill del_timer in floppy98.c
From: Vinay K Nallamothu <vinay-rc@naturesoft.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 07 May 2003 10:03:55 +0530
Message-Id: <1052282035.1189.16.camel@lima.royalchallenge.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Missed out killing del_timer while converting {del,add}_timer to mod_timer.
Please apply.

Thanks
vinay

--- linux-2.5.69-ac1/drivers/block/floppy98.c	2003-05-07 09:55:00.000000000 +0530
+++ linux-2.5.69-ac1-nvk/drivers/block/floppy98.c	2003-05-07 09:58:44.000000000 +0530
@@ -706,7 +706,6 @@
 
 	if (drive == current_reqD)
 		drive = current_drive;
-	del_timer(&fd_timeout);
 	if (drive < 0 || drive > N_DRIVE) {
 		delay = jiffies + 20UL*HZ;
 		drive=0;



