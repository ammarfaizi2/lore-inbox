Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292538AbSCDRGz>; Mon, 4 Mar 2002 12:06:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292535AbSCDRGs>; Mon, 4 Mar 2002 12:06:48 -0500
Received: from klee.iskp.uni-bonn.de ([131.220.220.7]:19727 "EHLO
	klee.iskp.uni-bonn.de") by vger.kernel.org with ESMTP
	id <S292536AbSCDRG1> convert rfc822-to-8bit; Mon, 4 Mar 2002 12:06:27 -0500
Message-Id: <200203041706.g24H6Kv25543@klee.iskp.uni-bonn.de>
Content-Type: text/plain; charset=US-ASCII
From: Harald van Pee <pee@iskp.uni-bonn.de>
Organization: Uni-Bonn
To: linux-kernel@vger.kernel.org
Subject: 3Ware Hard Bus Hang 2.4.18 > 220 MB/S
Date: Mon, 4 Mar 2002 18:06:20 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

because I am planning to buy a very similar system, I would like to know:
- is this problem solved in the meantime?
- does it also occure with older kernels (2.4.16, 2.2.16) or older firmware 
(and smaler disks)?
- is it only a problem of high transfer rates and does not occure on lower ~ 
150 MB/sec or 30 MB/sec?

Thanks for your help
Harald

On Wed, Feb 27, 2002 at 10:25:45AM -0700, Jeff V. Merkey wrote:
>
More info.  I put in some trace code to determine how many io buffer
heads were being fed to each adapter.  When the number of bh's reaches
numbers above 4244+- buffer heads outstanding at one time, then I see the
cards lockup.
Jeff
>
>
> Running 4 3Ware 7810 Adapters with the updated 48 bit LBA firmware
> for the 78110, and attached to 8 Maxtor 160 GB hard disks on each card
> (32 drives total) striping Raid 0m across 5.6 terabytes of disk, I am
> seeing about 216-224 MB/S total throughput on writes to local
> arrays on 2.4.18. 
>
> The system is also running an Intel Gigabit Ethernet Card at
> 116-122 MB/S with full network traffic and writing this traffic to
> the 3Ware arrays.  All this hardware is running on a Serverworks
> HE chipset with a SuperMicro motherboard and dual 933 Mhz PIII
> processors.
>
> After running for about 3 hours, the system will hard hang and die. 
> Using debugging tools, I have isolated to the hang to the 3Ware
> adapters.  If I remove all but a single 3Ware adapter, the system will
> run reliably for days at these data rates.  The moment I add more
> than one 3Ware 7810 adapter, the system will lock up.  Recent testing
> reveals that the hang is in the 3Ware card itself (all the LEDs go
> on at once and stay on).  Attempts by the system to reset the adapter
> fail until the system is power cycled. 
>
> 3Ware dfriver version is .16 from the 2.4.18 tree.  Firmware is the 48 bit
> LBA version. 
>
> Please advise. 
>
> Jeff
