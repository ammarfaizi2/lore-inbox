Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313569AbSDLNSe>; Fri, 12 Apr 2002 09:18:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313571AbSDLNSd>; Fri, 12 Apr 2002 09:18:33 -0400
Received: from dark.x.dtu.dk ([130.225.92.246]:10629 "HELO dark.x.dtu.dk")
	by vger.kernel.org with SMTP id <S313569AbSDLNSd>;
	Fri, 12 Apr 2002 09:18:33 -0400
Date: Fri, 12 Apr 2002 15:18:31 +0200
From: Baldur Norddahl <bbn-linux-kernel@clansoft.dk>
To: linux-kernel@vger.kernel.org
Subject: more than 2 promise ultradma133 TX2 controllers
Message-ID: <20020412131831.GA3185@dark.x.dtu.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I noticed if I put in more than 2 promise controllers, the onboard BIOS will
only detect disks on the first 2 controllers.

I got a system with 4 controllers. Linux detects disks on them all, but when
it comes to the detect partitions phase it hangs with DMA timeout errors on
those controllers that didn't get initialized or listed during BIOS boot.

The "Special UDMA Feature" option is supposed to initialize cards that the
BIOS forgot. The help seems to indicate that this option was made for OLD
cards, the ultradma133 TX2 is hardly old :-) Besides, it doesn't work.

I changed the configuration to be two ultradma133 and two ultradma100 cards.
Now the BIOS screen is shown twice, one with the two newer cards and one
with the two older cards. And linux is happy too.

I have one concern, this setup forces me to put some 160 GB disks on the
ultradma100 card. Promise never said that card would support this, and the
BIOS can't detect the disk correctly. Linux however seems to be fine, it
shows the disks with their correct size and everything seems good. But is it
safe?

The kernel version is 2.4.18 with IDE patches (for ultradma133 support and
>128GB disk support).

Thanks,
  Baldur
