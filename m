Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbVBQU1N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbVBQU1N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 15:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262295AbVBQU1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 15:27:13 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:43787 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261184AbVBQU1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 15:27:04 -0500
Date: Thu, 17 Feb 2005 21:27:03 +0100
From: Adrian Bunk <bunk@stusta.de>
To: jgarzik@pobox.com
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/net/depca.c: make 2 structs static
Message-ID: <20050217202703.GB6194@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes two needlessly global structs static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/net/depca.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.11-rc3-mm2-full/drivers/net/depca.c.old	2005-02-16 15:24:46.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/depca.c	2005-02-16 15:25:08.000000000 +0100
@@ -342,14 +342,14 @@
 static int depca_device_remove (struct device *device);
 
 #ifdef CONFIG_EISA
-struct eisa_device_id depca_eisa_ids[] = {
+static struct eisa_device_id depca_eisa_ids[] = {
 	{ "DEC4220", de422 },
 	{ "" }
 };
 
 static int depca_eisa_probe  (struct device *device);
 
-struct eisa_driver depca_eisa_driver = {
+static struct eisa_driver depca_eisa_driver = {
 	.id_table = depca_eisa_ids,
 	.driver   = {
 		.name    = depca_string,

