Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbTFOADl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 20:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261428AbTFOADl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 20:03:41 -0400
Received: from [66.212.224.118] ([66.212.224.118]:36882 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S261422AbTFOADl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 20:03:41 -0400
Date: Sat, 14 Jun 2003 20:06:13 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Gerhard Mack <gmack@innerfire.net>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][2.5] fix link due to register_cpu_notifier & flow_cache_init
In-Reply-To: <Pine.LNX.4.44.0306141954130.4066-100000@innerfire.net>
Message-ID: <Pine.LNX.4.50.0306141957180.31716-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.44.0306141954130.4066-100000@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Jun 2003, Gerhard Mack wrote:

> Got this on a fresh tree:
> 
> net/built-in.o(.init.text+0x209): In function `flow_cache_init':
> : undefined reference to `register_cpu_notifier'
> make: *** [.tmp_vmlinux1] Error 1

Index: linux-2.5-pgcl/net/core/flow.c
===================================================================
RCS file: /home/cvs/linux-2.5/net/core/flow.c,v
retrieving revision 1.7
diff -u -p -B -r1.7 flow.c
--- linux-2.5-pgcl/net/core/flow.c	21 Jun 2003 16:16:59 -0000	1.7
+++ linux-2.5-pgcl/net/core/flow.c	14 Jun 2003 23:05:49 -0000
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
+#include <linux/cpu.h>
 #include <linux/smp.h>
 #include <linux/completion.h>
 #include <linux/percpu.h>
-- 
function.linuxpower.ca
