Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318750AbSHQV42>; Sat, 17 Aug 2002 17:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318751AbSHQV42>; Sat, 17 Aug 2002 17:56:28 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:7369 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S318750AbSHQV41>;
	Sat, 17 Aug 2002 17:56:27 -0400
Date: Sat, 17 Aug 2002 23:59:42 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Alexander Viro <viro@math.psu.edu>, Larry McVoy <lm@bitmover.com>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       linux-kernel@vger.kernel.org
Subject: Re: IDE?
Message-ID: <20020817235942.A11420@ucw.cz>
References: <Pine.GSO.4.21.0208162057550.14493-100000@weyl.math.psu.edu> <Pine.LNX.4.44.0208161822130.1674-100000@home.transmeta.com> <20020817092239.A2211@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020817092239.A2211@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Sat, Aug 17, 2002 at 09:22:39AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 17, 2002 at 09:22:39AM +0100, Russell King wrote:

> On Fri, Aug 16, 2002 at 06:35:29PM -0700, Linus Torvalds wrote:
> > And then in five years, in Linux-3.2, we might finally just drop support 
> > for the old IDE code with PIO etc. Inevitably some people will still use 
> > it (the same way some people still use Linux-2.0 with hd.c), but it won't 
> > have been in the way for making a cleaner driver in the meantime.
> 
> I think you're being too ""mainstream" orientated" here.  Let's look
> at something called PCMCIA.  PCMCIA CF cards.  They're IDE devices
> that only do PIO.
> 
> The majority of ARM platforms being actively produced today provide a
> PCMCIA or CF (_not_ cardbus) socket.  Neither PCI nor Cardbus makes any
> sense in these machines.  Why?  Because they're not your average power
> hungry desktop box that's always plugged into the mains supply.
> 
> I think we're going to have PIO mode IDE around for a fair (ten at
> least?) number of years yet.

We'll need PIO for control commands anyways, but the thing is that we
won't need to speed optimize PIO and will be able to kill multi-sector
PIO completely probably.

-- 
Vojtech Pavlik
SuSE Labs
