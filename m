Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269830AbUJGWIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269830AbUJGWIx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 18:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269779AbUJGWHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 18:07:53 -0400
Received: from holomorphy.com ([207.189.100.168]:22482 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269697AbUJGWDz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 18:03:55 -0400
Date: Thu, 7 Oct 2004 15:03:38 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc3-mm3
Message-ID: <20041007220338.GX9106@holomorphy.com>
References: <20041007015139.6f5b833b.akpm@osdl.org> <200410071041.20723.sandersn@btinternet.com> <20041007025007.77ec1a44.akpm@osdl.org> <20041007114040.GV9106@holomorphy.com> <1097184341l.10532l.0l@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097184341l.10532l.0l@werewolf.able.es>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004.10.07, William Lee Irwin III wrote:
>> Here is a more likely correct patch for what that was trying to do,
>> however misguided that may be. Untested, uncompiled, vs. 2.6.9-rc3-mm3
>> without the bad patch:
> ...
>>+static inline void profile_tick(int type, struct pt_regs *regs)
>>+{
>>+	extern cpumask_t prof_cpu_mask;
>>+

On Thu, Oct 07, 2004 at 09:25:41PM +0000, J.A. Magallon wrote:
> This conflicts with kernel/irq/proc.c:
> 	unsigned long prof_cpu_mask = -1;
> Shouldn't this be:
> 	cpumask_t prof_cpu_mask = CPU_MASK_NONE;
> This will show problems when NR_CPUS > sizeof(long)....
> Hope this helps.

What in the goddamned Hell? Who wrote that? What arch?


-- wli
