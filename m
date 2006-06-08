Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932537AbWFHGnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932537AbWFHGnL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 02:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932538AbWFHGnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 02:43:10 -0400
Received: from www.osadl.org ([213.239.205.134]:39133 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S932537AbWFHGnJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 02:43:09 -0400
Message-ID: <4487C6E5.3070901@tglx.de>
Date: Thu, 08 Jun 2006 08:42:45 +0200
From: Jan Altenberg <tb10alj@tglx.de>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       John Stultz <johnstul@us.ibm.com>, Deepak Saxena <dsaxena@plexity.net>
Subject: [PATCH -rt] Trivial compiler warning fix
References: <20060607211455.GA6132@elte.hu>
In-Reply-To: <20060607211455.GA6132@elte.hu>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this patch fixes a simple compiler warning:

kernel/workqueue.c: in function »set_workqueue_thread_prio«:
kernel/workqueue.c:393: warning: implicit declaration of function `sys_sched_setscheduler'


Signed-off-by: Jan Altenberg <tb10alj@tglx.de>

----------------------

--- linux-2.6.17-rc6-rt1/kernel/workqueue.c.orig	2006-06-08 08:14:00.000000000 +0200
+++ linux-2.6.17-rc6-rt1/kernel/workqueue.c	2006-06-08 08:29:46.000000000 +0200
@@ -28,6 +28,7 @@
 #include <linux/notifier.h>
 #include <linux/kthread.h>
 #include <linux/hardirq.h>
+#include <linux/syscalls.h>
 
 /*
  * The per-CPU workqueue (if single thread, we always use the first

