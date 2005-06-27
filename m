Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262074AbVF0Nhk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262074AbVF0Nhk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 09:37:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262138AbVF0NfH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 09:35:07 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:30181 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262088AbVF0MQ7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 08:16:59 -0400
Message-Id: <20050627121411.339885000@abc>
References: <20050627120600.739151000@abc>
Date: Mon, 27 Jun 2005 14:06:09 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org,
       Hartmut Hackmann <hartmut.hackmann@t-online.de>
Content-Disposition: inline; filename=dvb-frontend-tda1004x-firmware-version-check-fix.patch
X-SA-Exim-Connect-IP: 84.189.248.249
Subject: [DVB patch 09/51] frontend: bcm3510: fix firmware version check
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hartmut Hackmann <hartmut.hackmann@t-online.de>

Fix limit for firmware version check was too low for tda10045.

Signed-off-by: Hartmut Hackmann <hartmut.hackmann@t-online.de>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/frontends/tda1004x.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.12-git8/drivers/media/dvb/frontends/tda1004x.c
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/frontends/tda1004x.c	2005-06-27 13:23:02.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/frontends/tda1004x.c	2005-06-27 13:23:03.000000000 +0200
@@ -349,7 +349,7 @@ static int tda1004x_check_upload_ok(stru
 
 	data1 = tda1004x_read_byte(state, TDA1004X_DSP_DATA1);
 	data2 = tda1004x_read_byte(state, TDA1004X_DSP_DATA2);
-	if (data1 != 0x67 || data2 < 0x20 || data2 > 0x2a) {
+	if (data1 != 0x67 || data2 < 0x20 || data2 > 0x2e) {
 		printk(KERN_INFO "tda1004x: found firmware revision %x -- invalid\n", data2);
 		return -EIO;
 	}

--

