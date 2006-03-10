Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752179AbWCJIsE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752179AbWCJIsE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 03:48:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752177AbWCJIsE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 03:48:04 -0500
Received: from koto.vergenet.net ([210.128.90.7]:22942 "EHLO koto.vergenet.net")
	by vger.kernel.org with ESMTP id S1752088AbWCJIsC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 03:48:02 -0500
Date: Fri, 10 Mar 2006 15:08:34 +0900
From: Horms <horms@verge.net.au>
To: Adrian Bunk <trivial@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] i386: fix whitespace before call to notify_die() in die()
Message-ID: <20060310060831.GA13934@verge.net.au>
References: <20060215082812.GA28711@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060215082812.GA28711@verge.net.au>
X-Cluestick: seven
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Resending as I forgot to CC linux-kernel the first time around]

i386: fix whitespace before call to notify_die() in die()

Signed-Off-By: Horms <horms@verge.net.au>

--- a/arch/i386/kernel/traps.c
+++ b/arch/i386/kernel/traps.c
@@ -365,7 +365,7 @@ void die(const char * str, struct pt_reg
 #endif
 		if (nl)
 			printk("\n");
-	notify_die(DIE_OOPS, (char *)str, regs, err, 255, SIGSEGV);
+		notify_die(DIE_OOPS, (char *)str, regs, err, 255, SIGSEGV);
 		show_registers(regs);
   	} else
 		printk(KERN_EMERG "Recursive die() failure, output suppressed\n");

-- 
Horms
