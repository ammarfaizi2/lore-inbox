Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131387AbRCNW2M>; Wed, 14 Mar 2001 17:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131561AbRCNW2C>; Wed, 14 Mar 2001 17:28:02 -0500
Received: from unthought.net ([212.97.129.24]:55948 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S131387AbRCNW1z>;
	Wed, 14 Mar 2001 17:27:55 -0500
Date: Wed, 14 Mar 2001 23:27:14 +0100
From: Jakob Østergaard <jakob@unthought.net>
To: Phil Edwards <pedwards@disaster.jaj.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: State of RAID (and the infamous FastTrak100 card)
Message-ID: <20010314232714.A19404@unthought.net>
Mail-Followup-To: Jakob Østergaard <jakob@unthought.net>,
	Phil Edwards <pedwards@disaster.jaj.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010314155801.A7054@disaster.jaj.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <20010314155801.A7054@disaster.jaj.com>; from pedwards@disaster.jaj.com on Wed, Mar 14, 2001 at 03:58:01PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2001 at 03:58:01PM -0500, Phil Edwards wrote:
> [I am not subscribed at the moment (don't ask :), so please cc me.]
> 
> A few months ago there was a brief discussion about the FastTrak100 card
> and the driver that Promise provides, and just what all can (technically)
> be done.  It eventually became a debate about what may (legally) be done
> with the driver, and then turned into another "what the GPL /really/
> says" thread.  :-)
> 
> I've just read all those messages from the archives.  And I've been
> skimming the RAID-related HOWTOs at linuxdoc.org, but many seem out of date.
> One in particular starts off by saying that the stock 2.2 support is buggy,
> and that the "new" version is much improved, but requires patches and a
> rebuild, and is still alpha code.  Of course, the doc saying it's alpha
> is itself a year old.

Ok, I get the feeling it may be the Software-RAID howto you're referring to
here...  Let me explain why it's  not  updated.

Fact is, I haven't updated the document because 99% of what it says is still
the perfect truth.

Software-RAID in 2.2 is buggy and requires patching to go to the so-called
alpha versions (which the HOWTO explains are not alpha-quality but actually
quite usable).

However, 2.4 is out and doesn't need patching, and I should probably update the
howto to reflect that.  But still, most of what's in the HOWTO is as correct as
it can be.

> 
> The MAINTAINERS and Documentation/* files don't mention the FastTrack100
> (not surprising, it's not OSS) nor software RAID (also unsurprising,
> it's software).

FastTrack100 RAID *is* software RAID - The software is in the proprietary
drivers for the card.

But it's confusing, and Andre Hedrick has already explained this mess on
several occations here on LKML.   Search the archives.

> 
> So... am I just begging for pain if I try to install, say, a stock RH7
> on a machine with the FastTrak100 doing it's little RAID0/JBOD thing?
> If it requires this machine to always boot from a floppy because the driver
> cannot be linked into the kernel, well, I'm okay with that.

I don't know about the state of the FastTrak100 IDE drivers - but if you can
get that running, putting software RAID on top of that should be a simple
matter.

> 
> RH7 ships with 2.2.16.  Is building a new 2.2.18 kernel just going to
> shoot me in the head with this card (and Promise's proprietary driver)?

RH 2.2 kernels have "real" software RAID -  stock 2.2  needs patching.

> 
> What's the state of RAID in the 2.4 kernels?

Good.  No patches needed - software RAID in 2.4 rocks.   And 2.4 supports more
IDE controllers - but again I don't know the state of FastTrak100.

> 
> I'm very leery of solutions that involve lots of patches to the 2.2.x kernel,
> because I have to have a working system in order to rebuild a kernel... and
> I would have to patch the kernel before I can install/boot the system... and
> there will be no other hard drives available in the machine; just the two
> being striped (or glued) by the FastTrak100 Card of Doom.

Use plain RedHat kernels, or patch your own  :)

You can boot on software RAID - it's in the HOWTO  ;)

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
