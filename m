Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261588AbVAGUc0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261588AbVAGUc0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 15:32:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261596AbVAGUaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 15:30:25 -0500
Received: from mx1.redhat.com ([66.187.233.31]:12446 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261597AbVAGU2l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 15:28:41 -0500
Date: Fri, 7 Jan 2005 15:27:58 -0500
From: Neil Horman <nhorman@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org
Subject: [PATCH] kernel: fix build break to kernel/sys.c
Message-ID: <20050107202758.GA28018@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch to fix build break in kernel/sys.c, introduced by adding use of tty_sem
to sys.c without including extern reference in tty.h

sys.c |    1 +
 1 files changed, 1 insertion(+)

Signed-off-by: Neil Horman <nhorman@redhat.com>


--- linux-2.6-latest-appletalk/kernel/sys.c.old	2005-01-07 14:10:22.199884472 -0500
+++ linux-2.6-latest-appletalk/kernel/sys.c	2005-01-07 14:10:52.160329792 -0500
@@ -23,6 +23,7 @@
 #include <linux/security.h>
 #include <linux/dcookies.h>
 #include <linux/suspend.h>
+#include <linux/tty.h>
 
 #include <linux/compat.h>
 #include <linux/syscalls.h>
-- 
/***************************************************
 *Neil Horman
 *Software Engineer
 *Red Hat, Inc.
 *nhorman@redhat.com
 *gpg keyid: 1024D / 0x92A74FA1
 *http://pgp.mit.edu
 ***************************************************/
