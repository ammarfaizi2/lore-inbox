Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313582AbSDMKD7>; Sat, 13 Apr 2002 06:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313583AbSDMKD6>; Sat, 13 Apr 2002 06:03:58 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:54667 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S313582AbSDMKD6>;
	Sat, 13 Apr 2002 06:03:58 -0400
Date: Sat, 13 Apr 2002 12:03:49 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Baldur Norddahl <bbn-linux-kernel@clansoft.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: more than 2 promise ultradma133 TX2 controllers
Message-ID: <20020413120349.A23974@ucw.cz>
In-Reply-To: <20020412131831.GA3185@dark.x.dtu.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2002 at 03:18:31PM +0200, Baldur Norddahl wrote:
> Hi,
> 
> I noticed if I put in more than 2 promise controllers, the onboard BIOS will
> only detect disks on the first 2 controllers.
> 
> I got a system with 4 controllers. Linux detects disks on them all, but when
> it comes to the detect partitions phase it hangs with DMA timeout errors on
> those controllers that didn't get initialized or listed during BIOS boot.
> 
> The "Special UDMA Feature" option is supposed to initialize cards that the
> BIOS forgot. The help seems to indicate that this option was made for OLD
> cards, the ultradma133 TX2 is hardly old :-) Besides, it doesn't work.
> 
> I changed the configuration to be two ultradma133 and two ultradma100 cards.
> Now the BIOS screen is shown twice, one with the two newer cards and one
> with the two older cards. And linux is happy too.
> 
> I have one concern, this setup forces me to put some 160 GB disks on the
> ultradma100 card. Promise never said that card would support this, and the
> BIOS can't detect the disk correctly. Linux however seems to be fine, it
> shows the disks with their correct size and everything seems good. But is it
> safe?

Yes, it is safe. However the fact that 4 133 cards don't work should be
fixed.

UDMA133 isn't rellated to >128GB support in any way.

-- 
Vojtech Pavlik
SuSE Labs
