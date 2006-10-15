Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161079AbWJOTD4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161079AbWJOTD4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 15:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161082AbWJOTD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 15:03:56 -0400
Received: from mx1.redhat.com ([66.187.233.31]:48058 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161079AbWJOTD4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 15:03:56 -0400
Date: Sun, 15 Oct 2006 15:03:48 -0400
From: Ulrich Drepper <drepper@redhat.com>
Message-Id: <200610151903.k9FJ3mHG016757@devserv.devel.redhat.com>
To: akpm@osdl.org, jdike@karaya.com, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: [PATCH] make UML copmile
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I need this patch to get a UML kernel to compile.  This is with the kernel
headers in FC6 which are automatically generated from the kernel tree.
Some headers are missing but those files don't need them.  At least it
appears so since the resuling kernel works fine.

Tested on x86-64.


Signed-off-by: Ulrich Drepper <drepper@redhat.com>

diff --git a/arch/um/include/kern_util.h b/arch/um/include/kern_util.h
index 59cfa9e..cec9fcc 100644
--- a/arch/um/include/kern_util.h
+++ b/arch/um/include/kern_util.h
@@ -6,7 +6,6 @@
 #ifndef __KERN_UTIL_H__
 #define __KERN_UTIL_H__
 
-#include "linux/threads.h"
 #include "sysdep/ptrace.h"
 #include "sysdep/faultinfo.h"
 
diff --git a/arch/um/sys-x86_64/stub_segv.c b/arch/um/sys-x86_64/stub_segv.c
index 1c96702..652fa34 100644
--- a/arch/um/sys-x86_64/stub_segv.c
+++ b/arch/um/sys-x86_64/stub_segv.c
@@ -5,7 +5,6 @@
 
 #include <stddef.h>
 #include <signal.h>
-#include <linux/compiler.h>
 #include <asm/unistd.h>
 #include "uml-config.h"
 #include "sysdep/sigcontext.h"
