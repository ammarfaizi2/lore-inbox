Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291948AbSB0RMm>; Wed, 27 Feb 2002 12:12:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292813AbSB0RM2>; Wed, 27 Feb 2002 12:12:28 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:31121 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S292116AbSB0RL7>; Wed, 27 Feb 2002 12:11:59 -0500
Date: Wed, 27 Feb 2002 10:25:45 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: linux-kernel@vger.kernel.org, jmerkey@timpanogas.org
Subject: 3Ware Hard Bus Hang 2.4.18 > 220 MB/S 
Message-ID: <20020227102545.B31524@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Running 4 3Ware 7810 Adapters with the updated 48 bit LBA firmware
for the 78110, and attached to 8 Maxtor 160 GB hard disks on each card
(32 drives total) striping Raid 0m across 5.6 terabytes of disk, I am
seeing about 216-224 MB/S total throughput on writes to local 
arrays on 2.4.18.  

The system is also running an Intel Gigabit Ethernet Card at 
116-122 MB/S with full network traffic and writing this traffic to 
the 3Ware arrays.  All this hardware is running on a Serverworks 
HE chipset with a SuperMicro motherboard and dual 933 Mhz PIII
processors.

After running for about 3 hours, the system will hard hang and die.  
Using debugging tools, I have isolated to the hang to the 3Ware 
adapters.  If I remove all but a single 3Ware adapter, the system will
run reliably for days at these data rates.  The moment I add more 
than one 3Ware 7810 adapter, the system will lock up.  Recent testing
reveals that the hang is in the 3Ware card itself (all the LEDs go 
on at once and stay on).  Attempts by the system to reset the adapter
fail until the system is power cycled.  

3Ware dfriver version is .16 from the 2.4.18 tree.  Firmware is the 48 bit
LBA version.  

Please advise.  

Jeff
