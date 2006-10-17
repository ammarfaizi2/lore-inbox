Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751249AbWJQTtK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbWJQTtK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 15:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbWJQTss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 15:48:48 -0400
Received: from [151.97.230.90] ([151.97.230.90]:21206 "EHLO memento.home.lan")
	by vger.kernel.org with ESMTP id S1751099AbWJQTso (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 15:48:44 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
To: stable@kernel.org
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net,
       "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: uml: remove warnings added by previous -stable patch
Date: Tue, 17 Oct 2006 17:05:31 +0200
Message-Id: <11610975311236-git-send-email-blaisorblade@yahoo.it>
X-Mailer: git-send-email 1.4.2.3.g99b7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Add needed includes for syscall() function, also to remove warnings spit out by
GCC; they were added by previous -stable patch, and at least on my system
(Ubuntu x86-64) these warnings do show up.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Index: linux-2.6.18/arch/um/os-Linux/sys-i386/tls.c
===================================================================
--- linux-2.6.18.orig/arch/um/os-Linux/sys-i386/tls.c
+++ linux-2.6.18/arch/um/os-Linux/sys-i386/tls.c
@@ -1,4 +1,6 @@
 #include <errno.h>
+#include <sys/syscall.h>
+#include <unistd.h>
 #include <linux/unistd.h>
 #include "sysdep/tls.h"
 #include "user_util.h"
Index: linux-2.6.18/arch/um/os-Linux/tls.c
===================================================================
--- linux-2.6.18.orig/arch/um/os-Linux/tls.c
+++ linux-2.6.18/arch/um/os-Linux/tls.c
@@ -1,6 +1,8 @@
 #include <errno.h>
 #include <sys/ptrace.h>
+#include <sys/syscall.h>
 #include <asm/ldt.h>
+#include <unistd.h>
 #include "sysdep/tls.h"
 #include "uml-config.h"
 
