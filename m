Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266407AbUAIBJq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 20:09:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266408AbUAIBJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 20:09:46 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:6042 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S266407AbUAIBJo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 20:09:44 -0500
Date: Thu, 8 Jan 2004 17:11:08 -0800
From: Paul Jackson <pj@sgi.com>
To: Paul Mackerras <paulus@samba.org>
Cc: joe.korty@ccur.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: seperator error in __mask_snprintf_len
Message-Id: <20040108171108.2c02a387.pj@sgi.com>
In-Reply-To: <16381.61618.275775.487768@cargo.ozlabs.ibm.com>
References: <20040107165607.GA11483@rudolph.ccur.com>
	<20040107113207.3aab64f5.akpm@osdl.org>
	<20040108051111.4ae36b58.pj@sgi.com>
	<16381.57040.576175.977969@cargo.ozlabs.ibm.com>
	<20040108225929.GA24089@tsunami.ccur.com>
	<16381.61618.275775.487768@cargo.ozlabs.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One side note I should warn of - my breakage (if such it be) was not
consistent.

To quote my original patch to Andrew:

> Date: Fri, 28 Nov 2003 12:54:28 -0800
> Subject: [PATCH] new /proc/irq cpumask format; consolidate cpumask display and input code
> 
> ...
> 
> There are two exceptions to the consolidation - the alpha and
> sparc64 arch's manipulate bare unsigned longs, not cpumask_t's,
> on input (write syscall), and do stuff that was more funky than
> I could make sense of.  So the input side of these two arch's
> was left as-is.  I'd welcome someone with access to either of
> these systems to provide additional patches.

This suggests that while I may well have broken the output side (what
the kernel displays when you read cpumasks in /proc/irq/prof_cpu_mask or
/proc/irq/<pid>/smp_affinity), it is less likely that I broke the input
side (the affect of writing a mask to these files).

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
