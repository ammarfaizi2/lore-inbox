Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263019AbUGICWi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263019AbUGICWi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 22:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263413AbUGICWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 22:22:37 -0400
Received: from fw.osdl.org ([65.172.181.6]:36531 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263019AbUGICWf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 22:22:35 -0400
Date: Thu, 8 Jul 2004 19:21:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Shai Fultheim" <shai@scalex86.org>
Cc: linux-kernel@vger.kernel.org, mort@wildopensource.com,
       jes@wildopensource.com
Subject: Re: [PATCH] PER_CPU [1/4] - PER_CPU-cpu_tlbstate
Message-Id: <20040708192127.05c07c65.akpm@osdl.org>
In-Reply-To: <200407090141.i691ffws016223@fire-2.osdl.org>
References: <200407090141.i691ffws016223@fire-2.osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Shai Fultheim" <shai@scalex86.org> wrote:
>
> Please find below one out of collection of patched that move NR_CPU array variables to the per-cpu area.

This is an `allmodconfig' build, gcc-3.4:

distcc[19912] ERROR: compile on vmm failed
arch/i386/mm/fault.c: In function `get_segment_eip':
arch/i386/mm/fault.c:110: error: `per_cpu__cpu_gdt_table' undeclared (first use in this function)
arch/i386/mm/fault.c:110: error: (Each undeclared identifier is reported only once
arch/i386/mm/fault.c:110: error: for each function it appears in.)
arch/i386/mm/fault.c:110: warning: type defaults to `int' in declaration of `type name'
arch/i386/mm/fault.c:110: error: invalid type argument of `unary *'
make[1]: *** [arch/i386/mm/fault.o] Error 1
make[1]: *** Waiting for unfinished jobs....
distcc[20015] ERROR: compile on vmm failed
arch/i386/kernel/ioport.c: In function `sys_ioperm':
arch/i386/kernel/ioport.c:86: error: `per_cpu__init_tss' undeclared (first use in this function)
arch/i386/kernel/ioport.c:86: error: (Each undeclared identifier is reported only once
arch/i386/kernel/ioport.c:86: error: for each function it appears in.)
arch/i386/kernel/ioport.c:86: warning: type defaults to `int' in declaration of `type name'
arch/i386/kernel/ioport.c:86: error: invalid type argument of `unary *'
make[1]: *** [arch/i386/kernel/ioport.o] Error 1
make[1]: *** Waiting for unfinished jobs....
distcc[20004] ERROR: compile on vmm failed
arch/i386/kernel/vm86.c: In function `save_v86_state':
arch/i386/kernel/vm86.c:124: error: `per_cpu__init_tss' undeclared (first use in this function)
arch/i386/kernel/vm86.c:124: error: (Each undeclared identifier is reported only once
arch/i386/kernel/vm86.c:124: error: for each function it appears in.)
arch/i386/kernel/vm86.c:124: warning: type defaults to `int' in declaration of `type name'
arch/i386/kernel/vm86.c:124: error: invalid type argument of `unary *'
arch/i386/kernel/vm86.c: In function `do_sys_vm86':
arch/i386/kernel/vm86.c:306: error: `per_cpu__init_tss' undeclared (first use in this function)
arch/i386/kernel/vm86.c:306: warning: type defaults to `int' in declaration of `type name'
arch/i386/kernel/vm86.c:306: error: invalid type argument of `unary *'
make[1]: *** [arch/i386/kernel/vm86.o] Error 1
make: *** [arch/i386/kernel] Error 2
make: *** Waiting for unfinished jobs....
distcc[19929] ERROR: compile on vmm failed
arch/i386/kernel/process.c: In function `exit_thread':
arch/i386/kernel/process.c:301: error: `per_cpu__init_tss' undeclared (first use in this function)
arch/i386/kernel/process.c:301: error: (Each undeclared identifier is reported only once
arch/i386/kernel/process.c:301: error: for each function it appears in.)
arch/i386/kernel/process.c:301: warning: type defaults to `int' in declaration of `type name'
arch/i386/kernel/process.c:301: error: invalid type argument of `unary *'
arch/i386/kernel/process.c: In function `__switch_to':
arch/i386/kernel/process.c:510: error: `per_cpu__init_tss' undeclared (first use in this function)
arch/i386/kernel/process.c:510: warning: type defaults to `int' in declaration of `type name'
arch/i386/kernel/process.c:510: error: invalid type argument of `unary *'
make: *** [arch/i386/mm] Error 2
