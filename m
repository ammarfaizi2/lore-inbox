Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264114AbUDVPKd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264114AbUDVPKd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 11:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264116AbUDVPKd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 11:10:33 -0400
Received: from waste.org ([209.173.204.2]:17560 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S264114AbUDVPK2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 11:10:28 -0400
Date: Thu, 22 Apr 2004 10:10:13 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix CONFIG_SYSFS=n compile warning
Message-ID: <20040422151010.GK28459@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From -tiny

Index: tiny/init/do_mounts.c
===================================================================
--- tiny.orig/init/do_mounts.c	2004-04-21 12:49:23.000000000 -0500
+++ tiny/init/do_mounts.c	2004-04-22 10:07:45.000000000 -0500
@@ -194,9 +194,11 @@
 	p[-1] = '\0';
 	res = try_name(s, part);
 done:
+#ifdef CONFIG_SYSFS
 	sys_umount("/sys", 0);
 out:
 	sys_rmdir("/sys");
+#endif
 	return res;
 fail:
 	res = 0;


-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
