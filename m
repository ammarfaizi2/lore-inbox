Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262034AbTJMWNi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 18:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262037AbTJMWNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 18:13:38 -0400
Received: from imladris.surriel.com ([66.92.77.98]:39632 "EHLO
	imladris.surriel.com") by vger.kernel.org with ESMTP
	id S262034AbTJMWNh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 18:13:37 -0400
Date: Mon, 13 Oct 2003 18:13:07 -0400 (EDT)
From: Rik van Riel <riel@surriel.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: root@ftp.linux.org.uk, Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH][TRIVIAL] include hardirq.h into smplock.h for alpha
Message-ID: <Pine.LNX.4.55L.0310131812050.27244@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

According to Bryce, we need this one too.

diff -urNp linux-5110/include/asm-alpha/smplock.h linux-10010/include/asm-alpha/smplock.h
--- linux-5110/include/asm-alpha/smplock.h	2000-03-23 21:50:09.000000000 +0100
+++ linux-10010/include/asm-alpha/smplock.h
@@ -7,7 +7,7 @@
 #include <linux/sched.h>
 #include <linux/interrupt.h>
 #include <linux/spinlock.h>
-
+#include <asm/hardirq.h>
 extern spinlock_t kernel_flag;

 #define kernel_locked()		spin_is_locked(&kernel_flag)
