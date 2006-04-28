Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030193AbWD1F3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030193AbWD1F3N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 01:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030231AbWD1F3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 01:29:12 -0400
Received: from cantor.suse.de ([195.135.220.2]:926 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965189AbWD1F2v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 01:28:51 -0400
Date: Fri, 28 Apr 2006 07:28:49 +0200
From: "Andi Kleen" <ak@suse.de>
To: torvalds@osdl.org
Cc: discuss@x86-64.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [4/4] i386: Remove apic= warning
Message-ID: <4451A811.mailO0U11NYKA@suse.de>
User-Agent: nail 10.6 11/15/03
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The apic= option can be used to set the APIC driver too. When
that is done this code would always produce bogus warnings.

Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/i386/kernel/apic.c |    4 ----
 1 files changed, 4 deletions(-)

Index: linux/arch/i386/kernel/apic.c
===================================================================
--- linux.orig/arch/i386/kernel/apic.c
+++ linux/arch/i386/kernel/apic.c
@@ -757,10 +757,6 @@ static int __init apic_set_verbosity(cha
 		apic_verbosity = APIC_DEBUG;
 	else if (strcmp("verbose", str) == 0)
 		apic_verbosity = APIC_VERBOSE;
-	else
-		printk(KERN_WARNING "APIC Verbosity level %s not recognised"
-				" use apic=verbose or apic=debug\n", str);
-
 	return 1;
 }
 
