Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262238AbVBQPNp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262238AbVBQPNp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 10:13:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262272AbVBQPLk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 10:11:40 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:16646 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262263AbVBQPD7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 10:03:59 -0500
Date: Thu, 17 Feb 2005 16:03:51 +0100
From: Adrian Bunk <bunk@stusta.de>
To: acme@conectiva.com.br
Cc: jgarzik@pobox.com, linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/net/appletalk/: make firmware static
Message-ID: <20050217150351.GM24808@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes some needlessly global firmware static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/net/appletalk/cops_ffdrv.h |    2 +-
 drivers/net/appletalk/cops_ltdrv.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.11-rc3-mm2-full/drivers/net/appletalk/cops_ffdrv.h.old	2005-02-16 15:15:32.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/appletalk/cops_ffdrv.h	2005-02-16 15:15:41.000000000 +0100
@@ -28,7 +28,7 @@
 
 #ifdef CONFIG_COPS_DAYNA
 
-unsigned char ffdrv_code[] = {
+static unsigned char ffdrv_code[] = {
 	58,3,0,50,228,149,33,255,255,34,226,149,
 	249,17,40,152,33,202,154,183,237,82,77,68,
 	11,107,98,19,54,0,237,176,175,50,80,0,
--- linux-2.6.11-rc3-mm2-full/drivers/net/appletalk/cops_ltdrv.h.old	2005-02-16 15:15:50.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/appletalk/cops_ltdrv.h	2005-02-16 15:15:58.000000000 +0100
@@ -27,7 +27,7 @@
 
 #ifdef CONFIG_COPS_TANGENT
 
-unsigned char ltdrv_code[] = {
+static unsigned char ltdrv_code[] = {
 	58,3,0,50,148,10,33,143,15,62,85,119,
 	190,32,9,62,170,119,190,32,3,35,24,241,
 	34,146,10,249,17,150,10,33,143,15,183,237,

