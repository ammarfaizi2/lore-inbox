Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271079AbUJVKvt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271079AbUJVKvt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 06:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271109AbUJVKvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 06:51:49 -0400
Received: from hermine.aitel.hist.no ([158.38.50.15]:23315 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S271079AbUJVKv2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 06:51:28 -0400
Date: Fri, 22 Oct 2004 10:57:16 +0000
From: Helge Hafting <helgehaf@aitel.hist.no>
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
To: Timothy Miller <miller@techsource.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <4176E08B.2050706@techsource.com>
In-Reply-To: <4176E08B.2050706@techsource.com> (from miller@techsource.com
	on Thu Oct 21 00:02:51 2004)
X-Mailer: Balsa 2.2.4
Message-Id: <1098442636l.17554l.0l@hh>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	DelSp=Yes	Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-10-2004 00:02:51, Timothy Miller wrote:
[...]
> So, here are some questions to answer:
> 
> (1) Would the sales volumes of this product be enough to make it  
> worth producing (ie. profitable)?
No idea about this.

> (2) How much would you be willing to pay for it?

About the same as for other video cards.  As a buyer, I look for what
different cards do and what I want.  Note that many otherwise great
cards loose because fantastic 3D is lost when there is no linux driver.
Or when the linux driver don't get that fantastic performance.  Or when
it is x86-binary only - someday I'll run a 64-bit kernel on my opteron,  
and loose some x86-binary stuff.  So I try not to have it in advance.

Drivers won't be a problem for your card, so it beats all those who  
have such problems.  And that might be most of them . . .

Openness _is_ a feature, so I'll pay more for that, but not lots more.

> (3) How do you feel about the choice of neglecting 3D performance as  
> a priority?  How important is 3D performance?  In what cases is it  
> not?

I want 3D - but I don't need high-end 3D.  My nice old G550 is fine
for playing tuxracer at 1280x1024.  Actually, 640x512 is okay for
gaming.

Now, I also want several cards in one machine, for a multiuser setup.
This is hard, because the newest cards doesn't like to be
secondary and old cards are not available in shops. (And buying used
usually mean you can't return it...)

> (4) How much extra would you be willing to pay for excellent 3D
> performance?

Not that much - you might want this to be an option, such as an
empty socket where the high-end people plug in a expensive high-end 3D  
add-on chip/card.

> (5) What's most important to you, performance, price, or stability?
>
Stability
price
performance

Of course performance can't be _too_ bad, but it _have_ to be stable.


> Feel free to insert your own questions and answers here.  Remember,
> I'm
> an engineer.  My understanding of business is dilettantish at best.
> 
> I haven't worked out a complete design spec for this product.  The
> reason is that what we think people want and what people REALLY want
> may
> not be congruent.  If you have a good idea for a piece of graphics
> hardware which you think would be beneficial to the free software
> community (and worth it for a company to produce), then Tech Source,
> as
> a graphics company, might be willing to sell it.
>


Video stuff I want:
===================

24-bit color
------------
Nice 2D performance & stability when using 24-bit color.  I do photo
editing, 16-bit color isn't really enough for this.  I have noticed  
some cards loose performance and stability when going 24-bit.  I can
understand the performance loss (more data) but not the instability.
Of course the complete docs will help with any stability issues.

Some 3D
-------
Enough 3D to play open-source games like tuxracer.  Hopefully the more
demanding games will work by lowering detail or configuring them
to not try to use advanced graphics operations the "simple" card
doesn't support.

Multiuser capabilities
----------------------
Ability to have several users use independend displays.  I.e.
the displays are controlled by different xserver processes,
_not_ one xserver running them all.  This is necessary for
multiuser setups.

The point here is that I don't want to maintain two PCs when
one pc with two sets of screen+kbd+mouse will do.  Ideally,
the two fully independent graphichs engines should go on one
card.  Not to get it cheaper, I'll happily pay the price of
two cards for this, but to get the higher bandwith of the AGP bus for  
both users.  Sure - they'll have to share it - I guess sharing the
AGP bandwith still beats having one user using AGP and the other
using PCI.  At least for the user with the pci card . . .

I'll settle for the two-card solution though - with this being
a niche product already you probably don't want a niche
product within the niche. :-/

I have problems implementing this sort of thing with other cards.
The pc bios only initialize the bios on the "primary" card, probably
because VGA devices clash with each other.  Now this is an
argument for _not_ supporting VGA.  This cause trouble for all
cards that needs proper bios initialization to work with linux.
Of course your card won't really need such initialization, being
fully documented means that the linux kernel framebuffer driver
and/or the xfree driver can initialize it itself!
Still, it is sometimes nice being able to have the initial console
on a secondary card, so finding some way to have all the cards
in the machine set up early is nice.  (Including the case where
your card is secondary and the primary is someone else's card,
so we can't rely on the primary card bios initializing other
cards too.  Perhaps a dip switch on the card that makes it
announce itself as a "mass storage device" instead - the pc
bios call the initialization function on all of those. :-)

Other problems I see with dual xservers is that screen blanking,
resolution switching or the xserver restarting on one card occationally  
cause trouble on the other.  That is probably a
xserver problem - make sure the xserver for your card have no such  
issues. Selling extra cards to people who want such setups might
become a nice fraction of your market.  After all, an extra card,  
keyboard, screen and mouse is a lot cheaper than an entire extra pc.
It saves space and power too, and the user don't have to install
software twice, upgrade twice and so on.  It is a fantastic
solution for budget-constrained home users.

Video frequency programming
---------------------------
Ability to have the exact same frequencies in X and on the
framebuffer console - and switching between X and
consoles without upsetting the sync signals. Upsetting the
video signals a little is ok, I don't mind flickering
but I hate to wait for the dead slow resynchronization
on my flat panels.

I also like the ability to switch seamlessly between different  
resolutions that happens to be equivalent seen from the
monitor side.  Such as between 1280x1024 and a 640x512 doublescan mode.
The doublescan mode simply turns one pixel into four - the frequencies
remain the same as it really is 1280x1024 based on less data.  Other  
cards can do this, but they manage to
loose sync with the monitor half of the time anyway, perhaps they
try to make the switch and start a new frame in the middle of
a scanline or some such.


What I see no need for - stuff to drop to get it cheaper:
=========================================================
* Less than 24-bit color modes - if dropping those simplifies anything.
  Fully documented graphichs acceleration ought to get decent
  performance from this thing anyway.

* VGA compatibility.  It is such a non-issue.
  Totally unnecesary when you provide a bios that
  lets the thing boot anyway, and full documentation for the
  framebuffer and xserver people. I don't know if this actually saves
  much - don't include VGA if it might increase price by 10%. Also,
  legacy VGA is only trouble for those who want two or more
  cards in the same machine.


Other ideas
===========
* Windows driver.  Nice for those that still run windows occationally
  on the same machine.  Perhaps some non-gaming windows users will
  consider the card too, if it is cheap or use a lot less power than
  others.  Windows is still big, so you won't need a big percentage
  of this market before it is a nice amount of extra sales.
  Businesses might actually like the inability to run the latest
  3D-heavy games - it prevents users from wasting time at work.

* Consider a version to include on motherboards.  Low-end 3D shouldn't
  be a problem there, because those who really care about 3D always
  buys the latest 3D board anyway and never use the onboard thing.
  Not even if it is good 3D, because the very best is always newer.
  Make sure it works both as primary and secondary device in this case
  too.  It'll be nice for server boards - those rarely need  high-
  end 3D.  Those concerned about security might like the fact that
  hw bugs may be fixed by reprogramming the FPGA. It may also be an
  option for makers of cheap boards - they might want to boast about
  having on-board graphichs for a all-in-one motherboard, but they
  might not want to include a expensive high-end chip.
  Also, a deal with some board manufacturer might get you some volume
  for the chips.  The windows driver will probably be necessary for
  this.

* Consider using ordinary DIMM slots for the memory.  Selling a memory-
  less version of the card lets users put in whatever amount they
  think they need - today and next year.  And tinkerers can reuse
  memory from old machines.

Helge Hafting





