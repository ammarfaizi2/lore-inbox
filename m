Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266010AbTAFFQm>; Mon, 6 Jan 2003 00:16:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266064AbTAFFQm>; Mon, 6 Jan 2003 00:16:42 -0500
Received: from waste.org ([209.173.204.2]:32689 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S266010AbTAFFQk>;
	Mon, 6 Jan 2003 00:16:40 -0500
Date: Sun, 5 Jan 2003 23:24:48 -0600
From: Oliver Xymoron <oxymoron@waste.org>
To: Andre Hedrick <andre@pyxtechnologies.com>
Cc: Andrew Morton <akpm@digeo.com>, Rik van Riel <riel@conectiva.com.br>,
       Richard Stallman <rms@gnu.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux iSCSI Initiator, OpenSource (fwd) (Re: Gauntlet Set NOW!)
Message-ID: <20030106052448.GD28100@waste.org>
References: <20030106030622.GC28100@waste.org> <Pine.LNX.4.10.10301051924140.421-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10301051924140.421-100000@master.linux-ide.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 05, 2003 at 07:38:15PM -0800, Andre Hedrick wrote:
> On Sun, 5 Jan 2003, Oliver Xymoron wrote:
> 
> > On Sat, Jan 04, 2003 at 06:47:43PM -0800, Andrew Morton wrote:
> > > Andre Hedrick wrote:
> > > > 
> > > > Rik and Richard,
> > > > 
> > > > As you see, I in good faith prior to this holy war, had initiated a formal
> > > > request include a new protocol into the Linux kernel prior to the freeze.
> > > > The extention was requested to insure the product was of the highest
> > > > quality and not limited with excessive erratium as the ratification of the
> > > > IETF modified, postponed, and delayed ; regardless of reason.
> > > > 
> > > > Obviously, PyX had (has) on its schedule to product a high quality target
> > > > which is transport independent on each side of the protocol.  We are not
> > > > sure of this position because of the uncertain nature of the basic usages
> > > > of headers and export_symbols.
> > > > 
> > > 
> > > I suggest that if a function happens to be implemented as an inline
> > > in a header then it should be treated (for licensing purposes) as
> > > an exported-to-all-modules symbol.  So in Linux, that would be LGPL-ish.
> > > 
> > > The fact that a piece of kernel functionality happens to be inlined
> > > is a pure technical detail of linkage.
> > > 
> > > If there really is inlined functionality which we do not wish made
> > > available to non-GPL modules then it should be either uninlined and
> > > not exported or it should be wrapped in #ifdef GPL.
> > 
> > More pragmatically, who cares? There's already at least one vendor
> > (Cisco) who ships a perfectly good fully GPLed iSCSI initiator module
> > that doesn't need to touch any core code. It's already the benchmark
> > for compatibility at interoperability tests. And it's following the
> > IETF drafts closely too. Once we actually have an iSCSI RFC, it might
> > be worth pulling it into the kernel tree. I believe Red Hat is
> > shipping it some form already.
> 
> If you know anything about iSCSI RFC draft and how storage truly works.
> Cisco gets it wrong, they do not believe in supporting the full RFC.
> So you get ERL=0, and now they turned of the "Header and Data Digests",
> this is equal to turning off the iCRC in ATA, or CRC in SCSI between the
> controller and the device.  For those people who think removing the
> checksum test for the integrity of the data and command operations, you
> get what you deserve.

CRC code seems to be functional, at least in their most recent drop.
As for ERL, the state of error handling in the rest of the Linux IO
layer suggests that's a lower triage priority..

If and when it becomes a high priority, well, the community is free to do what
it likes with the source.

> Next try to support any filesystem regardless of platform.
> Specifically anything Microsoft does to thwart Linux, I have already
> covered.

I'm having a very hard time making any sense of that statement.
There's no reason an iSCSI initiator on the MS side should care what
OS is serving it iSCSI. And the target shouldn't give a damn whether
it's serving up a filesystem.

> The target(erl=0) is what would be the second phase to open source, but I
> see you and other want to do the hard way and that is fine.
>
> In two week I will have NetBSD certified, and 4 weeks later should have
> Solaris certifed.

Frankly, I think you're the one choosing the hard path. Proprietary
code is the domain of corporate giants and you're likely to get
squished - marketing matters more than quality. If you choose to go
that road, I wish you the best of luck.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
