Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264674AbTD0OZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 10:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264669AbTD0OZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 10:25:57 -0400
Received: from zero.aec.at ([193.170.194.10]:7950 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S264674AbTD0OZ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 10:25:56 -0400
Date: Sun, 27 Apr 2003 16:38:01 +0200
From: Andi Kleen <ak@muc.de>
To: Andrew Morton <akpm@digeo.com>
Cc: Andi Kleen <ak@muc.de>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] An generic subarchitecture for 2.5.68
Message-ID: <20030427143801.GA2000@averell>
References: <20030427012238.GA13997@averell> <20030426231147.69efb07d.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030426231147.69efb07d.akpm@digeo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 27, 2003 at 08:11:47AM +0200, Andrew Morton wrote:
> Andi Kleen <ak@muc.de> wrote:
> >
> > 
> > This patch adds an generic x86 subarchitecture.
> 
> It causes a large number of compilation errors with the config at
> http://www.zip.com.au/~akpm/linux/patches/stuff/config
> 
> Some Kconfig help would be nice...

This incremental patch fixes it by just disallowing SMP in the dependencies.

-Andi

--- linux-subarch/arch/i386/Kconfig-o	2003-04-27 16:32:53.000000000 +0200
+++ linux-subarch/arch/i386/Kconfig	2003-04-27 16:26:24.000000000 +0200
@@ -66,6 +66,7 @@
 
 config X86_SUMMIT
 	bool "Summit/EXA (IBM x440)"
+	depends on SMP
 	help
 	  This option is needed for IBM systems that use the Summit/EXA chipset.
 	  In particular, it is needed for the x440.
@@ -74,6 +75,7 @@
 
 config X86_BIGSMP
 	bool "Support for other sub-arch SMP systems with more than 8 CPUs"
+	depends on SMP
 	help
 	  This option is needed for the systems that have more than 8 CPUs
 	  and if the system is not of any sub-arch type above.
@@ -93,6 +95,7 @@
 
 config X86_GENERICARCH
        bool "Generic architecture (Summit, bigsmp, default)"
+       depends on SMP
        help
           This option compiles in the Summit, bigsmp, default subarchitectures.
 	  It is intended for a generic binary kernel.

