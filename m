Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310139AbSCAJmL>; Fri, 1 Mar 2002 04:42:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310420AbSCAJkX>; Fri, 1 Mar 2002 04:40:23 -0500
Received: from [195.63.194.11] ([195.63.194.11]:60936 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S310419AbSCAJem>; Fri, 1 Mar 2002 04:34:42 -0500
Message-ID: <3C7F4AFC.4050308@evision-ventures.com>
Date: Fri, 01 Mar 2002 10:33:48 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Kristopher Kersey <augustus@linuxhardware.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Kernel Panics on IDE Initialization
In-Reply-To: <Pine.LNX.4.33.0202282248340.21789-200000@penguin.linuxhardware.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kristopher Kersey wrote:
> Still panics at initialization.  I have attached the /proc/pci and lspci
> output.  This is for the SOYO board.  I will see about getting the ABIT
> board information.
> 
> Kris
> 
> On Fri, 1 Mar 2002, Alan Cox wrote:
> 
> 
>>>On two seperate motherboards that I have been testing, the ABIT
>>>KR7A-RAID and the SOYO FIRE DRAGON, 2.4 kernels panic on boot up during
>>>IDE initialization.  I don't really know how to track down the problem but
>>>now that I've seen it on two boards I'm a bit worried.  This does not
>>>happen with 2.2 kernels so it is 2.4 specific.  I have tested with 2.4.17
>>>and 2.4.18 pre releases.  I will try to field any questions to solve the
>>>
>>Try 2.4.18 proper and 2.4.18-ac2 - we fixed at least one oops caused by
>>controllers and mishandling of new revisions not in our tables. If it
>>still fails send me the pci data for them
>>
>>
>>
>>------------------------------------------------------------------------
>>
>>PCI devices found:
>>  Bus  0, device   0, function  0:
>>    Host bridge: Intel Unknown device (rev 4).
>>      Vendor id=8086. Device id=1a30.
>>      Fast devsel.  Fast back-to-back capable.  Master Capable.  No bursts.  
>>      Prefetchable 32 bit memory at 0xe0000000 [0xe0000008].
>>  Bus  0, device   1, function  0:
>>    PCI bridge: Intel Unknown device (rev 4).
>>      Vendor id=8086. Device id=1a31.
>>      Fast devsel.  Fast back-to-back capable.  Master Capable.  Latency=64.  Min Gnt=14.
>>  Bus  0, device  30, function  0:
>>    PCI bridge: Intel Unknown device (rev 5).
>>      Vendor id=8086. Device id=244e.
>>      Fast devsel.  Fast back-to-back capable.  Master Capable.  No bursts.  Min Gnt=6.
>>  Bus  0, device  31, function  0:
>>    ISA bridge: Intel Unknown device (rev 5).
>>      Vendor id=8086. Device id=2440.
>>      Medium devsel.  Fast back-to-back capable.  Master Capable.  No bursts.  
>>  Bus  0, device  31, function  1:
>>    IDE interface: Intel Unknown device (rev 5).
>>      Vendor id=8086. Device id=244b.
>>      Medium devsel.  Fast back-to-back capable.  Master Capable.  No bursts.  
>>      I/O at 0xf000 [0xf001].
>>  Bus  0, device  31, function  2:
>>    USB Controller: Intel Unknown device (rev 5).
>>      Vendor id=8086. Device id=2442.
>>      Medium devsel.  Fast back-to-back capable.  IRQ 11.  Master Capable.  No bursts.  
>>      I/O at 0xb000 [0xb001].
>>  Bus  0, device  31, function  3:
>>    SM Bus: Intel Unknown device (rev 5).
>>      Vendor id=8086. Device id=2443.
>>      Medium devsel.  Fast back-to-back capable.  IRQ 10.  
>>      I/O at 0x5000 [0x5001].
>>  Bus  0, device  31, function  4:
>>    USB Controller: Intel Unknown device (rev 5).
>>      Vendor id=8086. Device id=2444.
>>      Medium devsel.  Fast back-to-back capable.  IRQ 9.  Master Capable.  No bursts.  
>>      I/O at 0xb800 [0xb801].
>>  Bus  1, device   0, function  0:
>>    VGA compatible controller: NVidia Unknown device (rev 163).
>>      Vendor id=10de. Device id=201.
>>      Medium devsel.  Fast back-to-back capable.  IRQ 12.  Master Capable.  Latency=32.  Min Gnt=5.Max Lat=1.
>>      Non-prefetchable 32 bit memory at 0xec000000 [0xec000000].
>>      Prefetchable 32 bit memory at 0xe4000000 [0xe4000008].
>>      Prefetchable 32 bit memory at 0xe8000000 [0xe8000008].
>>  Bus  2, device   6, function  0:
>>    RAID storage controller: Triones Technologies, Inc. Unknown device (rev 5).
>>      Vendor id=1103. Device id=4.
>>      Medium devsel.  IRQ 11.  Master Capable.  Latency=64.  Min Gnt=8.Max Lat=8.
>>      I/O at 0x9000 [0x9001].
>>      I/O at 0x9400 [0x9401].
>>      I/O at 0x9800 [0x9801].
>>      I/O at 0x9c00 [0x9c01].
>>      I/O at 0xa000 [0xa001].
>>  Bus  2, device   7, function  0:
>>    Multimedia audio controller: Unknown vendor Unknown device (rev 16).
>>      Vendor id=13f6. Device id=111.
>>      Medium devsel.  IRQ 5.  Master Capable.  Latency=32.  Min Gnt=2.Max Lat=24.
>>      I/O at 0xa400 [0xa401].
>>  Bus  2, device   8, function  0:
>>    Ethernet controller: Intel Unknown device (rev 3).
>>      Vendor id=8086. Device id=2449.
>>      Medium devsel.  Fast back-to-back capable.  IRQ 10.  Master Capable.  Latency=32.  Min Gnt=8.Max Lat=56.
>>      Non-prefetchable 32 bit memory at 0xef005000 [0xef005000].
>>      I/O at 0xa800 [0xa801].
>>  Bus  2, device   9, function  0:
>>    FireWire (IEEE 1394): Texas Instruments Unknown device (rev 0).
>>      Vendor id=104c. Device id=8023.
>>      Medium devsel.  IRQ 9.  Master Capable.  Latency=32.  Min Gnt=2.Max Lat=4.
>>      Non-prefetchable 32 bit memory at 0xef004000 [0xef004000].
>>      Non-prefetchable 32 bit memory at 0xef000000 [0xef000000].
>>
>>	
>>	
>>00:00.0 Host bridge: Intel Corporation: Unknown device 1a30 (rev 04)
>>00:01.0 PCI bridge: Intel Corporation: Unknown device 1a31 (rev 04)
>>00:1e.0 PCI bridge: Intel Corporation: Unknown device 244e (rev 05)
>>00:1f.0 ISA bridge: Intel Corporation: Unknown device 2440 (rev 05)
>>00:1f.1 IDE interface: Intel Corporation: Unknown device 244b (rev 05)

Please add this device ID to the abnormally long list in ide-pci.c and
your chances may increase.

>>00:1f.2 USB Controller: Intel Corporation: Unknown device 2442 (rev 05)
>>00:1f.3 SMBus: Intel Corporation: Unknown device 2443 (rev 05)
>>00:1f.4 USB Controller: Intel Corporation: Unknown device 2444 (rev 05)
>>01:00.0 VGA compatible controller: nVidia Corporation: Unknown device 0201 (rev a3)
>>02:06.0 RAID bus controller: Triones Technologies, Inc. HPT366 (rev 05)
>>02:07.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
>>02:08.0 Ethernet controller: Intel Corporation: Unknown device 2449 (rev 03)
>>02:09.0 FireWire (IEEE 1394): Texas Instruments: Unknown device 8023
>>



-- 
- phone: +49 214 8656 283
- job:   eVision-Ventures AG, LEV .de (MY OPINIONS ARE MY OWN!)
- langs: de_DE.ISO8859-1, en_US, pl_PL.ISO8859-2, last ressort: ru_RU.KOI8-R

