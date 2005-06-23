Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262406AbVFWNaz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262406AbVFWNaz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 09:30:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261900AbVFWN1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 09:27:38 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:28429 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262406AbVFWNXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 09:23:43 -0400
Date: Thu, 23 Jun 2005 14:23:35 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Pavel Machek <pavel@suse.cz>, Andi Kleen <ak@muc.de>,
       Christoph Hellwig <hch@lst.de>
Subject: [PATCH] Add removal schedule of register_serial/unregister_serial to appropriate file
Message-ID: <20050623142335.A5564@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Pavel Machek <pavel@suse.cz>, Andi Kleen <ak@muc.de>,
	Christoph Hellwig <hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I hope there's no need to explain this in the email; if there is, the
entry isn't good enough. 8)

However, wouldn't it be a good idea if this file was ordered by "when" ?
A quick scan of the file reveals a couple of overdue/forgotten items
(maybe they happened but the entry in the file got missed?):

What:   ACPI S4bios support
When:   May 2005

What:   register_ioctl32_conversion() / unregister_ioctl32_conversion()
When:   April 2005


diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej orig/Documentation/feature-removal-schedule.txt linux/Documentation/feature-removal-schedule.txt
--- orig/Documentation/feature-removal-schedule.txt	Sat May 28 20:58:15 2005
+++ linux/Documentation/feature-removal-schedule.txt	Thu Jun 23 14:19:05 2005
@@ -83,3 +83,13 @@ Why:	Deprecated in favour of the new ioc
 	more efficient.  You should really be using libraw1394 for raw1394
 	access anyway.
 Who:	Jody McIntyre <scjody@steamballoon.com>
+
+---------------------------
+
+What:	register_serial/unregister_serial
+When:	December 2005
+Why:	This interface does not allow serial ports to be registered against
+	a struct device, and as such does not allow correct power management
+	of such ports.  8250-based ports should use serial8250_register_port
+	and serial8250_unregister_port instead.
+Who:	Russell King <rmk@arm.linux.org.uk>

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
