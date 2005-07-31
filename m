Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261641AbVGaEr3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261641AbVGaEr3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 00:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263041AbVGaErX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 00:47:23 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:12244 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261641AbVGaErQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 00:47:16 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.13-rc4-V0.7.52-01
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-kernel@vger.kernel.org
In-Reply-To: <20050730205259.GA24542@elte.hu>
References: <20050730160345.GA3584@elte.hu> <1122756435.29704.2.camel@twins>
	 <20050730205259.GA24542@elte.hu>
Content-Type: text/plain
Date: Sun, 31 Jul 2005 00:47:13 -0400
Message-Id: <1122785233.10275.3.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-07-30 at 22:52 +0200, Ingo Molnar wrote:
> * Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
> 
> > Hi Ingo,
> > 
> > -02 needs the attached patch to compile with my config.
> 
> thanks, i've released -03 with your fixes.
> 

Does not compile with highmem enabled:

  CC      arch/i386/mm/highmem.o
arch/i386/mm/highmem.c:102: error: syntax error before '(' token
arch/i386/mm/highmem.c:107: error: syntax error before numeric constant
arch/i386/mm/highmem.c:107: warning: type defaults to 'int' in declaration of 'add_preempt_count'
arch/i386/mm/highmem.c:107: warning: function declaration isn't a prototype
arch/i386/mm/highmem.c:107: error: conflicting types for 'add_preempt_count'
include/linux/preempt.h:14: error: previous declaration of 'add_preempt_count' was here
arch/i386/mm/highmem.c:107: warning: data definition has no type or storage class
arch/i386/mm/highmem.c:109: warning: type defaults to 'int' in declaration of 'idx'
arch/i386/mm/highmem.c:109: error: 'type' undeclared here (not in a function)
arch/i386/mm/highmem.c:109: warning: data definition has no type or storage class
arch/i386/mm/highmem.c:110: warning: type defaults to 'int' in declaration of 'vaddr'
arch/i386/mm/highmem.c:110: error: conflicting types for 'vaddr'
arch/i386/mm/highmem.c:105: error: previous declaration of 'vaddr' was here
arch/i386/mm/highmem.c:110: error: initializer element is not constant
arch/i386/mm/highmem.c:110: warning: data definition has no type or storage class
arch/i386/mm/highmem.c:111: error: syntax error before '-' token
arch/i386/mm/highmem.c:132: error: 'kmap_atomic' undeclared here (not in a function)
arch/i386/mm/highmem.c:133: error: 'kunmap_atomic' undeclared here (not in a function)
arch/i386/mm/highmem.c:134: error: 'kmap_atomic_to_page' undeclared here (not in a function)
make[1]: *** [arch/i386/mm/highmem.o] Error 1
make: *** [arch/i386/mm] Error 2

Lee

