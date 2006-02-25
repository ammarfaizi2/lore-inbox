Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932457AbWBYARH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932457AbWBYARH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 19:17:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932643AbWBYARH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 19:17:07 -0500
Received: from pat.qlogic.com ([198.70.193.2]:44601 "EHLO avexch02.qlogic.com")
	by vger.kernel.org with ESMTP id S932457AbWBYARF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 19:17:05 -0500
Date: Fri, 24 Feb 2006 16:17:01 -0800
From: Andrew Vasquez <andrew.vasquez@qlogic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] Topology c fix
Message-ID: <20060225001701.GB6022@andrew-vasquezs-powerbook-g4-15.local>
References: <1137631411.4757.218.camel@serpentine.pathscale.com> <m1y81cpqt8.fsf@ebiederm.dsl.xmission.com> <20060119.003930.117351070.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602242019.k1OKJ9ZW017291@zach-dev.vmware.com>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 25 Feb 2006 00:17:02.0955 (UTC) FILETIME=[CD5C0BB0:01C639A0]
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Commit:

	[PATCH] Fix topology.c location
	9c869edac591977314323a4eaad5f7633fca684f 

breaks compilation on my x86_64 box.

Small patch below corrects references.

---

diff --git a/arch/x86_64/kernel/Makefile b/arch/x86_64/kernel/Makefile
index 72fe60c..a098a11 100644
--- a/arch/x86_64/kernel/Makefile
+++ b/arch/x86_64/kernel/Makefile
@@ -43,7 +43,7 @@ CFLAGS_vsyscall.o		:= $(PROFILING) -g0
 
 bootflag-y			+= ../../i386/kernel/bootflag.o
 cpuid-$(subst m,y,$(CONFIG_X86_CPUID))  += ../../i386/kernel/cpuid.o
-topology-y                     += ../../i386/mach-default/topology.o
+topology-y                     += ../../i386/kernel/topology.o
 microcode-$(subst m,y,$(CONFIG_MICROCODE))  += ../../i386/kernel/microcode.o
 intel_cacheinfo-y		+= ../../i386/kernel/cpu/intel_cacheinfo.o
 quirks-y			+= ../../i386/kernel/quirks.o
