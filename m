Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262293AbVCJE3y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262293AbVCJE3y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 23:29:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262197AbVCIXMl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 18:12:41 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:55826 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262499AbVCIWnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 17:43:05 -0500
Date: Wed, 9 Mar 2005 22:42:59 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, domen@coderock.org,
       amitg@calsoftinc.com, gud@eth.net
Subject: Re: [patch 1/1] unified spinlock initialization arch/um/drivers/port_kern.c
Message-ID: <20050309224259.J25398@flint.arm.linux.org.uk>
Mail-Followup-To: Blaisorblade <blaisorblade@yahoo.it>, akpm@osdl.org,
	linux-kernel@vger.kernel.org,
	user-mode-linux-devel@lists.sourceforge.net, domen@coderock.org,
	amitg@calsoftinc.com, gud@eth.net
References: <20050309094234.8FC0C6477@zion> <20050309171231.H25398@flint.arm.linux.org.uk> <200503092052.24803.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200503092052.24803.blaisorblade@yahoo.it>; from blaisorblade@yahoo.it on Wed, Mar 09, 2005 at 08:52:24PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2005 at 08:52:24PM +0100, Blaisorblade wrote:
> On Wednesday 09 March 2005 18:12, Russell King wrote:
> > On Wed, Mar 09, 2005 at 10:42:33AM +0100, blaisorblade@yahoo.it wrote:
> > > From: <domen@coderock.org>
> > > Cc: <user-mode-linux-devel@lists.sourceforge.net>, <domen@coderock.org>,
> > > <amitg@calsoftinc.com>, <gud@eth.net>
> > >
> > > Unify the spinlock initialization as far as possible.
> 
> > Are you sure this is really the best option in this instance?
> > Sometimes, static data initialisation is more efficient than
> > code-based manual initialisation, especially when the memory
> > is written to anyway.
> Agreed, theoretically, but this was done for multiple reasons globally, for 
> instance as a preparation to Ingo Molnar's preemption patches. There was 
> mention of this on lwn.net about this:
> 
> http://lwn.net/Articles/108719/

Was this announced on linux-kernel as well?  I don't remember seeing it.

I'm not convinced about the practicality of converting all static
initialisations to code-based initialisations though - I can see
that the number of initialisation functions scattered throughout
the kernel is going to increase dramatically to achieve this.

With a 2.4 to 2.6 kernel bloat already on the order of 140% for
similar functionality, I can only see the kernel getting more and
more bloated _for the same feature level_ because we're trying to
add more features to the kernel.

I'm not entirely convinced that is an all round sane approach.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
