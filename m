Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265148AbTL2W6j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 17:58:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265149AbTL2W6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 17:58:39 -0500
Received: from fep01-mail.bloor.is.net.cable.rogers.com ([66.185.86.71]:3687
	"EHLO fep01-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id S265148AbTL2W6i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 17:58:38 -0500
Date: Mon, 29 Dec 2003 17:58:37 -0500
From: Omkhar Arasaratnam <omkhar@rogers.com>
To: emoenke@gwdg.de
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [PATCH] drivers/cdrom/sjcd.c check_region() fix - take 2
Message-ID: <20031229225837.GA17304@omkhar.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at fep01-mail.bloor.is.net.cable.rogers.com from [24.192.237.88] using ID <omkhar@rogers.com> at Mon, 29 Dec 2003 17:56:40 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My apologize for the first patch, this one should work better
(and be kinder to patch :)

--- linux-clean/drivers/cdrom/sjcd.c.org	2003-12-29 17:32:00.000000000 -0500
+++ linux-clean/drivers/cdrom/sjcd.c	2003-12-29 17:53:42.000000000 -0500
@@ -1700,7 +1700,7 @@
 	sprintf(sjcd_disk->disk_name, "sjcd");
 	sprintf(sjcd_disk->devfs_name, "sjcd");
 
-	if (check_region(sjcd_base, 4)) {
+	if (!request_region(sjcd_base, 4,"sjcd")) {
 		printk
 		    ("SJCD: Init failed, I/O port (%X) is already in use\n",
 		     sjcd_base);

O
