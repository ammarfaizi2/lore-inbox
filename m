Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266998AbTBLKfh>; Wed, 12 Feb 2003 05:35:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267013AbTBLKfh>; Wed, 12 Feb 2003 05:35:37 -0500
Received: from ns.suse.de ([213.95.15.193]:40463 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S266998AbTBLKfg>;
	Wed, 12 Feb 2003 05:35:36 -0500
Date: Wed, 12 Feb 2003 11:45:08 +0100
From: Andi Kleen <ak@suse.de>
To: Jamie Lokier <jamie@shareable.org>
Cc: Andi Kleen <ak@suse.de>, Dave Jones <davej@codemonkey.org.uk>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 350] New: i386 context switch very slow compared to 2.4 due to wrmsr (performance)
Message-ID: <20030212104508.GA1273@wotan.suse.de>
References: <629040000.1045013743@flay> <20030212025902.GA14092@codemonkey.org.uk> <20030212075048.GA9049@wotan.suse.de> <20030212102741.GC10422@bjl1.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030212102741.GC10422@bjl1.jlokier.co.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2003 at 10:27:41AM +0000, Jamie Lokier wrote:
> Andi Kleen wrote:
> > +	/* FIXME should disable preemption here but how can we reenable it? */
> > +
> > +	enable_sysenter();
> > +
> 
> Try this:

[...] I have no real interest in vm86 mode, perhaps one of the people
interested in dosemu etc. could take care of it. I'm very glad it doesn't
exist on my main architecture - x86-64 - given how many hacks it needs to be 
supported.

I would like to have fast context switch on IA32 though so it would be nice 
if someone deeply familiar with sys_vm86 could review my patch.

Avoiding the SYSCALL_CS MSR is independent from the issues Linus raised.

-Andi
