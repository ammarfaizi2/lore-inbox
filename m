Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265052AbSJaAlO>; Wed, 30 Oct 2002 19:41:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265055AbSJaAlO>; Wed, 30 Oct 2002 19:41:14 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:14552 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S265052AbSJaAlI>;
	Wed, 30 Oct 2002 19:41:08 -0500
Date: Thu, 31 Oct 2002 00:47:11 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: post-halloween 0.2
Message-ID: <20021031004710.GB10329@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20021030171149.GA15007@suse.de> <1036006381.5297.108.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1036006381.5297.108.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2002 at 07:33:01PM +0000, Alan Cox wrote:

 > > (Things not expected to work just yet)
 > > - The hptraid/promise RAID drivers are currently non functional.
 > [These hopefully can be converted to use device mapper..]

Thats a fairly large 'mandatory' requirement for existing users
of hptraid and friends.

 > > - Various SCSI drivers still need work, and don't even compile.
 > Many older network drivers ditto
 > Much of the ISDN layer ditto

I held off on this to see if Kai would get things in order in time.
Looking at current BK, it looks like he's done quite a bit.
Kai, any changes from a user point of view wrt tools ?

 > > - software suspend is still in development, and in need of more work.
 > >   It is unlikely to work as expected currently.
 > > - Some filesystems still need work (Coda, Intermezzo).
 > 		UFS, HFS HPFS,...

Hadn't realised they were still broken. Added to the list.

 > Add "Most older SCSI controllers are *NOT* doing error handling. Be
 > careful."

Added. Was covered by the 'most drivers wont compile' though now that
current BK has nuked the abort: and reset: members.

 > Add "Simplex IDE devices (eg Ali15x3) are missing DMA sometimes"
 > Add "Serverworks OSB4 may panic on bad blocks or other non fatal errors"
 > Add "PCMCIA IDE hangs on eject"
 > Add "Most PCMCIA devices have unload races and may oops on eject"
 > Add "Modular IDE does not yet work, modular IDE PCI modules sometimes
 > oops on loading"
 
Added.

 > LVM1 is no longer supported, upgrade to LVM2. This supports the LVM1
 > disk format.

Was covered in the devicemapper section.
Reworded to make the 'backwards compatability' thing a bit more obvious.

 > > (Note that the OSS drivers are also still functional, and
 > >  still present)
 > Kind of work in some cases, they are deprecated and may vanish before
 > 2.6 or may vanish the release after.

I'd agree that it would make sense to at least remove some of the
lesser maintained drivers. Linus didnt seem to keen on the idea
last time I proposed it.

 > > Additional work on the ATA code is happening in 2.4-ac, and pending
 > > merging to 2.5
 > Actually its happening in 2.5 back merging to 2.4-ac now.

Oops, my bad. Hard to keep up with the crazy world of IDE these days..

 > > IDE TCQ
 > > ~~~~~~~
 > > Tagged command queueing for IDE devices has been included.
 > > Not all devices may like this, so handle with care.
 > > If you didn't choose the "TCQ on by default" option,
 > > you can enable it by using the command
 > > 
 > > echo "using_tcq:32" > /proc/ide/hdX/settings
 > > (replacing 32 with 0 disables TCQ again).
 > > Report success/failure stories to Jens Axboe <axboe@suse.de> with
 > > inclusion of hdparm -i /dev/hdX
 > 
 > ** Don't use IDE TCQ on any data you value.

Ok, I'll make that a little bolder. (In fact, I'll just
cut-n-paste your text 8-)


Thanks for the feedback. I've merged the rest of your
comments, and will put an updated version up after
merging everyone elses feedback too 8-)

BTW: How's i2o shaping up in 2.5 ?

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
