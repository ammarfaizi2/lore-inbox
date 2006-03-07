Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750724AbWCGOT2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbWCGOT2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 09:19:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbWCGOT2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 09:19:28 -0500
Received: from quark.didntduck.org ([69.55.226.66]:13243 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id S1750724AbWCGOT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 09:19:27 -0500
Message-ID: <440D9682.7070601@didntduck.org>
Date: Tue, 07 Mar 2006 09:19:46 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86-64: Use cpumask bitops for cpu_vm_mask
References: <440D8C9E.2080200@didntduck.org> <200603070718.24748.ak@suse.de>
In-Reply-To: <200603070718.24748.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Tuesday 07 March 2006 14:37, Brian Gerst wrote:
> 
>>cpu_vm_mask is of type cpumask_t, so use the proper bitops.
> 
> 
> Doesn't apply.
> 
> patching file arch/x86_64/kernel/smp.c
> patching file include/asm-x86_64/mmu_context.h
> Hunk #1 FAILED at 34.
> Hunk #2 FAILED at 50.
> 2 out of 2 hunks FAILED -- rejects in file include/asm-x86_64/mmu_context.h
> 
> -Andi
> 
> 

I diffed against the vanilla kernel.  It looks like -mm has the fix to 
mmu_context.h already (x86_64-mm-bitops-cleanups.patch), but the patch 
to smp.c is still valid.

--
				Brian Gerst
