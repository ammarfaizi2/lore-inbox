Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261386AbRE2O3p>; Tue, 29 May 2001 10:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261434AbRE2O3e>; Tue, 29 May 2001 10:29:34 -0400
Received: from smtp6.mindspring.com ([207.69.200.110]:54827 "EHLO
	smtp6.mindspring.com") by vger.kernel.org with ESMTP
	id <S261386AbRE2O31>; Tue, 29 May 2001 10:29:27 -0400
From: sduchene@mindspring.com
Date: Tue, 29 May 2001 10:29:20 -0400
To: linux-kernel@vger.kernel.org
Cc: Bakonyi Ferenc <fero@drama.obuda.kando.hu>,
        Louis Garcia <louisg00@bellsouth.net>
Subject: console colors messed up with 2.4.X Rivafb driver
Message-ID: <20010529102920.H790@mug.hdqt.valinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a Riva128 based video card in a older SMP P-Pro system and with all
of the lastest 2.4 series of kernels (mostly the ac stuff) I have screwy colors
on the console (the penguin boot logos are shades of blue) and initially when
I start X (XFree86 4.0.3) the colors are very dark until I switch to a console
and back again. Once I switch to a console and back to X things are fine in
X. I noticed a reply to a note from Louis Garcia <louisg00@bellsouth.net> by
Bakonyi Ferenc <fero@drama.obuda.kando.hu> with some info about TNT cards
expecting 8 bit verses 6 bit color registers. Bakonyi indicated that the console
colors should be correct with Rivafb 0.9.2 and above but with the 2.4.5-ac3
kernel the boot messages indicate:

rivafb: RIVA MTRR set to ON
Console: switching to colour frame buffer device 160x64
rivafb: PCI nVidia NV3 framebuffer ver 0.9.2a (RIVA-128, 4MB @ 0xEF000000)

My /proc/pci entry says:

 Bus  0, device  15, function  0:
    VGA compatible controller: NVidia / SGS Thomson (Joint Venture) Riva128 (rev 16).
      IRQ 19.
      Master Capable.  Latency=64.  Min Gnt=3.Max Lat=1.
      Non-prefetchable 32 bit memory at 0xee000000 [0xeeffffff].
      Prefetchable 32 bit memory at 0xef000000 [0xefffffff].

and even at 0.9.2a colors are still screwy on the console both before and after starting
the Xserver.

The fbset output on this system says:

mode "1280x1024-74"
    # D: 135.007 MHz, H: 78.859 kHz, V: 74.116 Hz
    geometry 1280 1024 1280 1024 16
    timings 7407 256 32 34 3 144 3
    accel true
    rgba 5/11,6/5,5/0,0/0
endmode

The same thing still occurs if I set the color depth to 8 bit.

This is a pci card with 4Mb of video memory. I also have a AMD K6 system with a 16Mb
AGP TNT2 card and this does not happen on that machine.

BTW, why is the mtrr for the Riva set to 0M ???
-- 
Steven A. DuChene	sad@valinux.com
			sduchene@mindspring.com

	http://www.mindspring.com/~sduchene/
