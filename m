Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263487AbTJ0TP3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 14:15:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263488AbTJ0TP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 14:15:29 -0500
Received: from bay7-f103.bay7.hotmail.com ([64.4.11.103]:40968 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S263487AbTJ0TPT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 14:15:19 -0500
X-Originating-IP: [192.189.172.32]
X-Originating-Email: [ear22@hotmail.com]
From: "Hakona Spect" <ear22@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: 4Gb memory?
Date: Mon, 27 Oct 2003 14:15:17 -0500
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY7-F103askCcBONAA0000a470@hotmail.com>
X-OriginalArrivalTime: 27 Oct 2003 19:15:17.0234 (UTC) FILETIME=[A7F90520:01C39CBE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I just installed 4GB memory to my system. In BIOS it shows up all 8x512M 
chips. But after boot it shows:

$ free
             total       used       free     shared    buffers     cached
Mem:       3753328     566800    3186528          0      96040     189960
-/+ buffers/cache:     280800    3472528
Swap:      2096440          0    2096440

$dmesg
Linux version 2.4.22 (root) (gcc version 3.2.2 20030222 (Red Hat Linux 
3.2.2-5)) #1 SMP Mon Oct 27 12:44:16 EST 2003
BIOS-provided physical RAM map:
BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
BIOS-e820: 0000000000100000 - 000000007ff77000 (usable)
BIOS-e820: 000000007ff77000 - 000000007ff79000 (ACPI NVS)
BIOS-e820: 000000007ff79000 - 00000000e7f77000 (usable)
BIOS-e820: 00000000e7f79000 - 00000000e8000000 (reserved)
BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
user-defined physical RAM map:
user: 0000000000000000 - 00000000000a0000 (usable)
user: 00000000000f0000 - 0000000000100000 (reserved)
user: 0000000000100000 - 000000007ff77000 (usable)
user: 000000007ff77000 - 000000007ff79000 (ACPI NVS)
user: 000000007ff79000 - 00000000e7f77000 (usable)
user: 00000000e7f79000 - 00000000e8000000 (reserved)
user: 00000000fec00000 - 00000000fec10000 (reserved)
user: 00000000fee00000 - 00000000fee10000 (reserved)
user: 00000000ffb00000 - 0000000100000000 (reserved)
2815MB HIGHMEM available.
896MB LOWMEM available.

$ cat /proc/meminfo
        total:    used:    free:  shared: buffers:  cached:
Mem:  3843407872 580702208 3262705664        0 98418688 194662400
Swap: 2146754560        0 2146754560
MemTotal:      3753328 kB
MemFree:       3186236 kB
MemShared:           0 kB
Buffers:         96112 kB
Cached:         190100 kB
SwapCached:          0 kB
Active:         117228 kB
Inactive:       264336 kB
HighTotal:     2883028 kB
HighFree:      2595896 kB
LowTotal:       870300 kB
LowFree:        590340 kB
SwapTotal:     2096440 kB
SwapFree:      2096440 kB


Does this look right? why it is 375328 KB instead of 4294967296 kB? I 
compiled with 4GB mem. I did try 64GB version but after boot I got "pc_keyb 
jammed" message and could not use keyboard at all.

Also I have another problem. My harddrive is: hda: WDC WD1200JB-75CRA0, ATA 
DISK drive,
hdparm -i /dev/hda
/dev/hda:

Model=WDC WD1200JB-75CRA0, FwRev=16.06V16, SerialNo=WD-WMA8C2065737
Config={ HardSect NotMFM HdSw>15uSec SpinMotCtl Fixed DTR>5Mbs FmtGapReq }
RawCHS=16383/16/63, TrkSize=57600, SectSize=600, ECCbytes=40
BuffType=DualPortCache, BuffSize=8192kB, MaxMultSect=16, MultSect=16
CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=234375000
IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
PIO modes:  pio0 pio1 pio2 pio3 pio4
DMA modes:  mdma0 mdma1 mdma2
UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5
AdvancedPM=no WriteCache=enabled
Drive conforms to: device does not report version:  1 2 3 4 5

If I idle the machine for a period of time (say over weekend), then on 
screen it says:
dma_timer_expiry
dma status == 0x21
hda: error waiting for DMA
Then the machine completely freeze. Is that some bug already known? Thanks!

_________________________________________________________________
Want to check if your PC is virus-infected?  Get a FREE computer virus scan 
online from McAfee.    
http://clinic.mcafee.com/clinic/ibuy/campaign.asp?cid=3963

