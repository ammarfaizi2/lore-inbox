Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262525AbSJRBRY>; Thu, 17 Oct 2002 21:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262631AbSJRBRY>; Thu, 17 Oct 2002 21:17:24 -0400
Received: from [198.149.18.6] ([198.149.18.6]:32684 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S262525AbSJRBRY>;
	Thu, 17 Oct 2002 21:17:24 -0400
Date: Thu, 17 Oct 2002 20:22:48 -0500 (CDT)
From: Robin Holt <holt@sgi.com>
X-X-Sender: <holt@barney.americas.sgi.com>
To: Andi Kleen <ak@muc.de>
cc: Christoph Hellwig <hch@sgi.com>, John Hesterberg <jh@sgi.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.43 CSA, Job, and PAGG
In-Reply-To: <m37kggpnb7.fsf@averell.firstfloor.org>
Message-ID: <Pine.LNX.4.33.0210172022080.6846-100000@barney.americas.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Oct 2002, Andi Kleen wrote:

> Christoph Hellwig <hch@sgi.com> writes:
> 
> > 
> > +#if defined __ia64__
> > +#define JID_ERR1 "do_csa_acct:  No job table entry for jid 0x%lx.\n"
> > +#define JID_ERR2 "csa user job accounting write error %d, jid 0x%lx\n"
> > +#define JID_ERR3 "Can't disable csa user job accounting jid 0x%lx\n"
> > +#define JID_ERR4 "csa user job accounting disabled, jid 0x%lx\n"
> > +#else
> > +#define JID_ERR1 "do_csa_acct:  No job table entry for jid 0x%llx.\n"
> > +#define JID_ERR2 "csa user job accounting write error %d, jid 0x%llx\n"
> > +#define JID_ERR3 "Can't disable csa user job accounting jid 0x%llx\n"
> > +#define JID_ERR4 "csa user job accounting disabled, jid 0x%llx\n"
> > +#endif
> > 
> > Umm, this would be #if __LP64__.  But please just always cast
> > to long long instead.
> 
> __LP64__ is a HP/IA64ism, which is not necessarily defined on other
> 64bit platforms. The proper way to test for 64bit in the kernel is
> 
> #include <linux/types.h>
> 
> ...
> 
> #if BITS_PER_LONG==64
> 
> #endif
> 
> -Andi
> 


I did the cast to long long instead.  Cleans things up nicely.

Robin

