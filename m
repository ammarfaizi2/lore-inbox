Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261279AbVCOOjK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261279AbVCOOjK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 09:39:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261280AbVCOOjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 09:39:10 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:30223 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261279AbVCOOjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 09:39:05 -0500
Date: Tue, 15 Mar 2005 15:39:03 +0100
From: Adrian Bunk <bunk@stusta.de>
To: marcel@holtmann.org, maxk@qualcomm.com
Cc: bluez-devel@lists.sf.net, netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] net/bluetooth/rfcomm/core.: make a variable static
Message-ID: <20050315143903.GK3189@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a needlessly global variable static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.11-mm3-full/net/bluetooth/rfcomm/core.c.old	2005-03-15 13:21:50.000000000 +0100
+++ linux-2.6.11-mm3-full/net/bluetooth/rfcomm/core.c	2005-03-15 13:22:03.000000000 +0100
@@ -68,7 +68,7 @@
 #define rfcomm_lock()	down(&rfcomm_sem);
 #define rfcomm_unlock()	up(&rfcomm_sem);
 
-unsigned long rfcomm_event;
+static unsigned long rfcomm_event;
 
 static LIST_HEAD(session_list);
 static atomic_t terminate, running;

