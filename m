Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271934AbTHDQyJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 12:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271937AbTHDQyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 12:54:09 -0400
Received: from dns.toxicfilms.tv ([150.254.37.24]:65202 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP id S271934AbTHDQyE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 12:54:04 -0400
Date: Mon, 4 Aug 2003 18:53:53 +0200 (CEST)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] post-halloween consolidation.
Message-ID: <Pine.LNX.4.51.0308041852110.22851@dns.toxicfilms.tv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

post-halloween contains two similar sections:

Deprecated features
~~~~~~~~~~~~~~~~~~~

and

Deprecated
~~~~~~~~~~

This patch joins these sections together.

Regards,
Maciej Soltysiak

--- post-halloween-2.5.txt	2003-08-04 18:49:17.000000000 +0200
+++ post-halloween-2.5.txt.1	2003-08-04 18:49:38.000000000 +0200
@@ -87,6 +87,15 @@
   You should now use a boot loader program instead.
 - Callout tty devices (/dev/cua) have been deprecated since 2.1.90pre2.
   Support is now removed.
+- usbdevfs will be going away in 2.7. The same filesystem can
+  be mounted as 'usbfs' in recent 2.4 kernels, and in 2.5.52
+  and above, which is what the filesystem will furthermore be
+  known as.
+- elvtune is deprecated (as are the ioctl's it used).
+  Instead, the io scheduler tunables are exported in sysfs (see below)
+  in the /sys/block/<device>/iosched directory.
+  Jens wrote a document explaining the tunables of the new scheduler at
+  http://www.lib.uaa.alaska.edu/linux-kernel/archive/2002-Week-44/att-deadline-iosched.txt

 Modules.
 ~~~~~~~~
@@ -887,18 +896,6 @@
 - The in-kernel loopback device can now do crypto using the CryptoAPI.
   May need new userspace tools.

-Deprecated.
-~~~~~~~~~~~
-- usbdevfs will be going away in 2.7. The same filesystem can
-  be mounted as 'usbfs' in recent 2.4 kernels, and in 2.5.52
-  and above, which is what the filesystem will furthermore be
-  known as.
-- elvtune is deprecated (as are the ioctl's it used).
-  Instead, the io scheduler tunables are exported in sysfs (see below)
-  in the /sys/block/<device>/iosched directory.
-  Jens wrote a document explaining the tunables of the new scheduler at
-  http://www.lib.uaa.alaska.edu/linux-kernel/archive/2002-Week-44/att-deadline-iosched.txt
-


 Ports.

