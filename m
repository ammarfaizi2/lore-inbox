Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291658AbSBAJzs>; Fri, 1 Feb 2002 04:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291659AbSBAJzi>; Fri, 1 Feb 2002 04:55:38 -0500
Received: from nat-pool-meridian.redhat.com ([12.107.208.200]:58813 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S291658AbSBAJzX>; Fri, 1 Feb 2002 04:55:23 -0500
Date: Fri, 1 Feb 2002 04:55:18 -0500
From: Arjan van de Ven <arjanv@redhat.com>
To: Joe Thornber <thornber@fib011235813.fsnet.co.uk>
Cc: lvm-devel@sistina.com, Jim McDonald <Jim@mcdee.net>,
        Andreas Dilger <adilger@turbolabs.com>, linux-lvm@sistina.com,
        linux-kernel@vger.kernel.org, evms-devel@lists.sourceforge.net
Subject: Re: [Evms-devel] Re: [linux-lvm] Re: [lvm-devel] [ANNOUNCE] LVM reimplementation ready for beta testing
Message-ID: <20020201045518.A10893@devserv.devel.redhat.com>
In-Reply-To: <OFBCE93B66.F7B9C14E-ON85256B52.006B8AB3@raleigh.ibm.com> <20020131125211.A8934@fib011235813.fsnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020131125211.A8934@fib011235813.fsnet.co.uk>; from thornber@fib011235813.fsnet.co.uk on Thu, Jan 31, 2002 at 12:52:11PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2002 at 12:52:11PM +0000, Joe Thornber wrote:
> On Thu, Jan 31, 2002 at 01:52:29PM -0600, Steve Pratt wrote:
> > Joe Thornber wrote:
> > >On Wed, Jan 30, 2002 at 10:03:40PM +0000, Jim McDonald wrote:
> > >> Also, does/where does this fit in with EVMS?
> > 
> > >EVMS differs from us in that they seem to be trying to move the whole
> > >application into the kernel,
> > 
> > No, not really.  We only put in the kernel the things that make sense to be
> > in the kernel, discovery logic, ioctl support, I/O path.  All configuration
> > is handled in user space.
> 
> There's still a *lot* of code in there; > 26,000 lines in fact.
> Whereas device-mapper weighs in at ~2,600 lines.  This is just because
> you've decided to take a different route from us, you may be proven to
> be correct.

There is one thing that might spoil the device-mapper "just simple stuff
only" thing: moving active volumes around. Doing that in userspace reliably
is impossible and basically needs to be done in kernelspace (it's an
operation comparable with raid1 resync, a not even that hard in kernel
space). However, that sort of automatically requires kernelspace to know
about volumes, and from there it's a small step....

Greetings,
   Arjan van de Ven
