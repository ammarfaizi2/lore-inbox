Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266543AbUFVDWn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266543AbUFVDWn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 23:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266544AbUFVDWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 23:22:43 -0400
Received: from mx1.redhat.com ([66.187.233.31]:41709 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266543AbUFVDWl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 23:22:41 -0400
Date: Mon, 21 Jun 2004 20:22:33 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: <marcelo.tosatti@cyclades.com>, zaitcev@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Patchlet for USB 2.4.27-rc1 - extra #include
Message-Id: <20040621202233.7ed8a585@lembas.zaitcev.lan>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

An obvious duplication and my mistake. I tested it to work. The mistake is
not causing any bugs, just makes the code stupid.

This patch comes from Lonnie Mendez - would you attribute it, please?

-- Pete

diff -urp -X dontdiff linux-2.4.27-rc1/drivers/usb/serial/usbserial.c linux-2.4.27-rc1-usb/drivers/usb/serial/usbserial.c
--- linux-2.4.27-rc1/drivers/usb/serial/usbserial.c	2004-06-21 18:39:10.000000000 -0700
+++ linux-2.4.27-rc1-usb/drivers/usb/serial/usbserial.c	2004-06-21 18:51:57.000000000 -0700
@@ -297,7 +297,6 @@
 #include <linux/spinlock.h>
 #include <linux/list.h>
 #include <linux/smp_lock.h>
-#include <linux/spinlock.h>
 #include <linux/usb.h>
 
 #ifdef CONFIG_USB_SERIAL_DEBUG
