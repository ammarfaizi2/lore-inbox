Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261579AbVBRX6X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261579AbVBRX6X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 18:58:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261575AbVBRX6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 18:58:22 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:61714 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261569AbVBRX4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 18:56:31 -0500
Date: Sat, 19 Feb 2005 00:56:30 +0100
From: Adrian Bunk <bunk@stusta.de>
To: jgarzik@pobox.com, paulus@samba.org
Cc: linux-ppp@vger.kernel.org, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/net/ppp_deflate.c: make 2 structs static
Message-ID: <20050218235630.GF4337@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes two needlessly global structs static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/net/ppp_deflate.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.11-rc3-mm2-full/drivers/net/ppp_deflate.c.old	2005-02-16 18:06:29.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/ppp_deflate.c	2005-02-16 18:06:45.000000000 +0100
@@ -600,7 +600,7 @@
 /*
  * Procedures exported to if_ppp.c.
  */
-struct compressor ppp_deflate = {
+static struct compressor ppp_deflate = {
 	.compress_proto =	CI_DEFLATE,
 	.comp_alloc =		z_comp_alloc,
 	.comp_free =		z_comp_free,
@@ -618,7 +618,7 @@
 	.owner =		THIS_MODULE
 };
 
-struct compressor ppp_deflate_draft = {
+static struct compressor ppp_deflate_draft = {
 	.compress_proto =	CI_DEFLATE_DRAFT,
 	.comp_alloc =		z_comp_alloc,
 	.comp_free =		z_comp_free,

