Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750725AbWC0RMS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbWC0RMS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 12:12:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750720AbWC0RMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 12:12:17 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:30361 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750715AbWC0RMQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 12:12:16 -0500
Subject: [PATCH] x86_64: extra NODES_SHIFT definition
To: ak@suse.de
Cc: linux-kernel@vger.kernel.org, Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Mon, 27 Mar 2006 09:12:07 -0800
Message-Id: <20060327171207.B17D7C47@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The generic linux/numa.h file defines NODES_SHIFT to 0 in case
the architecture did not.

Every architecture which has a NUMA config option defines
NODES_SHIFT in its asm-$ARCH headers, but only if NUMA is
enabled, except for x86_64.

This should make it like all the rest.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 work2-dave/include/asm-x86_64/numnodes.h |    2 --
 1 files changed, 2 deletions(-)

diff -puN include/asm-x86_64/numnodes.h~x86_64-extra-NODES_SHIFT include/asm-x86_64/numnodes.h
--- work2/include/asm-x86_64/numnodes.h~x86_64-extra-NODES_SHIFT	2006-03-23 09:00:31.000000000 -0800
+++ work2-dave/include/asm-x86_64/numnodes.h	2006-03-23 09:00:31.000000000 -0800
@@ -5,8 +5,6 @@
 
 #ifdef CONFIG_NUMA
 #define NODES_SHIFT	6
-#else
-#define NODES_SHIFT	0
 #endif
 
 #endif
_
