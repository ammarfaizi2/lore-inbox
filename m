Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315967AbSEGUui>; Tue, 7 May 2002 16:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315968AbSEGUuh>; Tue, 7 May 2002 16:50:37 -0400
Received: from pD9E23EE2.dip.t-dialin.net ([217.226.62.226]:53151 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S315967AbSEGUug>; Tue, 7 May 2002 16:50:36 -0400
Date: Tue, 7 May 2002 14:50:35 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Possible SCSI (sr) mini-cleanup
Message-ID: <Pine.LNX.4.44.0205071445480.4189-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I don't see where the variable and the label have been used. Are they 
useful for anything? If they are, tell me please!

							       Regards,
								Thunder

diff -Nur linus-2.5/drivers/scsi/sr.c thunder-2.5/drivers/scsi/sr.c
--- linus-2.5/drivers/scsi/sr.c	Tue May  7 14:28:57 2002
+++ thunder-2.5/drivers/scsi/sr.c	Tue May  7 14:27:10 2002
@@ -697,8 +697,6 @@
 
 static int sr_init()
 {
-	int i;
-
 	if (sr_template.dev_noticed == 0)
 		return 0;
 
@@ -723,8 +721,6 @@
 		goto cleanup_cds;
 	memset(sr_sizes, 0, sr_template.dev_max * sizeof(int));
 	return 0;
-cleanup_sizes:
-	kfree(sr_sizes);
 cleanup_cds:
 	kfree(scsi_CDs);
 cleanup_devfs:
-- 
if (errno == ENOTAVAIL)
    fprintf(stderr, "Error: Talking to Microsoft server!\n");

