Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262351AbUEWIst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262351AbUEWIst (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 04:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262389AbUEWIst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 04:48:49 -0400
Received: from mx4.cs.washington.edu ([128.208.4.190]:12744 "EHLO
	mx4.cs.washington.edu") by vger.kernel.org with ESMTP
	id S262351AbUEWIsr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 04:48:47 -0400
Date: Sun, 23 May 2004 01:48:45 -0700 (PDT)
From: Vadim Lobanov <vadim@cs.washington.edu>
To: netdev@oss.sgi.com, <linux-kernel@vger.kernel.org>
Subject: [PATCH] Trivial patch in /net/core/net-sysfs.c
Message-ID: <20040523014005.R31528-100000@attu2.cs.washington.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here is a trivial patch to /net/core/net-sysfs.c, to remove 3 unnecessary 
word lengths from memory. Diffed against the base 2.6.6 tree. Please note 
that this is a first stab at attempting to submit a patch, so let me know if
something's not quite right, so that I can rework it. :)

=========================================================================

--- linux-2.6.6/net/core/net-sysfs.c    2004-05-09 19:33:19.000000000 
-0700
+++ linux-2.6.6/net/core/net-sysfs.c    2004-05-23 01:33:57.000000000 
-0700
@@ -20,9 +20,9 @@
 #define to_class_dev(obj) container_of(obj,struct class_device,kobj)
 #define to_net_dev(class) container_of(class, struct net_device, 
class_dev)
 
-static const char *fmt_hex = "%#x\n";
-static const char *fmt_dec = "%d\n";
-static const char *fmt_ulong = "%lu\n";
+static const char fmt_hex[] = "%#x\n";
+static const char fmt_dec[] = "%d\n";
+static const char fmt_ulong[] = "%lu\n";
 
 static inline int dev_isalive(const struct net_device *dev) 
 {

========================================================================

-Vadim Lobanov

