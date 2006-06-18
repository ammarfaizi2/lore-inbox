Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751201AbWFRPtI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbWFRPtI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 11:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbWFRPsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 11:48:38 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:3219 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751204AbWFRPse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 11:48:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=RbPhwkjwOu/MtNZbjT2lqMckALp8qBlwDlML93rYPlPNhTy3mUVRMbTjbWADqKY7mhX0jCDdMcUPfmstMmFshoByva8vBo7Yae71Fowe2YJrqwWlr4zKyD8fH9g78KhqcevSSm+IBYsR1obx+1sC6bxoewHg6VJI8osR6NTP70I=
Message-ID: <449572C6.7010302@gmail.com>
Date: Sun, 18 Jun 2006 23:35:34 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Greg KH <gregkh@suse.de>, Jakub Jelinek <jj@ultra.linux.cz>,
       ecd@skynet.be
Subject: [PATCH 8/9] VT binding: Make promcon support binding
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do not mark promcon_startup() and promcon_init_unimap() as __init

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/console/promcon.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/console/promcon.c b/drivers/video/console/promcon.c
index 04f42fc..d6e6ad5 100644
--- a/drivers/video/console/promcon.c
+++ b/drivers/video/console/promcon.c
@@ -109,7 +109,7 @@ promcon_end(struct vc_data *conp, char *
 	return b - p;
 }
 
-const char __init *promcon_startup(void)
+const char *promcon_startup(void)
 {
 	const char *display_desc = "PROM";
 	int node;
@@ -133,7 +133,7 @@ const char __init *promcon_startup(void)
 	return display_desc;
 }
 
-static void __init 
+static void
 promcon_init_unimap(struct vc_data *conp)
 {
 	mm_segment_t old_fs = get_fs();

