Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318209AbSIOTpx>; Sun, 15 Sep 2002 15:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318222AbSIOTpx>; Sun, 15 Sep 2002 15:45:53 -0400
Received: from dsl-213-023-020-240.arcor-ip.net ([213.23.20.240]:38784 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318209AbSIOTpw>;
	Sun, 15 Sep 2002 15:45:52 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Daniel Jacobowitz <dan@debian.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB changes for 2.5.34
Date: Sun, 15 Sep 2002 21:48:51 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, David Brownell <david-b@pacbell.net>,
       Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       Greg KH <greg@kroah.com>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
References: <E17qen4-00008R-00@starship> <Pine.LNX.4.44.0209151220360.1393-100000@home.transmeta.com> <20020915193223.GA22800@nevyn.them.org>
In-Reply-To: <20020915193223.GA22800@nevyn.them.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17qfNz-00008n-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 15 September 2002 21:32, Daniel Jacobowitz wrote:
> On Sun, Sep 15, 2002 at 12:26:02PM -0700, Linus Torvalds wrote:
> > 
> > On Sun, 15 Sep 2002, Daniel Phillips wrote:
> > > 
> > > I use UML all the time.  It's great, but it doesn't work for SMP debugging.
> > 
> > That should not be something fundamental, though. It should be perfectly 
> > doable with threading. "SMOP".
> 
> I run into problems fairly often that I can't reproduce in UML - timing
> sensitive, hardware sensitive, etc.  Some of them KGDB perturbs too
> much to be useful, but most of the time I can get it to work.  UML also
> doesn't use a lot of the code under arch/i386/ (or didn't at least)
> which makes debugging that code under UML a bit futile.

True, however, it's really amazing what a wide range of kernel problems
UML does faithfully reproduce.  It is, after all, just another port.  You
could make the same argument about MIPS distorting timings vis a vis i386.

> > Yeah, and gdb (not to mention all the grapical nice stuff) sucks in a
> > threaded environment. At least it used to. 
> 
> Well, yeah.  It's getting a little bit better - a lot better for some
> cases - but no one's really sure where it needs to go to keep
> improving.  I'm making a little progress.

Oh, and there is another big suckage in UML in the area of modules, you
have to load the symbols by hand, which is just enough pain to make it
not worth compiling things as modules in UML.  Jeff has reasons why its
hard to get gdb to load the module symbols automatically, but hopefully,
that is another problem we can dig into now that UML is officially part
of the tree.

-- 
Daniel
