Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261238AbUKFBYS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261238AbUKFBYS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 20:24:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261269AbUKFBYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 20:24:18 -0500
Received: from fw.osdl.org ([65.172.181.6]:57760 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261238AbUKFBYP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 20:24:15 -0500
Date: Fri, 5 Nov 2004 17:24:14 -0800
From: Chris Wright <chrisw@osdl.org>
To: marcelo.tosatti@cyclades.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] compile fix for neighbour scalability backport
Message-ID: <20041105172414.L14339@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compile fix for neighbour scalability backport.

neighbour.c:1901: error: `THIS_MODULE' undeclared here (not in a function)
neighbour.c:1901: error: initializer element is not constant
neighbour.c:1901: error: (near initialization for `neigh_stat_seq_fops.owner')

Signed-off-by: Chris Wright <chrisw@osdl.org>

===== net/core/neighbour.c 1.14 vs edited =====
--- 1.14/net/core/neighbour.c	2004-10-05 11:40:25 -07:00
+++ edited/net/core/neighbour.c	2004-11-05 17:13:03 -08:00
@@ -19,6 +19,7 @@
 #include <linux/config.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/socket.h>
 #include <linux/sched.h>
 #include <linux/netdevice.h>
