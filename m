Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271669AbRH0IB3>; Mon, 27 Aug 2001 04:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271670AbRH0IBT>; Mon, 27 Aug 2001 04:01:19 -0400
Received: from 203-79-82-83.adsl-wns.paradise.net.nz ([203.79.82.83]:10982
	"HELO volcano.plumtree.co.nz") by vger.kernel.org with SMTP
	id <S271669AbRH0IA7>; Mon, 27 Aug 2001 04:00:59 -0400
Date: Mon, 27 Aug 2001 20:01:06 +1200
From: Nicholas Lee <nj.lee@plumtree.co.nz>
To: linux-kernel@vger.kernel.org
Subject: Crashing with Abit KT7, 2.2.19+ide patches
Message-ID: <20010827200106.A26175@cone.kiwa.co.nz>
Mail-Followup-To: Nicholas Lee <nj.lee@plumtree.co.nz>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Are there any known issues with 2.2.19+ide patchs and the Abit KT7?


[nic@hoppa:~] cat /proc/ide/drivers
ide-cdrom version 4.58
ide-disk version 1.09
[nic@hoppa:~] uname -a
Linux hoppa 2.2.19 #2 Thu Aug 16 16:28:31 NZST 2001 i686 unknown
[nic@hoppa:~] cat /proc/ide/hda/model
ST320420A
[nic@hoppa:~] dmesg | grep -i DMA
VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci00:07.1
    ide0: BM-DMA at 0xec00-0xec07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xec08-0xec0f, BIOS settings: hdc:DMA, hdd:pio
hda: ST320420A, 19458MB w/2048kB Cache, CHS=2480/255/63, UDMA(66)
hdc: ATAPI 48X CD-ROM drive, 120kB Cache, UDMA(33)

Aug 26 13:59:05 hoppa kernel: hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Aug 26 13:59:05 hoppa kernel: hda: dma_intr: error=0x84 { DriveStatusError BadCRC }

[nic@hoppa:~] sudo hdparm -v /dev/hda

/dev/hda:
 multcount    =  0 (off)
 I/O support  =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 2480/255/63, sectors = 39851760, start = 0


Was running 2.2.18pre21/ prior and still getting these errors, but now
I've had two HDD crashes in the last week.


I just upgraded this system from 2.2.18pre21 tO 2.2.19+ide patches in
the last two weeks and its become rather flaky.


I'd had two HDD crashes in the last week, none where the system was any
all load. 

This is rather disquieting as linux is usually rock stable in those
situation.

The system basically freezes and the console disappears bus reset
messages, which aren't saved to the syslog.  On a button-reset the
Primary Master IDE HDD (hda) just doesn't exist (for the bios) and boot
up.  A power-cycle is required to get the system back again.


I didn't have a crash issue with this system prior with 2.2.18pre21.
Although I have also added a Dlink 4-port NIC and the system is doing
some IPSec that it wasn't doing before.

Is this hardware that's just gone flaky?  I'm certainly not trusting VIA
much any more, and Seagate are definitely way off my purchase list.


PS: I'm not subscribed, please CC:


Thanks,

-- 
Nicholas Lee - nj.lee at plumtree.co dot nz, somewhere on the fish Maui caught.

                         Quixotic Eccentricity

