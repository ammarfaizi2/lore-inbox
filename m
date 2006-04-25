Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932168AbWDYJX4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbWDYJX4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 05:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932169AbWDYJX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 05:23:56 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:35210 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932168AbWDYJX4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 05:23:56 -0400
Subject: Re: [PATCH 01/02] Process Events - Header Cleanup
From: Matt Helsley <matthltc@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       Nguyen Anh Quynh <aquynh@gmail.com>
In-Reply-To: <1145956109.28976.133.camel@stark>
References: <1145956109.28976.133.camel@stark>
Content-Type: text/plain
Date: Tue, 25 Apr 2006 02:10:25 -0700
Message-Id: <1145956226.28976.137.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move connector header include to precisely where it's needed.

Remove unused time.h header file as well. This was leftover from previous iterations
of the process events patches.

Compiles on x86. Tested on ppc64.

Please apply to -mm.

Signed-off-by: Matt Helsley <matthltc@us.ibm.com>

--

Index: linux-2.6.17-rc2/drivers/connector/cn_proc.c
===================================================================
--- linux-2.6.17-rc2.orig/drivers/connector/cn_proc.c
+++ linux-2.6.17-rc2/drivers/connector/cn_proc.c
@@ -24,10 +24,11 @@
 
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/ktime.h>
 #include <linux/init.h>
+#include <linux/connector.h>
 #include <asm/atomic.h>
 
 #include <linux/cn_proc.h>
 
 #define CN_PROC_MSG_SIZE (sizeof(struct cn_msg) + sizeof(struct proc_event))
Index: linux-2.6.17-rc2/include/linux/cn_proc.h
===================================================================
--- linux-2.6.17-rc2.orig/include/linux/cn_proc.h
+++ linux-2.6.17-rc2/include/linux/cn_proc.h
@@ -24,12 +24,10 @@
 
 #ifndef CN_PROC_H
 #define CN_PROC_H
 
 #include <linux/types.h>
-#include <linux/time.h>
-#include <linux/connector.h>
 
 /*
  * Userspace sends this enum to register with the kernel that it is listening
  * for events on the connector.
  */


