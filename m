Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262216AbVBQOnV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262216AbVBQOnV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 09:43:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262193AbVBQOma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 09:42:30 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:44036 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262216AbVBQOlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 09:41:35 -0500
Date: Thu, 17 Feb 2005 15:41:29 +0100
From: Adrian Bunk <bunk@stusta.de>
To: jgarzik@pobox.com
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/net/3c509.c: make 2 structs static
Message-ID: <20050217144129.GI24808@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes two needlessly global structs static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/net/3c509.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.11-rc3-mm2-full/drivers/net/3c509.c.old	2005-02-16 15:12:23.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/3c509.c	2005-02-16 15:12:44.000000000 +0100
@@ -214,7 +214,7 @@
 #endif
 
 #ifdef CONFIG_EISA
-struct eisa_device_id el3_eisa_ids[] = {
+static struct eisa_device_id el3_eisa_ids[] = {
 		{ "TCM5092" },
 		{ "TCM5093" },
 		{ "" }
@@ -222,7 +222,7 @@
 
 static int el3_eisa_probe (struct device *device);
 
-struct eisa_driver el3_eisa_driver = {
+static struct eisa_driver el3_eisa_driver = {
 		.id_table = el3_eisa_ids,
 		.driver   = {
 				.name    = "3c509",

