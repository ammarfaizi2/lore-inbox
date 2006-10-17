Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750912AbWJQTsp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750912AbWJQTsp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 15:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbWJQTsp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 15:48:45 -0400
Received: from [151.97.230.90] ([151.97.230.90]:20950 "EHLO memento.home.lan")
	by vger.kernel.org with ESMTP id S1750912AbWJQTso (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 15:48:44 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
To: stable@kernel.org
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net,
       Ulrich Drepper <drepper@redhat.com>, Andrew Morton <akpm@osdl.org>
Subject: uml: make Uml compile on FC6 kernel headers
Date: Tue, 17 Oct 2006 17:01:13 +0200
Message-Id: <11610972733507-git-send-email-blaisorblade@yahoo.it>
X-Mailer: git-send-email 1.4.2.3.g99b7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ulrich Drepper <drepper@redhat.com>

I need this patch to get a UML kernel to compile.  This is with the kernel
headers in FC6 which are automatically generated from the kernel tree. 
Some headers are missing but those files don't need them.  At least it
appears so since the resulting kernel works fine.

Tested on x86-64.

Signed-off-by: Ulrich Drepper <drepper@redhat.com>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/um/include/kern_util.h    |    1 -
 arch/um/sys-x86_64/stub_segv.c |    1 -
 2 files changed, 2 deletions(-)

diff -puN arch/um/include/kern_util.h~make-uml-copmile arch/um/include/kern_util.h
--- a/arch/um/include/kern_util.h~make-uml-copmile
+++ a/arch/um/include/kern_util.h
@@ -6,7 +6,6 @@
 #ifndef __KERN_UTIL_H__
 #define __KERN_UTIL_H__
 
-#include "linux/threads.h"
 #include "sysdep/ptrace.h"
 #include "sysdep/faultinfo.h"
 
diff -puN arch/um/sys-x86_64/stub_segv.c~make-uml-copmile arch/um/sys-x86_64/stub_segv.c
--- a/arch/um/sys-x86_64/stub_segv.c~make-uml-copmile
+++ a/arch/um/sys-x86_64/stub_segv.c
@@ -5,7 +5,6 @@
 
 #include <stddef.h>
 #include <signal.h>
-#include <linux/compiler.h>
 #include <asm/unistd.h>
 #include "uml-config.h"
 #include "sysdep/sigcontext.h"
_

Patches currently in -mm which might be from drepper@redhat.com are

make-uml-copmile.patch
honour-mnt_noexec-for-access.patch
kevent-core-files.patch
kevent-core-files-fix.patch
kevent-core-files-s390-hack.patch
kevent-poll-select-notifications.patch
kevent-socket-notifications.patch
kevent-socket-notifications-fix-2.patch
kevent-socket-notifications-fix-4.patch
kevent-timer-notifications.patch


