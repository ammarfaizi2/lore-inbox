Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292773AbSCINee>; Sat, 9 Mar 2002 08:34:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292766AbSCINeZ>; Sat, 9 Mar 2002 08:34:25 -0500
Received: from [194.46.8.33] ([194.46.8.33]:54800 "EHLO angusbay.vnl.com")
	by vger.kernel.org with ESMTP id <S292761AbSCINeE>;
	Sat, 9 Mar 2002 08:34:04 -0500
Date: Sat, 9 Mar 2002 13:45:40 +0000
From: Dale Amon <amon@vnl.com>
To: linux-kernel@vger.kernel.org
Subject: Pentium mobo fails on upgrade from 2.2 to 2.4
Message-ID: <20020309134540.GZ13355@vnl.com>
Mail-Followup-To: Dale Amon <amon@vnl.com>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux, the choice of a GNU generation
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wonder if anyone has any ideas how I might dig
out what is going on. Here's the situation. I have
an old machine:

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 5
model           : 2
model name      : Pentium 75 - 200
stepping        : 12
cpu MHz         : 133.637
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : yes
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8
bogomips        : 266.24

with 

PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Intel 82437VX Triton II (rev 2).
      Medium devsel.  Master Capable.  Latency=32.  
  Bus  0, device   7, function  0:
    ISA bridge: Intel 82371SB PIIX3 ISA (rev 1).
      Medium devsel.  Fast back-to-back capable.  Master Capable.  No bursts.  
  Bus  0, device   7, function  1:
    IDE interface: Intel 82371SB PIIX3 IDE (rev 0).
      Medium devsel.  Fast back-to-back capable.  Master Capable.  Latency=32.  
      I/O at 0xf000 [0xf001].
  Bus  0, device  18, function  0:
    Ethernet controller: 3Com 3C905B 100bTX (rev 48).
      Medium devsel.  IRQ 10.  Master Capable.  Latency=32.  Min Gnt=10.Max Lat=10.
      I/O at 0x6000 [0x6001].
      Non-prefetchable 32 bit memory at 0xe0804000 [0xe0804000].
  Bus  0, device  19, function  0:
    VGA compatible controller: Matrox Millennium (rev 1).
      Medium devsel.  Fast back-to-back capable.  IRQ 11.  
      Non-prefetchable 32 bit memory at 0xe0800000 [0xe0800000].
      Prefetchable 32 bit memory at 0xe0000000 [0xe0000008].

It runs happily under 2.2.18. I've confirmed that I can
rebuild the existing kernel with the existing .config. It
boots fine.

I have so far failed to get a boot of any 2.4 kernel
on this box. I've tried 18,17 and 6. I've tried it with
a make oldconfig of the 2.2.18 as-is (well, plus the
IDE); I've done paired down configs; I've made it 
no-module. I've been running trials on the machine
as a background task for nearly a week with no joy.

Oh, yea, I've tried upgraded and downgraded binutils;
I've tried selecting 3 different processor types on
the 2.4.17 kernel build, including 586.

The biggest problem is I get no indication of what
is going wrong. The kernel loads... and I get chucked
back to a BIOS boot up screen.

The farthest I've gotten was with 2.4.6, which got so
far as to print one line from the booting kernel and
then lock up until I did a pushbutton RESET.

Advice on how to proceed would be much welcome. I've
run across some hard cases over the years, but at least
they gave me something to go on.

If any one is interested I can send the various .config
files, but I thought I'd not add clutter until someone
actually expresses and interest.

-- 
------------------------------------------------------
    Nuke bin Laden:           Dale Amon, CEO/MD
  improve the global          Islandone Society
     gene pool.               www.islandone.org
------------------------------------------------------
