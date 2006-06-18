Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750990AbWFRWHa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990AbWFRWHa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 18:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932148AbWFRWHa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 18:07:30 -0400
Received: from wp060.webpack.hosteurope.de ([80.237.132.67]:2192 "EHLO
	wp060.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S932109AbWFRWH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 18:07:29 -0400
Date: Mon, 19 Jun 2006 00:13:06 +0200
From: Hansjoerg Lipp <hjlipp@web.de>
To: Karsten Keil <kkeil@suse.de>
Cc: i4ldeveloper@listserv.isdn4linux.de, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>,
       Tilman Schmidt <tilman@imap.cc>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 1/1] i4l: Gigaset drivers: add IOCTLs to compat_ioctl.h
Message-ID: <gigaset307x.2006.06.19.001.1@hjlipp.my-fqdn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hansjoerg Lipp <hjlipp@web.de>

This patch adds the IOCTLs of the Gigaset drivers to compat_ioctl.h
in order to make them available for 32 bit programs on 64 bit platforms.
Please merge.

Signed-off-by: Hansjoerg Lipp <hjlipp@web.de>
Acked-by: Tilman Schmidt <tilman@imap.cc>
---

 fs/compat_ioctl.c            |    1 +
 include/linux/compat_ioctl.h |    5 +++++
 2 files changed, 6 insertions(+)

diff -urp linux-2.6.17.orig/fs/compat_ioctl.c linux-2.6.17/fs/compat_ioctl.c
--- linux-2.6.17.orig/fs/compat_ioctl.c	2006-04-04 23:29:12.000000000 +0200
+++ linux-2.6.17/fs/compat_ioctl.c	2006-06-18 20:37:17.000000000 +0200
@@ -80,6 +80,7 @@
 #include <net/bluetooth/rfcomm.h>
 
 #include <linux/capi.h>
+#include <linux/gigaset_dev.h>
 
 #include <scsi/scsi.h>
 #include <scsi/scsi_ioctl.h>
diff -urp linux-2.6.17.orig/include/linux/compat_ioctl.h linux-2.6.17/include/linux/compat_ioctl.h
--- linux-2.6.17.orig/include/linux/compat_ioctl.h	2006-04-04 23:29:14.000000000 +0200
+++ linux-2.6.17/include/linux/compat_ioctl.h	2006-06-18 20:37:17.000000000 +0200
@@ -673,6 +673,11 @@ COMPATIBLE_IOCTL(CAPI_SET_FLAGS)
 COMPATIBLE_IOCTL(CAPI_CLR_FLAGS)
 COMPATIBLE_IOCTL(CAPI_NCCI_OPENCOUNT)
 COMPATIBLE_IOCTL(CAPI_NCCI_GETUNIT)
+/* Siemens Gigaset */
+COMPATIBLE_IOCTL(GIGASET_REDIR)
+COMPATIBLE_IOCTL(GIGASET_CONFIG)
+COMPATIBLE_IOCTL(GIGASET_BRKCHARS)
+COMPATIBLE_IOCTL(GIGASET_VERSION)
 /* Misc. */
 COMPATIBLE_IOCTL(0x41545900)		/* ATYIO_CLKR */
 COMPATIBLE_IOCTL(0x41545901)		/* ATYIO_CLKW */
