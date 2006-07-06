Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030211AbWGFGlT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030211AbWGFGlT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 02:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030224AbWGFGlT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 02:41:19 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:40877 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030211AbWGFGlS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 02:41:18 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Cc: kmannth@gmail.com, linux-kernel@vger.kernel.org, mingo@elte.hu,
       tglx@linutronix.de, Natalie.Protasevich@UNISYS.com
Subject: Re: 2.6.17-mm6
References: <20060703030355.420c7155.akpm@osdl.org>
	<a762e240607051447x3c3c6e15k9cdb38804cf13f35@mail.gmail.com>
	<20060705155037.7228aa48.akpm@osdl.org>
	<a762e240607051628n42bf3b79v34178c7251ad7d92@mail.gmail.com>
	<20060705164457.60e6dbc2.akpm@osdl.org>
	<20060705164820.379a69ba.akpm@osdl.org>
	<a762e240607051705h33952e5elf6bd09c1ccea8ab4@mail.gmail.com>
	<20060705172545.815872b6.akpm@osdl.org>
	<m1u05v2st3.fsf@ebiederm.dsl.xmission.com>
	<20060705225905.53e61ca0.akpm@osdl.org>
Date: Thu, 06 Jul 2006 00:40:31 -0600
In-Reply-To: <20060705225905.53e61ca0.akpm@osdl.org> (Andrew Morton's message
	of "Wed, 5 Jul 2006 22:59:05 -0700")
Message-ID: <m1fyhf2q3k.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> On Wed, 05 Jul 2006 23:42:00 -0600
> ebiederm@xmission.com (Eric W. Biederman) wrote:
>
>> So I suspect that we need to de-percpuify kernel_stat.irqs.
>
> I think so.  We do:
>
> 	struct irq_desc *desc = irq_desc + irq;
>
> 	kstat_this_cpu.irqs[irq]++;
>
> followed immediately by
>
> 	spin_lock(&desc->lock);
>
> false optimisation, or what?


As an optimization  I can't think of a reason.

It is kind of interesting to report that information by cpu.
in /proc/interrupts  (see show_interrupts).

But except for understanding system behavior I can't think of a reason
for reporting that information.

It was useful information to have when debugging the irq migration code.

Eric

