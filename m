Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267937AbRHFLBc>; Mon, 6 Aug 2001 07:01:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267933AbRHFLBZ>; Mon, 6 Aug 2001 07:01:25 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:33924 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S267923AbRHFLBR>; Mon, 6 Aug 2001 07:01:17 -0400
Date: Mon, 6 Aug 2001 07:01:24 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: David Luyer <david_luyer@pacific.net.au>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>,
        "David S. Miller" <davem@redhat.com>
Subject: Re: /proc/<n>/maps growing...
Message-ID: <20010806070124.J3862@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
In-Reply-To: <997080081.3938.28.camel@typhaon> <20010806105904.A28792@athlon.random> <20010806063003.H3862@devserv.devel.redhat.com> <20010806124952.G15925@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010806124952.G15925@athlon.random>; from andrea@suse.de on Mon, Aug 06, 2001 at 12:49:52PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2001 at 12:49:52PM +0200, Andrea Arcangeli wrote:
> On Mon, Aug 06, 2001 at 06:30:03AM -0400, Jakub Jelinek wrote:
> > On Mon, Aug 06, 2001 at 10:59:04AM +0200, Andrea Arcangeli wrote:
> > > On Mon, Aug 06, 2001 at 04:41:21PM +1000, David Luyer wrote:
> > > > crashes for no apparent reason every 6 hours or so.. unless that could
> > > > be when
> > > > it hits some 'limit' on the number of mappings allowed? 
> > > 
> > > there's no limit, this is _only_ a performance issue, functionality is
> > > not compromised in any way [except possibly wasting some memory
> > > resources that could lead to running out of memory earlier].
> > 
> > There is a limit, /proc/sys/vm/max_map_count.
> 
> in mainline it's not a sysctl, btw.

Even worse, it means people not using -ac kernels cannot malloc a lot of
memory but by recompiling the kernel.

	Jakub
