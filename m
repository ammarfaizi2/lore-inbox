Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266055AbUBBUIy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 15:08:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266037AbUBBUHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 15:07:45 -0500
Received: from mailr-1.tiscali.it ([212.123.84.81]:26758 "EHLO
	mailr-1.tiscali.it") by vger.kernel.org with ESMTP id S266000AbUBBUEY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 15:04:24 -0500
X-BrightmailFiltered: true
Date: Mon, 2 Feb 2004 21:04:22 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: [Compile Regression in 2.4.25-pre8][PATCH 38/42]
Message-ID: <20040202200422.GL6785@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
References: <20040130204956.GA21643@dreamland.darkstar.lan> <Pine.LNX.4.58L.0401301855410.3140@logos.cnet> <20040202180940.GA6367@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040202180940.GA6367@dreamland.darkstar.lan>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


sstfb.c:971: warning: unused variable `i'

The var is used only for debugging.

diff -Nru -X dontdiff linux-2.4-vanilla/drivers/video/sstfb.c linux-2.4/drivers/video/sstfb.c
--- linux-2.4-vanilla/drivers/video/sstfb.c	Fri Jun 13 16:51:37 2003
+++ linux-2.4/drivers/video/sstfb.c	Sat Jan 31 20:39:27 2004
@@ -968,7 +968,9 @@
                        struct fb_info *info)
 {
 #define sst_info	((struct sstfb_info *) info)
+#if (SST_DEBUG_VAR >0)
 	int i;
+#endif
 	u_long p;
 	u32 tmp, val;
 	u32 fbiinit0;

-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Recursion n.:
        See Recursion.
