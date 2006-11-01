Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946510AbWKAFnF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946510AbWKAFnF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 00:43:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946538AbWKAFnB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 00:43:01 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:58331 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1946532AbWKAFmq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 00:42:46 -0500
Message-Id: <20061101054252.255932000@sous-sol.org>
References: <20061101053340.305569000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 31 Oct 2006 21:34:22 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Ulrich Drepper <drepper@redhat.com>,
       Jeff Dike <jdike@addtoit.com>,
       Paolo Blaisorblade Giarrusso <blaisorblade@yahoo.it>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 42/61] uml: make Uml compile on FC6 kernel headers
Content-Disposition: inline; filename=uml-make-uml-compile-on-fc6-kernel-headers.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
 arch/um/include/kern_util.h    |    1 -
 arch/um/sys-x86_64/stub_segv.c |    1 -
 2 files changed, 2 deletions(-)

--- linux-2.6.18.1.orig/arch/um/include/kern_util.h
+++ linux-2.6.18.1/arch/um/include/kern_util.h
@@ -6,7 +6,6 @@
 #ifndef __KERN_UTIL_H__
 #define __KERN_UTIL_H__
 
-#include "linux/threads.h"
 #include "sysdep/ptrace.h"
 #include "sysdep/faultinfo.h"
 
--- linux-2.6.18.1.orig/arch/um/sys-x86_64/stub_segv.c
+++ linux-2.6.18.1/arch/um/sys-x86_64/stub_segv.c
@@ -5,7 +5,6 @@
 
 #include <stddef.h>
 #include <signal.h>
-#include <linux/compiler.h>
 #include <asm/unistd.h>
 #include "uml-config.h"
 #include "sysdep/sigcontext.h"

--
