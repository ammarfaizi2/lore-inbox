Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129886AbRALSSV>; Fri, 12 Jan 2001 13:18:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129811AbRALSSL>; Fri, 12 Jan 2001 13:18:11 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:18698
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S129886AbRALSSA>; Fri, 12 Jan 2001 13:18:00 -0500
Date: Fri, 12 Jan 2001 10:17:36 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: ide.2.4.1-p3.01112001.patch
In-Reply-To: <Pine.LNX.4.10.10101120949040.1858-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.10.10101121009230.1147-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jan 2001, Linus Torvalds wrote:

> 
> 
> On Fri, 12 Jan 2001, Andre Hedrick wrote:
> > 
> > Scratch that patch it has 2 typos that are in amd74xx.c 
> > 
> > will do it again..........
> 
> I will scratch your new patch too.
> 
> I want to see the code to handle the apparent VIA DMA bug. At this point,
> preferably by just disabling DMA on VIA chipsets or something like that
> (if it has only gotten worse since 2.2.x, I'm not interested in seeing any
> experimental patches for it during early 2.4.x).

Well that "experimental patch" is designed to get out of the dreaded
"DMA Timeout Hang" or deadlock that is most noted by the PIIX4 on the
Intel 440*X Chipset groups.  Since it appears that their bug was copied
but other chipset makers......you see the picture clearly, right?

> We've already had one major fs corruption due to this, I want that fixed
> _first_.

Well since I do not have VIA boards and Vojtech Pavlik <vojtech@suse.cz>
is doing that chipset, take that issue to him.  VIA has always been a HACK
fro mthe beginning because it was written off the whitepapers that stink.

The AMD and HPT366 code were to be in 2.4.0 release, but the early
surprize caused most to be off guard.

I will pull the TIMEOUT but this is one you have bitched me out before
about not fixing or attempting to fix.  You can not have it both ways.
This is why I made it a compile option and not default.  I have one report
that it does not help....thus I changed it to a compile option.  Yes one
report took it from mainstream to option.

Cheers,

Andre Hedrick
Linux ATA Development


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
