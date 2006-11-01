Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946537AbWKAFog@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946537AbWKAFog (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 00:44:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946524AbWKAFnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 00:43:55 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:64987 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1946539AbWKAFnD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 00:43:03 -0500
Message-Id: <20061101054307.392790000@sous-sol.org>
References: <20061101053340.305569000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 31 Oct 2006 21:34:23 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk,
       "Paolo Blaisorblade Giarrusso" <blaisorblade@yahoo.it>,
       Jeff Dike <jdike@addtoit.com>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 43/61] uml: remove warnings added by previous -stable patch
Content-Disposition: inline; filename=uml-remove-warnings-added-by-previous-stable-patch.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Add needed includes for syscall() function, also to remove warnings spit out by
GCC; they were added by previous -stable patch, and at least on my system
(Ubuntu x86-64) these warnings do show up.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
 arch/um/os-Linux/sys-i386/tls.c |    2 ++
 arch/um/os-Linux/tls.c          |    2 ++
 2 files changed, 4 insertions(+)

--- linux-2.6.18.1.orig/arch/um/os-Linux/sys-i386/tls.c
+++ linux-2.6.18.1/arch/um/os-Linux/sys-i386/tls.c
@@ -1,4 +1,6 @@
 #include <errno.h>
+#include <sys/syscall.h>
+#include <unistd.h>
 #include <linux/unistd.h>
 #include "sysdep/tls.h"
 #include "user_util.h"
--- linux-2.6.18.1.orig/arch/um/os-Linux/tls.c
+++ linux-2.6.18.1/arch/um/os-Linux/tls.c
@@ -1,6 +1,8 @@
 #include <errno.h>
 #include <sys/ptrace.h>
+#include <sys/syscall.h>
 #include <asm/ldt.h>
+#include <unistd.h>
 #include "sysdep/tls.h"
 #include "uml-config.h"
 

--
