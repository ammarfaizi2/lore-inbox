Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030233AbWGFQuS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030233AbWGFQuS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 12:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030271AbWGFQuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 12:50:18 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:18648 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030233AbWGFQuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 12:50:16 -0400
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
	<20060705233123.dcb0a10b.akpm@osdl.org>
Date: Thu, 06 Jul 2006 10:49:25 -0600
In-Reply-To: <20060705233123.dcb0a10b.akpm@osdl.org> (Andrew Morton's message
	of "Wed, 5 Jul 2006 23:31:23 -0700")
Message-ID: <m1r70yznje.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> Maybe not.  If we do this, we lose the pretty CPUn columns in
> /proc/interrupts.  That /proc/interrupts display requires that we maintain
> NR_CPUS*NR_IRQS counters.
>
> Given that a large NR_IRQs space will be sparsely populated, we should
> dynamically allocate the NR_CPUS storage for each active IRQ, as you say.
>
> That involves putting it into the irq_desc (as good a place as any).  And a
> rather large number of trivial edits.  I guess we do this only for genirq?

Actually I rechecked.  There is one alpha box that defines
NR_IRQS to be 32K.  Which should hit this same problem if anyone
ever compiles it.

So this may actually seems to be an issue independent of genirq.

Eric

