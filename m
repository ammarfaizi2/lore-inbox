Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262006AbVADT4m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262006AbVADT4m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 14:56:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262127AbVADTxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 14:53:32 -0500
Received: from mx1.redhat.com ([66.187.233.31]:45698 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261854AbVADTvd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 14:51:33 -0500
From: David Howells <dhowells@redhat.com>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Don't include linux/a.out.h unnecessarily
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Tue, 04 Jan 2005 19:51:23 +0000
Message-ID: <17812.1104868283@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch prevents unnecessary inclusion of linux/a.out.h since not
all archs support AOUT and thus may not have asm/a.out.h.

There was a patch included for this previously, but it seems to have been
dropped.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat aouth-2610mm1.diff 
 exec.c       |    1 -
 proc/kcore.c |    1 -
 2 files changed, 2 deletions(-)

diff -uNrp /warthog/kernels/linux-2.6.10-mm1/fs/exec.c linux-2.6.10-mm1-frv/fs/exec.c
--- /warthog/kernels/linux-2.6.10-mm1/fs/exec.c	2005-01-04 11:15:20.000000000 +0000
+++ linux-2.6.10-mm1-frv/fs/exec.c	2005-01-04 13:23:24.000000000 +0000
@@ -26,7 +26,6 @@
 #include <linux/slab.h>
 #include <linux/file.h>
 #include <linux/mman.h>
-#include <linux/a.out.h>
 #include <linux/stat.h>
 #include <linux/fcntl.h>
 #include <linux/smp_lock.h>
diff -uNrp /warthog/kernels/linux-2.6.10-mm1/fs/proc/kcore.c linux-2.6.10-mm1-frv/fs/proc/kcore.c
--- /warthog/kernels/linux-2.6.10-mm1/fs/proc/kcore.c	2005-01-04 11:15:21.000000000 +0000
+++ linux-2.6.10-mm1-frv/fs/proc/kcore.c	2005-01-04 16:36:31.000000000 +0000
@@ -13,7 +13,6 @@
 #include <linux/mm.h>
 #include <linux/proc_fs.h>
 #include <linux/user.h>
-#include <linux/a.out.h>
 #include <linux/elf.h>
 #include <linux/elfcore.h>
 #include <linux/vmalloc.h>
