Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030366AbWK3PMt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030366AbWK3PMt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 10:12:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967837AbWK3PMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 10:12:49 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:43984 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S967836AbWK3PMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 10:12:48 -0500
Date: Thu, 30 Nov 2006 15:12:44 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Andrew Morton <akpm@osdl.org>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Video Select set for VESA FB
Message-ID: <Pine.LNX.4.64.0611301509300.11840@pentafluge.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 
	This patch automatically set VIDEO_SELECT when you select VESA FB. 
Currently if you select VESA FB with fbcon but don't select VGA console 
the box will not have its video mode set. Thus you get a blank screen.
Please apply.

Signed-off-by: James Simmons <jsimmons@infradead.org>

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 7a43020..c3fcf04 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -551,6 +551,7 @@ config FB_VESA
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
+	select VIDEO_SELECT
 	help
 	  This is the frame buffer device driver for generic VESA 2.0
 	  compliant graphic cards. The older VESA 1.2 cards are not supported.
