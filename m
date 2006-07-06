Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964957AbWGFHbZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964957AbWGFHbZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 03:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964949AbWGFHbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 03:31:25 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:41409 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964957AbWGFHbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 03:31:24 -0400
Subject: Re: 2.6.17-mm6
From: Arjan van de Ven <arjan@infradead.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, kmannth@gmail.com,
       linux-kernel@vger.kernel.org, mingo@elte.hu, tglx@linutronix.de,
       Natalie.Protasevich@UNISYS.com
In-Reply-To: <m17j2r2od0.fsf@ebiederm.dsl.xmission.com>
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
	 <m17j2r2od0.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Thu, 06 Jul 2006 09:31:15 +0200
Message-Id: <1152171075.3084.12.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-06 at 01:18 -0600, Eric W. Biederman wrote:

Hi,


> Andrew Morton <akpm@osdl.org> writes:
> 
> > On Wed, 5 Jul 2006 22:59:05 -0700
> > Andrew Morton <akpm@osdl.org> wrote:
> >
> >> On Wed, 05 Jul 2006 23:42:00 -0600
> >> ebiederm@xmission.com (Eric W. Biederman) wrote:
> >> 
> >> > So I suspect that we need to de-percpuify kernel_stat.irqs.
> >> 
> >> I think so.
> >
> > Maybe not.  If we do this, we lose the pretty CPUn columns in
> > /proc/interrupts.  That /proc/interrupts display requires that we maintain
> > NR_CPUS*NR_IRQS counters.
> 
> Yes.  Although at least part of that display is per architecture
> so we may be able to get away with a little more.

irqbalance uses the per column data for it's work.. please don't kill
the information or format.

Also if you have 1 number per irq, you keep bouncing that cacheline
around *all the time* if your irq policy is set to rotating (as many
chipsets do by default unless the OS overrides it)

Greetings,
    Arjan van de Ven

