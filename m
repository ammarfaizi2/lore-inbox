Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965276AbWI1EDz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965276AbWI1EDz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 00:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965277AbWI1EDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 00:03:54 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:32214 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S965276AbWI1EDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 00:03:53 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Tony <tony.luck@intel.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 0/5] Message signaled irq handling cleanups
References: <m18xk5m6fm.fsf@ebiederm.dsl.xmission.com>
	<200609280057.03372.ak@suse.de>
Date: Wed, 27 Sep 2006 22:02:23 -0600
In-Reply-To: <200609280057.03372.ak@suse.de> (Andi Kleen's message of "Thu, 28
	Sep 2006 00:57:03 +0200")
Message-ID: <m18xk4lju8.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> On Wednesday 27 September 2006 21:54, Eric W. Biederman wrote:
>> 
>> The following patch set should be enough to clear up the
>> outstanding issues with genirq on i386 and x86_64.  This actually
>> takes things a step farther and moves all of architecture
>> dependencies I could find into the appropriate architecture.
>> 
>> So hopefully we are finally close enough that other architectures
>> will be able implement msi support, without too much trouble.
>> 
>> msi: Simplify msi sanity checks by adding with generic irq code.
>> msi: Only use a single irq_chip for msi interrupts
>> msi: Refactor and move the msi irq_chip into the arch code.
>> msi: Move the ia64 code into arch/ia64
>> htirq: Tidy up the htirq code
>
>
> The (small) x86-64 parts are fine by me. Thanks.

Note this should allow the hack in -mm that disables stack switch
with 4K stacks on i386 to be dropped.

Eric

