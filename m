Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261330AbTAOLDg>; Wed, 15 Jan 2003 06:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262838AbTAOLDg>; Wed, 15 Jan 2003 06:03:36 -0500
Received: from [81.2.122.30] ([81.2.122.30]:13061 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S261330AbTAOLDf>;
	Wed, 15 Jan 2003 06:03:35 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200301151112.h0FBC8l5000957@darkstar.example.net>
Subject: Re: [RFC] add module reference to struct tty_driver
To: rmk@arm.linux.org.uk (Russell King)
Date: Wed, 15 Jan 2003 11:12:08 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
In-Reply-To: <20030115104016.E31372@flint.arm.linux.org.uk> from "Russell King" at Jan 15, 2003 10:40:16 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > Woah!  Hm, this is going to cause lots of problems in drivers that have
> > > > been assuming that the BKL is grabbed during module unload, and during
> > > > open().  Hm, time to just fallback on the argument, "module
> > > > unloading is unsafe" :(
> > > 
> > > Note that its the same in 2.4 as well.  iirc, the BKL was removed from
> > > module loading/unloading sometime in the 2.3 timeline.
> > 
> > Surely no recent code should be making that assumption anyway - the
> > BKL is being removed all over the place.
> 
> The TTY layer isn't "recent code", its "very old code"

Oh, I know, I was just thinking aloud and not making much sense, ( :-)
) - what I really meant was is anybody writing new code without the
near-future BKL changes in mind, and if so, shouldn't it be avoided
now to save work in 2.7?  I.E. is the BKL officially depreciated?

> and (IMO) removing the BKL from the TTY layer is a far from trivial
> matter.
> 
> I believe at this point in the 2.5 cycle, we should not be looking
> to remove the BKL.

I think there were hints in another thread of a TTY layer overhaul in
2.7.

John.
