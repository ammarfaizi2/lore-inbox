Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264673AbSLLOzv>; Thu, 12 Dec 2002 09:55:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264677AbSLLOzv>; Thu, 12 Dec 2002 09:55:51 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:33400 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S264673AbSLLOzt>; Thu, 12 Dec 2002 09:55:49 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: James Simmons <jsimmons@infradead.org>, Stian Jordet <liste@jordet.nu>,
       Allan Duncan <allan.d@bigpond.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.51
References: <Pine.LNX.4.33.0212101016280.2617-100000@maxwell.earthlink.net>
	<1039547936.538.5.camel@zion> <m1smx4vrem.fsf@frodo.biederman.org>
	<1039602072.3539.42.camel@zion>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 12 Dec 2002 08:01:42 -0700
In-Reply-To: <1039602072.3539.42.camel@zion>
Message-ID: <m1n0nbuvqh.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Wed, 2002-12-11 at 10:25, Eric W. Biederman wrote:
> > > Well, I'm not sure it quite works yet. Maybe unaccelerated, but anyway,
> > > my version of radeonfb for 2.5 isn't accelerated yet anyway. I'll work
> > > on that (or Ani will) now that the API is stable enough.
> > 
> > How well does this driver work if you don't have a firmware
> > driver initialize the card? aka a pci option ROM.
> 
> Probably not at all

Well it was worth asking.
  
> > I am interested because with LinuxBIOS it is still a pain to run
> > PCI option roms, and I don't necessarily even have then if it a
> > motherboard with video.  There are some embedded/non-x86 platforms
> > with similar issues.  
> 
> Well, at least r128's and radeon's need the memory controller and PLLs
> initialized by the BIOS/firmware, we don't have documentation about how
> to acheive that ourselves (and this can depend on the specific wiring of
> a given card anyway).

I believe those actions have to be taken.  I haven't seen how flexible
the chips are with respect to which memory they take, which is
generally where most of the complexity comes in.

I have written northbridge memory initialization code that generally
does not depend on the motherboard, I would be very surprised to find
out that video card are generally more difficult (except in the area
of documentation).

> > My primary interest is in the cheap ATI Rage XL chip that is on many
> > server board. PCI Vendor/device  id 1002:4752 (rev 27) from lspci.
> > 
> > If nothing else if some one could point me to some resources on
> > how to get the appropriate documentation from the video chipset
> > manufacturers I would be happy.
> > 
> > But I did want to at least point that running a system with out bios
> > initialized video was certainly among the cases that are used.
> 
> This is not possible with most modern cards without specific POST code
> provided by the chip manufacturer.

Without documentation surely.  Though for that aspect of things
I primarily care about the cheap controllers that are used for onboard
video.  Which I suspect is a much simpler case to handle.  

Eric



