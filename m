Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261173AbVAaMl1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261173AbVAaMl1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 07:41:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261178AbVAaMl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 07:41:27 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:38919 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261173AbVAaMlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 07:41:21 -0500
Date: Mon, 31 Jan 2005 13:41:19 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Greg Kroah-Hartman <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: [-mm patch] connector.c: make notify_lock static
Message-ID: <20050131124119.GE18316@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

notify_lock isn't a good name for a global lock.
But since it's not used outside of the file, it can be made static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.11-rc2-mm2-full/drivers/connector/connector.c.old	2005-01-31 13:09:14.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/connector/connector.c	2005-01-31 13:09:28.000000000 +0100
@@ -41,7 +41,7 @@
 module_param(cn_idx, uint, 0);
 module_param(cn_val, uint, 0);
 
-spinlock_t notify_lock = SPIN_LOCK_UNLOCKED;
+static spinlock_t notify_lock = SPIN_LOCK_UNLOCKED;
 static LIST_HEAD(notify_list);
 
 static struct cn_dev cdev;

