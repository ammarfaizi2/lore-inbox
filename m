Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030251AbWARFOx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030251AbWARFOx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 00:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030250AbWARFOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 00:14:35 -0500
Received: from xenotime.net ([66.160.160.81]:28073 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1030240AbWARFOd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 00:14:33 -0500
Date: Tue, 17 Jan 2006 21:12:42 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH] parport: fix printk format warning
Message-Id: <20060117211242.4bf760a4.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Fix printk format warning:
drivers/parport/probe.c:205: warning: format '%d' expects type 'int', but argument 3 has type 'size_t'

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/parport/probe.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2616-rc1.orig/drivers/parport/probe.c
+++ linux-2616-rc1/drivers/parport/probe.c
@@ -199,7 +199,7 @@ static ssize_t parport_read_device_id (s
 
 		if (port->physport->ieee1284.phase != IEEE1284_PH_HBUSY_DAVAIL) {
 			if (belen != len) {
-				printk (KERN_DEBUG "%s: Device ID was %d bytes"
+				printk (KERN_DEBUG "%s: Device ID was %zd bytes"
 					" while device told it would be %d"
 					" bytes\n",
 					port->name, len, belen);


---
~Randy
