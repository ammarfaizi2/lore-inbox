Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281095AbRKOVxj>; Thu, 15 Nov 2001 16:53:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281094AbRKOVxb>; Thu, 15 Nov 2001 16:53:31 -0500
Received: from paloma17.e0k.nbg-hannover.de ([62.159.219.17]:20661 "HELO
	paloma17.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S280974AbRKOVxW>; Thu, 15 Nov 2001 16:53:22 -0500
Content-Type: text/plain;
  charset="iso-8859-15"
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Athlon SMP blues - kernels 2.4.[9 13 15-pre4]
Date: Thu, 15 Nov 2001 22:53:06 +0100
X-Mailer: KMail [version 1.3.1]
Cc: "Paul G. Allen" <pgallen@randomlogic.com>,
        Alastair Stevens <alastair.stevens@mrc-bsu.cam.ac.uk>,
        Andreas =?iso-8859-15?q?J=E4ger?= <aj@suse.de>,
        "Martin Peters" <mpet@bigfoot.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20011115215325Z280974-17408+14822@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul G. Allen wrote:
>
> Long thread, including a some misinformation. 
>
> I have a Tyan K7 Thunder with dual 1.4GHz Thunderbirds. It took me a
> week to get it working, and was the initial reason I joined this list. It
> seems I had one of the few Thunders on the planet that was trying to run
> Linux, condidering I bought the board almost as soon as they hit the stores 
> :). 

As I am on the AMD Athlon train since the 26. August 1999 (not MP of course 
:-) and do some AMD/Linux consulting for my local dealer (yes, I need some 
cash from time to time) I "only" have some small additions to Allens post. I 
"know" him as one of the _very_ first AMD MP users out there.

> First of all, all Athlons support SMP. Neither AMD nor MoBo vendors
> support SMP using non-MP/XP Athlons (I've asked a real person on the
> phone). I selected dual 1.4GHz Thunderbirds because they were slightly
> faster than 1.2GHZ MP chips, less money, and I already had one at the time
> (from an A7V133 system that kept crashing). XP processors are faster, lower
> power versions of the MP,

This is ONLY valid for the slower (1.0 and 1.2 GHz) MP processors.
Since there are MP 1400+, MP 1600+ and MP 1800+ CPUs out they are exactly 
the same as there XP counter parts. Apart from the circumstance that the MP 
versions are certified by AMD for SMP use. You shouldn't be surprised if AMD 
ship the MP 1900+ (the XP 1900+ is still available) and the AMD Athlon MP 
2000+ (the XP 2000+ is announced for Q1 2002) , soon.

> so of course they support SMP. They all use the same EV6 bus
> - a point-to-point bus taken from the DEC Alpha processor and capable of
> up to 400MHz operation and twice the bandwidth in SMP configurations per
> MHz as the Intel bus. 
>
> Second, kernels before 2.4.8 did not work worth a damn. As I recall, RH 7.1
> hardly installed, let alone booted. The MP chipset was very new (and buggy
> - as they all seem to be) and not all the support code was there yet when
> these kernels came out. The BIOS was even newer and only recently do the
> BIOS upgrades have decent AGP and other chipset support in them. The kernel
> I finally got working in a stable way is 2.4.9ac10 with some minor tweaks
> to make it friendlier with my GeForce 3, the 760MP chipset, and IDE. I also
> tweaked the nVidia driver because it couldn't recognize or work properly
> with the 760MP AGP harware. Before I compiled my own kernel, I had no end
> to problems with lock-ups, often during compile time. 
>
> The only problem I still have is IDE. I can not run the IDE drive using DMA
> or the system will hang HARD, usually with the drive access light on. Even
> with DMA disabled it might hang under high IDE usage. I will replace the
> IDE drive with a SCSI drive soon as the SCSI interface works perfectly and
> very fast. Early MP chipsets had AGP and DMA hardware bugs, but according
> to AMD errata, the revision in my MoBo should not have these bugs (that
> doesn't mean it doesn't have them though). 
>
> In addition, when compiling my kernel, I made sure I included the IDE and
> SCSI drivers in the kernel, NOT as modules. This avoids having to make a
> new initrd.img every time I made a new kernel (and I made many of them, and
> have 6 different ones still on the machine :) and solved the issue of not
> mounting root.
>
> Hope this helps. 
>
> PGA 

Let me close with some remarks about temperature and heat.

Most if not all current mainboards (chipsets) for the Athlon/Duron better say 
the combination of the chipset with the Athlon (Duron?) have some "wake up" 
problems with clock speeds above 1.0 (1.2?) GHz.

So in most (all?, the Tyan, too?) BIOSis the Idle and STPGNT (BUS GRANT) 
modes are _DISABLED_.  ==> very hot CPU's
An AMD 1800+ XP should run around 40-50°C and not much more (during Idle I 
saw the 1500+ XP (single) around 30°C).

Even the Linux Idle loop isn't enough if I understand that right.
Under Windows (sorry ;-) you should use VCool (OSS, 
http://www.naggelgames.de/vcool/). There exists a version for Linux and a 
patch for the Linux kernel (latest for 2.4.13) which should do the trick.

What the author badly needs is some support (datasheets) from AMD for the AMD 
750/760 and 762 (SMP). As the AMD 750 and 760 should fade out (the former is, 
now) it shouldn't harm any AMD rights?

Andreas can you help, here?

Regards,
	Dieter

Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
@home: Dieter.Nuetzel@hamburg.de
