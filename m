Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266036AbTGDRcD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 13:32:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266077AbTGDRcD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 13:32:03 -0400
Received: from [213.39.233.138] ([213.39.233.138]:60584 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S266036AbTGDRcA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 13:32:00 -0400
Date: Fri, 4 Jul 2003 19:45:58 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
       linuxppc-dev@lists.linuxppc.org, linuxppc64-dev@lists.linuxppc.org
Subject: [PATCH 2.5.73] Signal stack fixes #1 introduce PF_SS_ACTIVE
Message-ID: <20030704174558.GC22152@wohnheim.fh-wedel.de>
References: <20030703202410.GA32008@wohnheim.fh-wedel.de> <20030704174339.GB22152@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030704174339.GB22152@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus!

This is the generic part of the signal stack fixes, it simply
introduces a new PF-flag that indicates whether we are using the
signal stack right now or not.

Please apply.

Jörn

-- 
Data expands to fill the space available for storage.
-- Parkinson's Law

--- linux-2.5.73/include/linux/sched.h~ss_generic	2003-07-04 18:57:01.000000000 +0200
+++ linux-2.5.73/include/linux/sched.h	2003-07-04 18:59:03.000000000 +0200
@@ -480,6 +480,7 @@
 #define PF_FSTRANS	0x00020000	/* inside a filesystem transaction */
 #define PF_KSWAPD	0x00040000	/* I am kswapd */
 #define PF_SWAPOFF	0x00080000	/* I am in swapoff */
+#define PF_SS_ACTIVE	0x00100000	/* Executing on signal stack now */
 #define PF_LESS_THROTTLE 0x01000000	/* Throttle me less: I clena memory */
 
 #ifdef CONFIG_SMP
