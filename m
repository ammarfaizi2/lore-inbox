Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129789AbRAPVVZ>; Tue, 16 Jan 2001 16:21:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132912AbRAPVVP>; Tue, 16 Jan 2001 16:21:15 -0500
Received: from munchkin.spectacle-pond.org ([209.192.197.45]:26126 "EHLO
	munchkin.spectacle-pond.org") by vger.kernel.org with ESMTP
	id <S129789AbRAPVVE>; Tue, 16 Jan 2001 16:21:04 -0500
Date: Tue, 16 Jan 2001 16:23:15 -0500
From: Michael Meissner <meissner@spectacle-pond.org>
To: Andi Kleen <ak@suse.de>
Cc: Michael Meissner <meissner@spectacle-pond.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Linux not adhering to BIOS Drive boot order?
Message-ID: <20010116162315.B1609@munchkin.spectacle-pond.org>
In-Reply-To: <1355693A51C0D211B55A00105ACCFE64E95191@ATL_MS1> <Pine.LNX.4.21.0101161154580.17397-100000@sol.compendium-tech.com> <20010116153757.A1609@munchkin.spectacle-pond.org> <20010116220125.A10985@gruyere.muc.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010116220125.A10985@gruyere.muc.suse.de>; from ak@suse.de on Tue, Jan 16, 2001 at 10:01:25PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 16, 2001 at 10:01:25PM +0100, Andi Kleen wrote:
> On Tue, Jan 16, 2001 at 03:37:57PM -0500, Michael Meissner wrote:
> > don't assume that the way your system gets booted is the way everybody's does,
> > particularly those on platforms other than the x86.
> > 
> > I must say, as a 5 year Linux user (and 23 year UNIX user/administrator), I do
> > get tired of having to hunt down and deal with each of these changes that come
> > up from time to time with Linux (ie, switching from ipfwadm to ipchains to
> > netfilter, or in this case reordering how scsi adapters/network adapters are
> > looked up).
> 
> Bad example. 
> 
> netfilter does not force you to switch anything. You can just load the ipchains
> or even the ipfw module and use your old scripts.

Granted I was mainly thinking of the ipfwadm->ipchains conversion, but you have
to root around and load the appropriate module.  I like to build as much into
the kernel as possible, and it took some amount of time to get things so that I
could build the ipchains modules, since you are presented with choices that
preclude building of the modules.  If I had been using make config instead of
make xconfig, it would have been worse, since I would have to go through the
questions each time to get to the network section.  I could also use the
various incompatible transforms MD support has had over the years for another
example, or the number of times system status monitors break due to changes in
the output of /proc files (and yes I grant you many of the changes are due to
poor programming in the status programs, but not all of them).

Yes, change is one of the things that makes Linux strong.  However, change to
the way things are done can piss people off to using an alternate system, such
as happened to Sun when they changed from the BSD method of system
administration to System V many years ago.

-- 
Michael Meissner, Red Hat, Inc.  (GCC group)
PMB 198, 174 Littleton Road #3, Westford, Massachusetts 01886, USA
Work:	  meissner@redhat.com		phone: +1 978-486-9304
Non-work: meissner@spectacle-pond.org	fax:   +1 978-692-4482
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
