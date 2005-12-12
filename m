Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932238AbVLLXqP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932238AbVLLXqP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 18:46:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932226AbVLLXqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 18:46:15 -0500
Received: from mx1.redhat.com ([66.187.233.31]:30371 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932233AbVLLXqO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 18:46:14 -0500
Date: Mon, 12 Dec 2005 23:45:49 GMT
Message-Id: <200512122345.jBCNjn1u009061@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, arjan@infradead.org,
       matthew@wil.cx
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Fcc: outgoing
Subject: [PATCH 18/19] MUTEX: Security changes
In-Reply-To: <dhowells1134431145@warthog.cambridge.redhat.com>
References: <dhowells1134431145@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch modifies the security files to use the new mutex functions.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 mutex-security-2615rc5.diff
 security/selinux/hooks.c          |    2 +-
 security/selinux/selinuxfs.c      |    2 +-
 security/selinux/ss/conditional.c |    2 +-
 security/selinux/ss/services.c    |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff -uNrp /warthog/kernels/linux-2.6.15-rc5/security/selinux/hooks.c linux-2.6.15-rc5-mutex/security/selinux/hooks.c
--- /warthog/kernels/linux-2.6.15-rc5/security/selinux/hooks.c	2005-12-08 16:23:57.000000000 +0000
+++ linux-2.6.15-rc5-mutex/security/selinux/hooks.c	2005-12-12 22:12:50.000000000 +0000
@@ -50,7 +50,7 @@
 #include <net/ip.h>		/* for sysctl_local_port_range[] */
 #include <net/tcp.h>		/* struct or_callable used in sock_rcv_skb */
 #include <asm/uaccess.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 #include <asm/ioctls.h>
 #include <linux/bitops.h>
 #include <linux/interrupt.h>
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/security/selinux/selinuxfs.c linux-2.6.15-rc5-mutex/security/selinux/selinuxfs.c
--- /warthog/kernels/linux-2.6.15-rc5/security/selinux/selinuxfs.c	2005-12-08 16:23:57.000000000 +0000
+++ linux-2.6.15-rc5-mutex/security/selinux/selinuxfs.c	2005-12-12 22:12:50.000000000 +0000
@@ -22,7 +22,7 @@
 #include <linux/seq_file.h>
 #include <linux/percpu.h>
 #include <asm/uaccess.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 
 /* selinuxfs pseudo filesystem for exporting the security policy API.
    Based on the proc code and the fs/nfsd/nfsctl.c code. */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/security/selinux/ss/conditional.c linux-2.6.15-rc5-mutex/security/selinux/ss/conditional.c
--- /warthog/kernels/linux-2.6.15-rc5/security/selinux/ss/conditional.c	2005-12-08 16:23:57.000000000 +0000
+++ linux-2.6.15-rc5-mutex/security/selinux/ss/conditional.c	2005-12-12 22:12:50.000000000 +0000
@@ -11,7 +11,7 @@
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/spinlock.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 #include <linux/slab.h>
 
 #include "security.h"
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/security/selinux/ss/services.c linux-2.6.15-rc5-mutex/security/selinux/ss/services.c
--- /warthog/kernels/linux-2.6.15-rc5/security/selinux/ss/services.c	2005-12-08 16:23:57.000000000 +0000
+++ linux-2.6.15-rc5-mutex/security/selinux/ss/services.c	2005-12-12 22:12:50.000000000 +0000
@@ -27,7 +27,7 @@
 #include <linux/in.h>
 #include <linux/sched.h>
 #include <linux/audit.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 #include "flask.h"
 #include "avc.h"
 #include "avc_ss.h"
