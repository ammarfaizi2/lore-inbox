Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422945AbWBCU5z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422945AbWBCU5z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 15:57:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422959AbWBCU5z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 15:57:55 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:60698 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1422945AbWBCU5x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 15:57:53 -0500
Message-ID: <43E3C39F.3040407@cfl.rr.com>
Date: Fri, 03 Feb 2006 15:57:03 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Helge Hafting <helge.hafting@broadpark.no>
CC: linux-kernel@vger.kernel.org
Subject: Re: Unable to read DVDs - what could be wrong?
References: <43E3C0A4.2080009@broadpark.no>
In-Reply-To: <43E3C0A4.2080009@broadpark.no>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Feb 2006 20:58:28.0754 (UTC) FILETIME=[95447F20:01C62904]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14245.000
X-TM-AS-Result: No--26.000000-5.000000-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You will need to do some troubleshooting to see if it looks like a 
software or hardware problem, i.e. plug the drive into another computer 
and/or OS and see if those work.  If it doesn't work anywhere with dvd 
media, it is entirely possible that the blue laser in the drive has 
died, and you will need to follow the manufacturer's technical support 
system and RMA process.  I recently had a DVD combo drive blow out its 
red laser so it would recognize dvd media just fine, but any and all cd 
media it would report that there was no disc in the drive. 

In any case, this mailing list isn't really a general support forum so 
you should look elsewhere unless you have reason to believe it is a 
problem in the linux kernel. 

Helge Hafting wrote:
> (Using kernel 2.6.16rc2 on amd64)
>
> I have this dvd writer:
> hda: PLEXTOR DVDR PX-712A, ATAPI CD/DVD-ROM drive
>
> It works well for reading and burning CDs, but it seem to be unable to
> use DVDs.
>
> I tried to mount a dvd, and got "No medium found".
> cat /dev/hda also got that message, so it can't be a missing fs driver.
>
> I only have one data dvd - it could theoretically be broken.
> But attempts to play movies are equally fruitless, and I know those 
> works.
>
> Booting with a dvd in the drive gives me this in dmesg:
>
> VP_IDE: chipset revision 6
> VP_IDE: not 100% native mode: will probe irqs later
> VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1
>     ide0: BM-DMA at 0xb400-0xb407, BIOS settings: hda:DMA, hdb:pio
> Probing IDE interface ide0...
> hda: PLEXTOR DVDR PX-712A, ATAPI CD/DVD-ROM drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> hda: ATAPI 94X DVD-ROM DVD-R CD-R/RW drive, 8192kB Cache, UDMA(33)
> Uniform CD-ROM driver Revision: 3.20
> hda: packet command error: status=0x51 { DriveReady SeekComplete Error }
> hda: packet command error: error=0x44 { AbortedCommand 
> LastFailedSense=0x04 }
> ide: failed opcode was: unknown
> ATAPI device hda:
>   Error: Hardware error -- (Sense key=0x04)
>   Tracking servo failure -- (asc=0x09, ascq=0x01)
>   The failed "Read Cd/Dvd Capacity" packet command was:
>   "25 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 "
>
> I have upgraded the device from firmware 1.01 to the latest which is 
> 1.07.  That and a cold boot changed nothing.
>
> Am I doing something wrong/stupid here?  Strange if it is broken,
> I haven't used it that much and it is flawless with CDs.
>
> Helge Hafting
>

