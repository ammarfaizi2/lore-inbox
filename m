Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292542AbSCDRYg>; Mon, 4 Mar 2002 12:24:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292549AbSCDRY1>; Mon, 4 Mar 2002 12:24:27 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:21154 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S292542AbSCDRYM>; Mon, 4 Mar 2002 12:24:12 -0500
Date: Mon, 4 Mar 2002 10:38:47 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Harald van Pee <pee@iskp.uni-bonn.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 3Ware Hard Bus Hang 2.4.18 > 220 MB/S
Message-ID: <20020304103847.A31515@vger.timpanogas.org>
In-Reply-To: <200203041706.g24H6Kv25543@klee.iskp.uni-bonn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200203041706.g24H6Kv25543@klee.iskp.uni-bonn.de>; from pee@iskp.uni-bonn.de on Mon, Mar 04, 2002 at 06:06:20PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Problem seems specific to the SuperMicro motherboard + 3Ware.

Jeff

On Mon, Mar 04, 2002 at 06:06:20PM +0100, Harald van Pee wrote:
> Hi,
> 
> because I am planning to buy a very similar system, I would like to know:
> - is this problem solved in the meantime?
> - does it also occure with older kernels (2.4.16, 2.2.16) or older firmware 
> (and smaler disks)?
> - is it only a problem of high transfer rates and does not occure on lower ~ 
> 150 MB/sec or 30 MB/sec?
> 
> Thanks for your help
> Harald
> 
> On Wed, Feb 27, 2002 at 10:25:45AM -0700, Jeff V. Merkey wrote:
> >
> More info.  I put in some trace code to determine how many io buffer
> heads were being fed to each adapter.  When the number of bh's reaches
> numbers above 4244+- buffer heads outstanding at one time, then I see the
> cards lockup.
> Jeff
> >
> >
> > Running 4 3Ware 7810 Adapters with the updated 48 bit LBA firmware
> > for the 78110, and attached to 8 Maxtor 160 GB hard disks on each card
> > (32 drives total) striping Raid 0m across 5.6 terabytes of disk, I am
> > seeing about 216-224 MB/S total throughput on writes to local
> > arrays on 2.4.18. 
> >
> > The system is also running an Intel Gigabit Ethernet Card at
> > 116-122 MB/S with full network traffic and writing this traffic to
> > the 3Ware arrays.  All this hardware is running on a Serverworks
> > HE chipset with a SuperMicro motherboard and dual 933 Mhz PIII
> > processors.
> >
> > After running for about 3 hours, the system will hard hang and die. 
> > Using debugging tools, I have isolated to the hang to the 3Ware
> > adapters.  If I remove all but a single 3Ware adapter, the system will
> > run reliably for days at these data rates.  The moment I add more
> > than one 3Ware 7810 adapter, the system will lock up.  Recent testing
> > reveals that the hang is in the 3Ware card itself (all the LEDs go
> > on at once and stay on).  Attempts by the system to reset the adapter
> > fail until the system is power cycled. 
> >
> > 3Ware dfriver version is .16 from the 2.4.18 tree.  Firmware is the 48 bit
> > LBA version. 
> >
> > Please advise. 
> >
> > Jeff
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
