Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129257AbQLLUyg>; Tue, 12 Dec 2000 15:54:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129210AbQLLUy0>; Tue, 12 Dec 2000 15:54:26 -0500
Received: from pnendick.cpe.dsl.enteract.com ([216.80.39.125]:773 "EHLO
	thefunk.org") by vger.kernel.org with ESMTP id <S129257AbQLLUyJ>;
	Tue, 12 Dec 2000 15:54:09 -0500
Date: Mon, 11 Dec 2000 14:23:16 -0600
From: " Paul C. Nendick " <pauly@enteract.com>
To: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.16 SMP: mtrr errors
Message-ID: <20001211142316.A1020@thefunk.org>
In-Reply-To: <20001211140029.A828@thefunk.org> <Pine.LNX.4.10.10012121511190.28197-100000@coffee.psychology.mcmaster.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10012121511190.28197-100000@coffee.psychology.mcmaster.ca>; from hahn@coffee.psychology.mcmaster.ca on Tue, Dec 12, 2000 at 03:14:22PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

See my answers inline below.  /paul

Mark Hahn (hahn@coffee.psychology.mcmaster.ca) said:

> > kernel: mtrr: base(0xd4000000) is not aligned on a size(0x1800000) boundary
> 
> X is trying to set an mtrr for the framebuffer.  the odd thing
> is that its trying to set a 24M mtrr, which is pretty strange.
> what does /proc/pci look like for the G450?
> 

% cat /proc/pci
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: VIA Technologies Unknown device (rev 196).
      Vendor id=1106. Device id=691.
      Medium devsel.  Master Capable.  No bursts.  
      Prefetchable 32 bit memory at 0xd0000000 [0xd0000008].
  Bus  0, device   1, function  0:
    PCI bridge: VIA Technologies VT 82C598 Apollo MVP3 AGP (rev 0).
      Medium devsel.  Master Capable.  No bursts.  Min Gnt=12.
  Bus  0, device   7, function  0:
    ISA bridge: VIA Technologies VT 82C596 Apollo Pro (rev 35).
      Medium devsel.  Master Capable.  No bursts.  
  Bus  0, device   7, function  1:
    IDE interface: VIA Technologies VT 82C586 Apollo IDE (rev 16).
      Medium devsel.  Fast back-to-back capable.  Master Capable.  Latency=32.  
      I/O at 0xe000 [0xe001].
  Bus  0, device   7, function  2:
    USB Controller: VIA Technologies VT 82C586 Apollo USB (rev 17).
      Medium devsel.  IRQ 9.  Master Capable.  Latency=32.  
      I/O at 0xe400 [0xe401].
  Bus  0, device   7, function  3:
    Host bridge: VIA Technologies Unknown device (rev 48).
      Vendor id=1106. Device id=3050.
      Medium devsel.  Fast back-to-back capable.  
  Bus  0, device  17, function  0:
    Multimedia audio controller: Ensoniq AudioPCI (rev 0).
      Slow devsel.  IRQ 9.  Master Capable.  Latency=32.  Min Gnt=12.Max Lat=128.
      I/O at 0xe800 [0xe801].
  Bus  0, device  18, function  0:
    Ethernet controller: Intel 82557 (rev 8).
      Medium devsel.  Fast back-to-back capable.  IRQ 11.  Master Capable.  Latency=32.  Min Gnt=8.Max Lat=56.
      Non-prefetchable 32 bit memory at 0xda100000 [0xda100000].
      I/O at 0xec00 [0xec01].
      Non-prefetchable 32 bit memory at 0xda000000 [0xda000000].
  Bus  1, device   0, function  0:
    VGA compatible controller: Matrox Unknown device (rev 130).
      Vendor id=102b. Device id=525.
      Medium devsel.  Fast back-to-back capable.  IRQ 10.  Master Capable.  Latency=64.  Min Gnt=16.Max Lat=32.
      Prefetchable 32 bit memory at 0xd4000000 [0xd4000008].
      Non-prefetchable 32 bit memory at 0xd6000000 [0xd6000000].
      Non-prefetchable 32 bit memory at 0xd7000000 [0xd7000000].



> also, how do you like the G450?

My first impressions of the g450 are spectacular.  I know it's not supposed
to be as fast as the dual Nvidia offerings, but I don't play games and Matrox
has always been tops when it comes to text appearance.  It's fast as can be
driving two monitors at 1600x1200 and not too expensive to boot.  I like it.


> > I would like to know what, if anything, is wrong and what I can do about it.
> 
> worst case is that X doesn't get to set the mtrr it wants.
> this may have some performance effect, but no functionality effect.

That's good enough for me!


> regards, mark hahn.
> 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
