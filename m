Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267804AbUJQVJh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267804AbUJQVJh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 17:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269286AbUJQVJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 17:09:37 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:11138 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S267804AbUJQVI6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 17:08:58 -0400
Date: Sun, 17 Oct 2004 23:08:48 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Add VIDIOC_S_CTRL_OLD to matroxfb
Message-ID: <20041017210848.GA9040@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew,
   for several months I'm receiving complaints from matroxfb users that v4lctl suddenly
stops working for them on kernel upgrade.  Problem is that VIDIOC_S_CTRL was renumbered,
but all distros still use old VIDIOC_S_CTRL value (f.e. even xawtv-3.94 in Debian unstable
still uses old VIDIOC_S_CTRL definition).  So let's add this old VIDIOC_S_CTRL value
(now named VIDIOC_S_CTRL_OLD) to matroxfb's v4l handling.
							Thanks,
								Petr Vandrovec

Signed-off-by: Petr Vandrovec <vandrove@vc.cvut.cz>

diff -urdN linux/drivers/video/matrox/matroxfb_base.c linux/drivers/video/matrox/matroxfb_base.c
--- linux/drivers/video/matrox/matroxfb_base.c	2004-10-17 22:15:06.000000000 +0200
+++ linux/drivers/video/matrox/matroxfb_base.c	2004-10-17 22:28:34.000000000 +0200
@@ -1143,6 +1143,7 @@
 					return -EFAULT;
 				return err;
 			}
+		case VIDIOC_S_CTRL_OLD:
 		case VIDIOC_S_CTRL:
 			{
 				struct v4l2_control ctrl;
