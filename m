Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281017AbRLDQhh>; Tue, 4 Dec 2001 11:37:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280961AbRLDQgH>; Tue, 4 Dec 2001 11:36:07 -0500
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:48039 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S281017AbRLDQf6>; Tue, 4 Dec 2001 11:35:58 -0500
Date: Tue, 4 Dec 2001 11:32:43 -0500
From: Arjan van de Ven <arjanv@redhat.com>
To: David Mosberger <davidm@hpl.hp.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Arjan van de Ven <arjanv@redhat.com>,
        linux-kernel@vger.kernel.org, linux-ia64@linuxia64.org,
        marcelo@conectiva.com.br, davem@redhat.com
Subject: Re: [Linux-ia64] patch to no longer use ia64's software mmu
Message-ID: <20011204113243.B5075@devserv.devel.redhat.com>
In-Reply-To: <15371.62205.231945.798891@napali.hpl.hp.com> <E16BC09-0001Ql-00@the-village.bc.nu> <15372.63827.716885.948119@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15372.63827.716885.948119@napali.hpl.hp.com>; from davidm@hpl.hp.com on Tue, Dec 04, 2001 at 08:26:59AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2001 at 08:26:59AM -0800, David Mosberger wrote:
> >>>>> On Tue, 4 Dec 2001 09:36:33 +0000 (GMT), Alan Cox <alan@lxorguk.ukuu.org.uk> said:
> 
>   >> Another concern I have is that, fundamentally, I dislike the idea
>   >> of penalizing all IA-64 platforms due to one chipset that is,
>   >> shall we say, "lacking" (i.e., doesn't have an I/O TLB).
> 
>   Alan> Allow me to introduce to you the concept of CONFIG_ options 8)
>   Alan> It makes a lot of sense to have a generic IA64 kernel, and an
>   Alan> IA64 designed by people with a brain kernel.
> 
> I think the issue at hand is whether, longer term, it is desirable to
> move all bounce buffer handling into the PCI DMA layer or whether
> Linux should continue to make bounce buffer management visible to
> drivers.  I'd be interested in hearing opinions.

For "lacking" architectures (current ia64 machines, x86 with pae36) the only
real performing solution is to bounce in subsystems (not low level drivers).
The PCI layer doesn't have enough scope to decide what to do...
