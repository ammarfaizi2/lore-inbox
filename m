Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268028AbTBRUg1>; Tue, 18 Feb 2003 15:36:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268029AbTBRUg1>; Tue, 18 Feb 2003 15:36:27 -0500
Received: from newpeace.netnation.com ([204.174.223.7]:8579 "EHLO
	peace.netnation.com") by vger.kernel.org with ESMTP
	id <S268028AbTBRUg0>; Tue, 18 Feb 2003 15:36:26 -0500
Date: Tue, 18 Feb 2003 12:46:27 -0800
From: Simon Kirby <sim@netnation.com>
To: Robbert Kouprie <robbert@radium.jvb.tudelft.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.21-pre4] IDE hangs box after timeout
Message-ID: <20030218204627.GA28379@netnation.com>
References: <Pine.LNX.4.44.0302181257260.16107-100000@radium.jvb.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302181257260.16107-100000@radium.jvb.tudelft.nl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2003 at 01:25:40PM +0100, Robbert Kouprie wrote:

> I encountered the same problem on a system with just one PDC20269, 2
> drives attached to it, and 2 drives attached onboard. This system has an
> Enermax 430W power supply, and I would think this was enough for a pentium
> 3, 3 PCI cards and 4 disks.
> 
> Kernels older than 2.4.18 don't have LBA48 support, so would restrict the
> 20269 in its use. I also encountered the problem with kernel 2.4.17 +
> Andre Hedrick's IDE patch, though. Also with 2.4.18/19 and various 2.4.20
> -pre and -ac versions upto 2.4.20-rc1-ac4. Testing 2.4.21-pre4-ac4 now.
> 
> > I had to use a number of power splitters which are, of course, cheap
> > and thus unreliable, and occasionally a few drives will fall off of
> > the bus.
> 
> I don't use power splitters as this power supply has enough connectors.

Well, I just threw an Enermax EG465P in there along with a dual 350W
redundant supply, and I still had to use about four splitters. O:)
The box has 20 drives and about 10 80mm fans in it, so splitters
were definitely a problem for me.

> > hda: dma_timer_expiry: dma status == 0x21
> > hda: timeout waiting for DMA
> > hda: timeout waiting for DMA
> > hda: (__ide_dma_test_irq) called while not waiting
> 
> I see the exact same message.

Every time this message occurred, a reboot would show one or more drives
missing in the BIOS scan.  I would open the case, jiggle some wires,
reboot again, and the drives would be back.  Since I've replaced the
supply so that I have many more connectors (and four splitters), it seems
to now be reliable (though it needs to run a bit longer to be sure).

Anyway, it seemed to me like the problem was triggered by hardware
issues, but maybe not.  Both cases should be handled gracefully, but
currently don't seem to be.

Simon-

[        Simon Kirby        ][        Network Operations        ]
[     sim@netnation.com     ][     NetNation Communications     ]
[  Opinions expressed are not necessarily those of my employer. ]
