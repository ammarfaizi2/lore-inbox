Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261995AbREPQZY>; Wed, 16 May 2001 12:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261996AbREPQZO>; Wed, 16 May 2001 12:25:14 -0400
Received: from munchkin.spectacle-pond.org ([209.192.197.45]:22023 "EHLO
	munchkin.spectacle-pond.org") by vger.kernel.org with ESMTP
	id <S261995AbREPQZI>; Wed, 16 May 2001 12:25:08 -0400
Date: Wed, 16 May 2001 12:04:52 -0400
From: Michael Meissner <meissner@spectacle-pond.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jonathan Lundell <jlundell@pobox.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        James Simmons <jsimmons@transvirtual.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        viro@math.psu.edu
Subject: Re: LANANA: To Pending Device Number Registrants
Message-ID: <20010516120452.A16609@munchkin.spectacle-pond.org>
In-Reply-To: <p05100316b7272cdfd50c@[207.213.214.37]> <Pine.LNX.4.21.0105151309460.2470-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0105151309460.2470-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, May 15, 2001 at 01:18:09PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2001 at 01:18:09PM -0700, Linus Torvalds wrote:
> 
> On Tue, 15 May 2001, Jonathan Lundell wrote:
> > >
> > >Keep it informational. And NEVER EVER make it part of the design.
> > 
> > What about:
> > 
> > 1 (network domain). I have two network interfaces that I connect to 
> > two different network segments, eth0 & eth1;
> 
> So?
> 
> Informational. You can always ask what "eth0" and "eth1" are.
> 
> There's another side to this: repeatability. A setup should be
> _repeatable_.
> 
> This is what we have now. Network devices are called "eth0..N", and nobody
> is complaining about the fact that the numbering is basically random. It
> is _repeatable_ as long as you don't change your hardware setup, and the
> numbering has effectively _nothing_ to do with "location".

Well yes and no.  The numbers are currently repeatable for a given kernel, but
I know I and others were bitten by the 2.2. to 2.4 transition, where the kernel
used a different algorithm for the order in which it detected scsi and network
adapters (ie, in my machine with 3 scsi adapters, Linux 2.2 always picked the
Adaptec scsi adapter builtin into my motherboard as the first adapter, but 2.4
decided to pick my TekRam 390F adapter).

As lots of people have been saying, you need to know which physical slot to
plut the wire connecting eth0, eth1, etc. into.  Similarly for serial ports, if
I have 3 or 4 (or 127 :-) USB serial devices, I really don't want to have to
change my cabling each time I boot or change OSes (since I doubt my UPS will be
happy if I give it the commands destined for the X10 controller or my remote
boards).

-- 
Michael Meissner, Red Hat, Inc.  (GCC group)
PMB 198, 174 Littleton Road #3, Westford, Massachusetts 01886, USA
Work:	  meissner@redhat.com		phone: +1 978-486-9304
Non-work: meissner@spectacle-pond.org	fax:   +1 978-692-4482
