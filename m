Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265429AbUGDHD5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265429AbUGDHD5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 03:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265431AbUGDHD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 03:03:57 -0400
Received: from ozlabs.org ([203.10.76.45]:57222 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S265429AbUGDHDz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 03:03:55 -0400
Date: Sun, 4 Jul 2004 17:01:44 +1000
From: Anton Blanchard <anton@samba.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gcc 3.5 fixes
Message-ID: <20040704070144.GB4923@krispykreme>
References: <20040704065811.GA4923@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040704065811.GA4923@krispykreme>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


gcc 3.5 is warning about unused static variables, add __attribute_unused__
to the 2 places to silence it.

Signed-off-by: Anton Blanchard <anton@samba.org>

diff -ur /root/toolchain/linux-2.5-bk/kernel/configs.c linux-2.5-bk/kernel/configs.c
--- /root/toolchain/linux-2.5-bk/kernel/configs.c	2004-06-25 09:13:15.000000000 +0000
+++ linux-2.5-bk/kernel/configs.c	2004-07-03 11:03:45.019878184 +0000
@@ -58,7 +58,7 @@
 /**************************************************/
 /* globals and useful constants                   */
 
-static const char IKCONFIG_VERSION[] __initdata = "0.7";
+static const char IKCONFIG_VERSION[] __attribute_used__ __initdata = "0.7";
 
 static ssize_t
 ikconfig_read_current(struct file *file, char __user *buf,
diff -ur /root/toolchain/linux-2.5-bk/lib/zlib_inflate/inftrees.c linux-2.5-bk/lib/zlib_inflate/inftrees.c
--- /root/toolchain/linux-2.5-bk/lib/zlib_inflate/inftrees.c	2004-02-22 13:48:07.000000000 +0000
+++ linux-2.5-bk/lib/zlib_inflate/inftrees.c	2004-07-03 11:27:06.633933752 +0000
@@ -7,7 +7,7 @@
 #include "inftrees.h"
 #include "infutil.h"
 
-static const char inflate_copyright[] =
+static const char inflate_copyright[] __attribute_used__ =
    " inflate 1.1.3 Copyright 1995-1998 Mark Adler ";
 /*
   If you use the zlib library in a product, an acknowledgment is welcome

