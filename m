Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751458AbVJRHpV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458AbVJRHpV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 03:45:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751459AbVJRHpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 03:45:21 -0400
Received: from ns2.suse.de ([195.135.220.15]:25805 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751458AbVJRHpU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 03:45:20 -0400
Date: Tue, 18 Oct 2005 09:45:11 +0200
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] disable PREEMPT_BKL per default
Message-ID: <20051018074511.GA13182@suse.de>
References: <20051016154108.25735ee3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20051016154108.25735ee3.akpm@osdl.org>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Do not enable this per default during make oldconfig.
'default $foo' should not be abused like that.

Signed-off-by: Olaf Hering <olh@suse.de>

Index: linux-2.6.14-rc4-mm1/kernel/Kconfig.preempt
===================================================================
--- linux-2.6.14-rc4-mm1.orig/kernel/Kconfig.preempt	2005-10-11 01:19:19.000000000 +0000
+++ linux-2.6.14-rc4-mm1/kernel/Kconfig.preempt	2005-10-18 07:41:40.702542966 +0000
@@ -55,7 +55,6 @@
 config PREEMPT_BKL
 	bool "Preempt The Big Kernel Lock"
 	depends on SMP || PREEMPT
-	default y
 	help
 	  This option reduces the latency of the kernel by making the
 	  big kernel lock preemptible.
-- 
short story of a lazy sysadmin:
 alias appserv=wotan
