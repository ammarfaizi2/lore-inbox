Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268037AbUIFOCt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268037AbUIFOCt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 10:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268039AbUIFOCs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 10:02:48 -0400
Received: from cantor.suse.de ([195.135.220.2]:26811 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268037AbUIFOCp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 10:02:45 -0400
Date: Mon, 6 Sep 2004 16:02:44 +0200
From: Olaf Hering <olh@suse.de>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: drivers/cdrom/cdu31a.c broken
Message-ID: <20040906140244.GA9236@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet
  1.1998 04/09/03 10:36:31 janitor@sternwelten.at[torvalds] +1 -0
  [PATCH] cdu31a: replace schedule_timeout() with msleep()


typo, should be ; instead of :

diff -purN linux-2.6.9-rc1-bk13.orig/drivers/cdrom/cdu31a.c linux-2.6.9-rc1-bk13/drivers/cdrom/cdu31a.c
--- linux-2.6.9-rc1-bk13.orig/drivers/cdrom/cdu31a.c	2004-09-06 15:23:34.000000000 +0200
+++ linux-2.6.9-rc1-bk13/drivers/cdrom/cdu31a.c	2004-09-06 15:59:32.549300720 +0200
@@ -959,7 +959,7 @@ retry_cd_operation:
 	if (((result_buffer[0] & 0xf0) == 0x20)
 	    && (num_retries < MAX_CDU31A_RETRIES)) {
 		num_retries++;
-		msleep(100):
+		msleep(100);
 		goto retry_cd_operation;
 	}
 
-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
