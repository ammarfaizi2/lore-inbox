Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268640AbTBZFLD>; Wed, 26 Feb 2003 00:11:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268643AbTBZFLD>; Wed, 26 Feb 2003 00:11:03 -0500
Received: from lucidpixels.com ([66.45.37.187]:15369 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id <S268640AbTBZFLC>;
	Wed, 26 Feb 2003 00:11:02 -0500
Message-ID: <3E5C4ECD.7020806@lucidpixels.com>
Date: Wed, 26 Feb 2003 00:21:17 -0500
From: jpiszcz <jpiszcz@lucidpixels.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Question about DMA and cd burning.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was talking to a couple of friends who also run 2.4.x, they said they 
burn CD's all the time using DMA, and not PIO.

So I looked into the matter, apparently, the kernel sets my hd{b,c} 
(both Plextor 12/10/32A's) drives DMA to disabled.

[war@war war]$ dmesg | grep -i dma
Activating ISA DMA hang workarounds.
VP_IDE: VIA vt82c596b (rev 12) IDE UDMA66 controller on pci00:07.1
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:pio
hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=9729/255/63, UDMA(66)
hdb: DMA disabled
hdc: DMA disabled
[war@war war]$

[war@war war]$ lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo 
PRO133x] (rev 44)
00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo 
MVP3/Pro133x AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C596 ISA [Mobile South] 
(rev 12)
00:07.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus 
Master IDE (rev 06)
00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 08)
00:07.3 Host bridge: VIA Technologies, Inc. VT82C596 Power Management 
(rev 20)
00:10.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 07)
00:10.1 Input device controller: Creative Labs SB Live! MIDI/Game Port 
(rev 07)
00:11.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] 
(rev 30)
00:12.0 SCSI storage controller: Adaptec AHA-7850 (rev 03)
01:00.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo 3 (rev 01)
[war@war war]$

I even went further and tried:

append="ide-cd=ignore=hdb ide-cd=ignore=hdc"

In my lilo.conf, once again, no luck.

Can anyone offer any suggestions why others can burn CD's in DMA mode, 
yet the kernel keeps disabling DMA for my burners?

Please cc me as I am not subscribed to the list, thank you.


