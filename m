Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933882AbWKTCYO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933882AbWKTCYO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 21:24:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933878AbWKTCYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 21:24:13 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:44561 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S933879AbWKTCYH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 21:24:07 -0500
Date: Mon, 20 Nov 2006 03:24:06 +0100
From: Adrian Bunk <bunk@stusta.de>
To: mhalcrow@us.ibm.com, phillip@hellewell.homeip.net
Cc: ecryptfs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [2.6 patch] make ecryptfs_version_str_map[] static
Message-ID: <20061120022406.GM31879@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the needlessly global ecryptfs_version_str_map[] 
static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.19-rc5-mm2/fs/ecryptfs/main.c.old	2006-11-20 01:27:17.000000000 +0100
+++ linux-2.6.19-rc5-mm2/fs/ecryptfs/main.c	2006-11-20 01:27:25.000000000 +0100
@@ -692,7 +692,7 @@
 
 static struct ecryptfs_attribute sysfs_attr_version = __ATTR_RO(version);
 
-struct ecryptfs_version_str_map_elem {
+static struct ecryptfs_version_str_map_elem {
 	u32 flag;
 	char *str;
 } ecryptfs_version_str_map[] = {

