Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310816AbSC1AYP>; Wed, 27 Mar 2002 19:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311026AbSC1AYG>; Wed, 27 Mar 2002 19:24:06 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:11014
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S310816AbSC1AX7>; Wed, 27 Mar 2002 19:23:59 -0500
Date: Wed, 27 Mar 2002 16:23:34 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Erik Andersen <andersen@codepoet.org>
cc: Jos Hulzink <josh@stack.nl>, jw schultz <jw@pegasys.ws>,
        linux-kernel@vger.kernel.org
Subject: Re: DE and hot-swap disk caddies
In-Reply-To: <20020328001709.GA16582@codepoet.org>
Message-ID: <Pine.LNX.4.10.10203271618550.6006-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Mar 2002, Erik Andersen wrote:

> On Wed Mar 27, 2002 at 03:57:48PM -0800, Andre Hedrick wrote:
> > > If you really want to build in IDE hot swap support, I demand it comes
> > > with a warning: Enabling this option will probably destroy your harddisks
> > > and your chipset. Feel free to continue, but don't blame us.
> > 
> > FYI, there was almost a witch hunt when I went into T13 with a SCA4ATA
> > proposal.  You understand the issue and I am glad it was you and not me to
> > have to bang this drum.  Thanks.
> 
> Ok.  How about my laptop?  I have an ATAPI zip drive I can plug
> in instead of a second battery.  It is the only device on the
> second IDE bus (hdc).  In windows there is a little hotplug
> utility thing one runs before unplugging the zip drive.  In Linux
> I currently have to reboot if I want the ide-floppy driver to see
> the device...  I'm willing to bet that Dell has done mysterious
> stuff to make the electrical part work.  It would sure be nice if
> I could ask the ide driver to kindly re-scan for /dev/hdc now.
> 
> Is whatever windows is doing when I hotplug my zip drive somehow
> unsafe, such that supporting the same functionality on Linux is
> somehow a Bad Thing(tm)?

That is not an ATA interface, it is Media Bay transport.
I will bet you they have not on a native 40-pin header that a ribbon
connects.  Everyone is thinking it is easy, but it is not.

There was one company how got it correct, but I do not know if they are
still around.  The solution is not CHEAP, it requires total HOST vender
unique callers and special state diagrams.  Also this was a true
Master/Slave pair solution, the hook was it broke the timing skews on the
buss. Thus Ultra33 or mode 2 as the limit.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

