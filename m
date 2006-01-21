Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932358AbWAUVZN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932358AbWAUVZN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 16:25:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932365AbWAUVZM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 16:25:12 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:30595 "EHLO smtp1-g19.free.fr")
	by vger.kernel.org with ESMTP id S932358AbWAUVZL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 16:25:11 -0500
To: philb@gnu.org, tim@cyberelk.net, campbell@torque.net, andrea@suse.de
Cc: linux-parport@lists.infradead.org, linux-kernel@vger.kernel.org,
       trivial@kernel.org
Subject: [PATCH] parport: fix printk format strings
From: Arnaud Giersch <arnaud.giersch@free.fr>
Date: Sat, 21 Jan 2006 22:25:09 +0100
Message-ID: <87lkx9e0ju.fsf@groumpf.homeip.net>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaud Giersch <arnaud.giersch@free.fr>

Fix printk format strings.

Signed-off-by: Arnaud Giersch <arnaud.giersch@free.fr>
---

--- linux-2.6.16-rc1.orig/drivers/parport/probe.c	2006-01-17 08:44:47.000000000 +0100
+++ linux-2.6.16-rc1/drivers/parport/probe.c	2006-01-21 21:39:08.504248053 +0100
@@ -199,8 +199,8 @@ static ssize_t parport_read_device_id (s
 
 		if (port->physport->ieee1284.phase != IEEE1284_PH_HBUSY_DAVAIL) {
 			if (belen != len) {
-				printk (KERN_DEBUG "%s: Device ID was %d bytes"
-					" while device told it would be %d"
+				printk (KERN_DEBUG "%s: Device ID was %zu bytes"
+					" while device told it would be %u"
 					" bytes\n",
 					port->name, len, belen);
 			}
@@ -214,7 +214,7 @@ static ssize_t parport_read_device_id (s
 		if (buffer[len-1] == ';') {
  			printk (KERN_DEBUG "%s: Device ID reading stopped"
 				" before device told data not available. "
-				"Current idlen %d of %d, len bytes %02X %02X\n",
+				"Current idlen %u of %u, len bytes %02X %02X\n",
 				port->name, current_idlen, numidlens,
 				length[0], length[1]);
 			goto done;
