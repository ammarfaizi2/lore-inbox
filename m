Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262000AbUCNXCl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 18:02:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262002AbUCNXCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 18:02:41 -0500
Received: from dh132.citi.umich.edu ([141.211.133.132]:2439 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S262000AbUCNXCk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 18:02:40 -0500
Subject: [PATCH] export fb_find_mode
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1079305357.3093.60.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 14 Mar 2004 18:02:38 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The latest BK tree is missing an export in order to satisfy radeonfb
etc. module dependencies.

Cheers,
  Trond

--- linux-2.6.4/drivers/video/modedb.c.orig	2004-03-14 17:21:03.000000000 -0500
+++ linux-2.6.4/drivers/video/modedb.c	2004-03-14 17:59:33.000000000 -0500
@@ -554,5 +554,6 @@
     return 0;
 }
 
+EXPORT_SYMBOL(fb_find_mode);
 EXPORT_SYMBOL(__fb_try_mode);
 EXPORT_SYMBOL(vesa_modes);

