Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269218AbUIYDaA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269218AbUIYDaA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 23:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269213AbUIYD2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 23:28:32 -0400
Received: from holomorphy.com ([207.189.100.168]:56036 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269211AbUIYD1t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 23:27:49 -0400
Date: Fri, 24 Sep 2004 20:27:46 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [sched.h 7/8] remove rbtree.h inclusion from sched.h
Message-ID: <20040925032746.GS9106@holomorphy.com>
References: <20040925024513.GL9106@holomorphy.com> <20040925024917.GM9106@holomorphy.com> <20040925025304.GN9106@holomorphy.com> <20040925030802.GO9106@holomorphy.com> <20040925031912.GP9106@holomorphy.com> <20040925032419.GQ9106@holomorphy.com> <20040925032616.GR9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040925032616.GR9106@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2004 at 08:26:16PM -0700, William Lee Irwin III wrote:
> This patch moves the aio inclusion from sched.h to mm.h, while leaving
> workqueue.h directly included by sched.h; a large sweep is required to
> clean up drivers including workqueue.h indirectly via sched.h

This patch removes the inclusion of rbtree.h in sched.h

Index: mm3-2.6.9-rc2/include/linux/sched.h
===================================================================
--- mm3-2.6.9-rc2.orig/include/linux/sched.h	2004-09-24 19:16:49.428426784 -0700
+++ mm3-2.6.9-rc2/include/linux/sched.h	2004-09-24 19:23:12.432201360 -0700
@@ -10,7 +10,6 @@
 #include <linux/types.h>
 #include <linux/timex.h>
 #include <linux/jiffies.h>
-#include <linux/rbtree.h>
 #include <linux/thread_info.h>
 #include <linux/cpumask.h>
 #include <linux/nodemask.h>
