Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261845AbUKHOv4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261845AbUKHOv4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 09:51:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbUKHOem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 09:34:42 -0500
Received: from mx1.redhat.com ([66.187.233.31]:64192 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261837AbUKHOc7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 09:32:59 -0500
Date: Mon, 8 Nov 2004 14:32:31 GMT
Message-Id: <200411081432.iA8EWVqS023361@warthog.cambridge.redhat.com>
From: dhowells@redhat.com
To: torvalds@osdl.org, akpm@osdl.org, davidm@snapgear.com
cc: linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Subject: [PATCH] Remove unnecessary inclusions of asm/a.out.h
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch removes some unnecessary inclusions of asm/a.out.h, thus
allowing an arch to dispense with it.

Signed-Off-By: dhowells@redhat.com
---
diffstat aouth-2610rc1mm3.diff
 exec.c       |    1 -
 proc/kcore.c |    1 -
 2 files changed, 2 deletions(-)

diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/fs/exec.c linux-2.6.10-rc1-mm3-frv/fs/exec.c
--- /warthog/kernels/linux-2.6.10-rc1-mm3/fs/exec.c	2004-11-05 13:15:39.000000000 +0000
+++ linux-2.6.10-rc1-mm3-frv/fs/exec.c	2004-11-05 14:13:03.769507090 +0000
@@ -26,7 +26,6 @@
 #include <linux/slab.h>
 #include <linux/file.h>
 #include <linux/mman.h>
-#include <linux/a.out.h>
 #include <linux/stat.h>
 #include <linux/fcntl.h>
 #include <linux/smp_lock.h>
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/fs/proc/kcore.c linux-2.6.10-rc1-mm3-frv/fs/proc/kcore.c
--- /warthog/kernels/linux-2.6.10-rc1-mm3/fs/proc/kcore.c	2004-11-05 13:15:43.000000000 +0000
+++ linux-2.6.10-rc1-mm3-frv/fs/proc/kcore.c	2004-11-05 14:13:03.000000000 +0000
@@ -13,7 +13,6 @@
 #include <linux/mm.h>
 #include <linux/proc_fs.h>
 #include <linux/user.h>
-#include <linux/a.out.h>
 #include <linux/elf.h>
 #include <linux/elfcore.h>
 #include <linux/vmalloc.h>
