Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263779AbTEODTk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 23:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263780AbTEODSp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 23:18:45 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:7404 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S263782AbTEODSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 23:18:17 -0400
Date: Thu, 15 May 2003 04:31:05 +0100
Message-Id: <200305150331.h4F3V5A6000592@deviant.impure.org.uk>
To: torvalds@transmeta.com
From: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Fix ISDN return types.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/isdn/i4l/isdn_net_lib.c linux-2.5/drivers/isdn/i4l/isdn_net_lib.c
--- bk-linus/drivers/isdn/i4l/isdn_net_lib.c	2003-04-10 06:01:19.000000000 +0100
+++ linux-2.5/drivers/isdn/i4l/isdn_net_lib.c	2003-03-26 19:06:04.000000000 +0000
@@ -1777,6 +1776,7 @@ bhup(struct fsm_inst *fi, int pr, void *
 
 	printk(KERN_INFO "%s: disconnected\n", idev->name);
 	fsm_change_state(fi, ST_WAIT_DHUP);
+	return 0;
 }
 
 static int
@@ -1898,7 +1898,7 @@ isdn_net_event_callback(struct isdn_slot
 static int
 isdn_net_handle_event(isdn_net_dev *idev, int pr, void *arg)
 {
-	fsm_event(&idev->fi, pr, arg);
+	return fsm_event(&idev->fi, pr, arg);
 }
 
 static int
