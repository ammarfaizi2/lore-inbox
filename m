Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030489AbVIBHDa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030489AbVIBHDa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 03:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030497AbVIBHDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 03:03:30 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:18863 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S1030489AbVIBHD3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 03:03:29 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] remove driverfs references from include/linux/cpu.h and net/sunrpc/rpc_pipe.c
Date: Fri, 2 Sep 2005 08:59:25 +0200
User-Agent: KMail/1.8.2
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
References: <200509020856.33213@bilbo.math.uni-mannheim.de>
In-Reply-To: <200509020856.33213@bilbo.math.uni-mannheim.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509020859.25973@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is against 2.6.10, but still applies cleanly. It's just 
s/driverfs/sysfs/ in these two files.

Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>

--- linux-2.6.10/include/linux/cpu.h	2005-01-01 17:55:38.000000000 +0100
+++ linux-2.6.10/include/linux/cpu.h.fixed	2005-01-07 13:55:36.167681848 +0100
@@ -8,7 +8,7 @@
  * Basic handling of the devices is done in drivers/base/cpu.c
  * and system devices are handled in drivers/base/sys.c. 
  *
- * CPUs are exported via driverfs in the class/cpu/devices/
+ * CPUs are exported via sysfs in the class/cpu/devices/
  * directory. 
  *
  * Per-cpu interfaces can be implemented using a struct device_interface. 
--- linux-2.6.10/net/sunrpc/rpc_pipe.c	2005-01-01 17:55:50.000000000 +0100
+++ linux-2.6.10/net/sunrpc/rpc_pipe.c.fixed	2005-01-07 14:01:05.373634936 +0100
@@ -3,7 +3,7 @@
  *
  * Userland/kernel interface for rpcauth_gss.
  * Code shamelessly plagiarized from fs/nfsd/nfsctl.c
- * and fs/driverfs/inode.c
+ * and fs/sysfs/inode.c
  *
  * Copyright (c) 2002, Trond Myklebust <trond.myklebust@fys.uio.no>
  *
