Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759291AbWLAOaa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759291AbWLAOaa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 09:30:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759298AbWLAOaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 09:30:30 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:2573 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S1759291AbWLAOaa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 09:30:30 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: Willy Tarreau <wtarreau@hera.kernel.org>
Subject: [2.4 PATCH] ide legacy hd parenthesis fix
Date: Fri, 1 Dec 2006 15:30:05 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612011530.05443.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	This patch removes an extra parenthesis from read_intr() debug code.

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 drivers/ide/legacy/hd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.4.34-pre6-a/drivers/ide/legacy/hd.c	2006-12-01 11:46:04.000000000 +0100
+++ linux-2.4.34-pre6-b/drivers/ide/legacy/hd.c	2006-12-01 12:27:16.000000000 +0100
@@ -432,7 +432,7 @@ ok_to_read:
 #ifdef DEBUG
 	printk("hd%c: read: sector %ld, remaining = %ld, buffer=0x%08lx\n",
 		dev+'a', CURRENT->sector, CURRENT->nr_sectors,
-		(unsigned long) CURRENT->buffer+512));
+		(unsigned long) CURRENT->buffer+512);
 #endif
 	if (CURRENT->current_nr_sectors <= 0)
 		end_request(1);


-- 
Regards,

	Mariusz Kozlowski
