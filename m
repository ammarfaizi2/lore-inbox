Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267883AbRHFKtd>; Mon, 6 Aug 2001 06:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267890AbRHFKtX>; Mon, 6 Aug 2001 06:49:23 -0400
Received: from ns.suse.de ([213.95.15.193]:49170 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S267883AbRHFKtE>;
	Mon, 6 Aug 2001 06:49:04 -0400
Date: Mon, 6 Aug 2001 12:49:52 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Jakub Jelinek <jakub@redhat.com>
Cc: David Luyer <david_luyer@pacific.net.au>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>,
        "David S. Miller" <davem@redhat.com>
Subject: Re: /proc/<n>/maps growing...
Message-ID: <20010806124952.G15925@athlon.random>
In-Reply-To: <997080081.3938.28.camel@typhaon> <20010806105904.A28792@athlon.random> <20010806063003.H3862@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010806063003.H3862@devserv.devel.redhat.com>; from jakub@redhat.com on Mon, Aug 06, 2001 at 06:30:03AM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2001 at 06:30:03AM -0400, Jakub Jelinek wrote:
> On Mon, Aug 06, 2001 at 10:59:04AM +0200, Andrea Arcangeli wrote:
> > On Mon, Aug 06, 2001 at 04:41:21PM +1000, David Luyer wrote:
> > > crashes for no apparent reason every 6 hours or so.. unless that could
> > > be when
> > > it hits some 'limit' on the number of mappings allowed? 
> > 
> > there's no limit, this is _only_ a performance issue, functionality is
> > not compromised in any way [except possibly wasting some memory
> > resources that could lead to running out of memory earlier].
> 
> There is a limit, /proc/sys/vm/max_map_count.

in mainline it's not a sysctl, btw.

I never noticed this limit and personally I don't like it regardless of
the merge_segments (but of course without merge_segments it is can
trigger problems while switching between 2.2 and 2.4).

Andrea
