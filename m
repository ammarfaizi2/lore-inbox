Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264001AbTANPis>; Tue, 14 Jan 2003 10:38:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264010AbTANPis>; Tue, 14 Jan 2003 10:38:48 -0500
Received: from gate.perex.cz ([194.212.165.105]:24836 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S264001AbTANPiq>;
	Tue, 14 Jan 2003 10:38:46 -0500
Date: Tue, 14 Jan 2003 16:45:39 +0100 (CET)
From: Jaroslav Kysela <perex@perex.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: Adam Belay <ambx1@neo.rr.com>
cc: Linus Torvalds <torvalds@transmeta.com>, Greg KH <greg@kroah.com>,
       Zwane Mwaikambo <zwane@holomorphy.com>, Shawn Starr <spstarr@sh0n.net>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PnP update - drivers
In-Reply-To: <20030113173906.GA605@neo.rr.com>
Message-ID: <Pine.LNX.4.33.0301141614310.545-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jan 2003, Adam Belay wrote:

> On Sun, Jan 12, 2003 at 08:30:57PM +0100, Jaroslav Kysela wrote:
> > Hi,
> >
> > 	this patch must be applied after PnP patch v0.94. It contains my
> > small cleanups of PnP code and I tried to rewrite almost all ISA PnP
> > drivers to new PnP subsystem except sound drivers (ALSA & OSS). Please,
> > apply to get away compilation problems.
> >
> > 						Jaroslav
> 
> 
> Hi Jaroslav,

Hi,

> Next time send pnp related changes to me directly.  I would have been happy
> to include your work after I carefully reviewed it.  I was planning to merge
> a very large resource algorithm improvement soon, but now because of these
> changes, that I do not even necessarily agree with, I will be unable to
> include this major improvement and bug fix for a while.  Furthermore many
> people of whom are counting on me to merge thier patches will now be
> dissappointed to hear that their changes, many of which are critical for
> certain pnp hardware configurations will be delayed.

I'm sorry Adam, but you are doing this work very slowly. While I'm one of 
people who approved your changes, I'm feeling a bit responsible for 
situation when most of older driver cannot be compiled. So I tried to do 
all changes which I need for ALSA and also revert all PnP drivers to state 
when they can be USED!!!

> Although I am glad to see the drivers converted, this has been done in a way
> that is not desirable.  They use compat.c which was intended as a temporary
> solution.  In fact I may even remove compat.c all together.  This has been
> clearly stated in both the file compat.c and pnp.txt documentation.  
> Attached is a copy of Zwane's ide conversion patch against 2.5.56. It can be
> used as an example of a correct driver conversion.  Notice how it is fully
> integrated into the driver model as all drivers should be.

My work is not indended to do the right conversion. It's up to maintainers 
of drivers, but I tried to convert drivers to some USEABLE STATE. Also, 
you have still the chance to do it better..

> I'm now unhappy with the current pnp code and will most likely revert all pnp
> changes between 2.5.56 and 2.5.57 to avoid a merging nightmare.  I will then
> carefully remerge what I feel is acceptable.

Sorry, but I think that Linus won't accept your changes in this way.

> Once again, I'm sorry to those who will be unable to use thier systems due to
> this major set back.  All pnp changes should be sent to me and me only.  I
> believe these pnp change conflicts can easily be worked out with better
> communication.  I intend to make a better effort in the future to explain my
> goals and I hope that you will do the same.  I appreciate your work with the
> pnp layer.

But, please, be faster, much faster.... I'm waiting for stabilizing PnP
over two months to make our ALSA ISA PnP drivers working again with all
features. You simply deleted older ISA PnP API leaving all drivers in
non-functional stage. That's bad, very bad. Also, I have other work to do 
than rewrite the PnP drivers.

						Jaroslav

BTW: I tested ISA PnP code outside kernel (in ALSA drivers) more than half 
of year.

BTW2: I also think that I'm author of the auto-configuration mechanism and 
resource descriptions, so it would be nice to have also credit in
the pnp_init() function.

BTW3: I'm happy, that I can start with rewritting of ALSA drivers now.

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


