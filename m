Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312294AbSDJAcd>; Tue, 9 Apr 2002 20:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312302AbSDJAcc>; Tue, 9 Apr 2002 20:32:32 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:38981 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S312294AbSDJAcb>; Tue, 9 Apr 2002 20:32:31 -0400
Date: Wed, 10 Apr 2002 02:30:06 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: Aviv Shavit <avivshavit@yahoo.com>, Ken Brownfield <brownfld@irridia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: vm-33, strongly recommended [Re: [2.4.17/18pre] VM and swap - it's really unusable]
Message-ID: <20020410023006.B6875@dualathlon.random>
In-Reply-To: <20020225224050.D26077@asooo.flowerfire.com> <20020409204545.11251.qmail@web13205.mail.yahoo.com> <20020410013609.A6875@dualathlon.random> <200204100007.g3A07o329371@vindaloo.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2002 at 06:07:50PM -0600, Richard Gooch wrote:
> Andrea Arcangeli writes:
> > I recommend everybody to never use a 2.4 kernel without first applying
> > this vm patch:
> [...]
> 
> The way you write this makes it sound that the unpatched kernel is
> very dangerous. Is this actually true? Or do you really just mean "the
> patched kernel has better handling under extreme loads"?

The unpatched kernel isn't dangerous in the sense it won't destroy data,
it won't corrupt memory and finally it won't deadlock on smp locks, but
it can theoretically deadlock with oom and it has various other runtime
issues starting from highmem balancing, too much swapping, lru list
balancing, related-bhs in highmem, numa broken with += min etc... so
IMHO it is better to _always_ use the patched kernel that takes care of
all problems that I know of at the moment, plus it has further
optimizations. OTOH for lots of workloads mainline is just fine, the
deadlocks never trigger and the runtime behaviour is ok, but unless you
are certain you don't need the vm-33.gz patch, I recommend to apply it.

Andrea
