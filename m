Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261491AbTIKUPI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 16:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261494AbTIKUPI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 16:15:08 -0400
Received: from paiol.terra.com.br ([200.176.3.18]:48615 "EHLO
	paiol.terra.com.br") by vger.kernel.org with ESMTP id S261491AbTIKUPE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 16:15:04 -0400
Message-ID: <3F60D82F.9060808@terra.com.br>
Date: Thu, 11 Sep 2003 17:16:47 -0300
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: torvalds@osdl.org, rmk@arm.linux.org.uk
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] video/sa1000 cleanup
Content-Type: multipart/mixed;
 boundary="------------090504090300010101030504"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090504090300010101030504
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

	Hi,

	This patch, against 2.6-test5 removes an unneeded 
set_current_task(TASK_RUNNING), since schedule_timeout already sets 
the task to TASK_RUNNING.

	Please consider applying.

	Cheers,

Felipe

--------------090504090300010101030504
Content-Type: text/plain;
 name="sa1000-schedule.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sa1000-schedule.patch"

--- linux-2.6.0-test5/drivers/video/sa1100fb.c.orig	2003-09-11 17:09:01.000000000 -0300
+++ linux-2.6.0-test5/drivers/video/sa1100fb.c	2003-09-11 17:09:10.000000000 -0300
@@ -1388,7 +1388,6 @@
 	LCCR0 &= ~LCCR0_LEN;	/* Disable LCD Controller */
 
 	schedule_timeout(20 * HZ / 1000);
-	set_current_state(TASK_RUNNING);
 	remove_wait_queue(&fbi->ctrlr_wait, &wait);
 }
 

--------------090504090300010101030504--

