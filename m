Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131480AbRDPNRs>; Mon, 16 Apr 2001 09:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131481AbRDPNRi>; Mon, 16 Apr 2001 09:17:38 -0400
Received: from yoda.planetinternet.be ([195.95.30.146]:784 "EHLO
	yoda.planetinternet.be") by vger.kernel.org with ESMTP
	id <S131480AbRDPNR0>; Mon, 16 Apr 2001 09:17:26 -0400
Date: Mon, 16 Apr 2001 15:17:11 +0200
From: Kurt Roeckx <Q@ping.be>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Athlon problem report summary
Message-ID: <20010416151711.A711@ping.be>
In-Reply-To: <E14p894-00009E-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre2i
In-Reply-To: <E14p894-00009E-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 16, 2001 at 01:30:14PM +0100, Alan Cox wrote:
> 
> 2.  'My athlon box is fine until I am swapping' {and using DMA}
> 
> Compiler independant, CPU version independant. All victims have a VIA chipset.
> This one may be linked to the reported problems with VIA PCI. Two of the 
> reporters found disabling IDE DMA fixed this one

That's intresting.  I had no problem at all.

hda and hdc are using udma33 here.  hdb contains the swap, and
gets this error on boot:

hdb: Conner Peripherals 340MB - CP30344, ATA DISK drive
hdb: set_drive_speed_status: status=0x51 { DriveReady
SeekComplete Error }
hdb: set_drive_speed_status: error=0x04 { DriveStatusError }
ide0: Drive 1 didn't accept speed setting. Oh, well.
[...]
[same error message]
hdb: 670320 sectors (343 MB) w/64KiB Cache, CHS=665/16/63, DMA

hdparm -iv /dev/hdb output:

/dev/hdb:
 multcount    =  0 (off)
 I/O support  =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 665/16/63, sectors = 670320, start = 0

 Model=Conner Peripherals 340MB - CP30344, FwRev=6FT1.67, SerialNo=BQB2B7G
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
 RawCHS=665/16/63, TrkSize=40887, SectSize=649, ECCbytes=4
 BuffType=3(DualPortCache), BuffSize=64kB, MaxMultSect=64, MultSect=off
 DblWordIO=no, OldPIO=1, DMA=yes, OldDMA=1
 CurCHS=665/16/63, CurSects=980418570, LBA=no
 DMA modes: *mword0

Hope this helps.


Kurt

