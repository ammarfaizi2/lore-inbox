Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133053AbRDZBww>; Wed, 25 Apr 2001 21:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133055AbRDZBwn>; Wed, 25 Apr 2001 21:52:43 -0400
Received: from think.faceprint.com ([166.90.149.11]:20231 "EHLO
	think.faceprint.com") by vger.kernel.org with ESMTP
	id <S133053AbRDZBw3>; Wed, 25 Apr 2001 21:52:29 -0400
Message-ID: <3AE77F56.80770715@faceprint.com>
Date: Wed, 25 Apr 2001 21:52:22 -0400
From: Nathan Walp <faceprint@faceprint.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-ac14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: random reboots
In-Reply-To: <3AE5A762.675581E4@faceprint.com> <20010426033643.L1125@ppc.vc.cvut.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've gotten a lot more response to this than I'd ever dreamed, but I
figured out the problem on my own...

I have (had) one of those exhaust fans that fits into a PCI/ISA slot,
and it died.  Not only did it die, but it started creating heat of it's
own.  I don't think the video card adjacent to it appreciated this a
whole lot.  I removed the dead fan, and everything is back to normal, I
just need to go get a new fan to make myself feel better ;-)

The 1007 bios, and ac14 have been perfectly stable, so no worries about
either.

Thanks,
Nathan

Petr Vandrovec wrote:
> 
> On Tue, Apr 24, 2001 at 12:18:42PM -0400, Nathan Walp wrote:
> > I upgraded the BIOS on this Asus A7V sometime in the past week, but I
> > honestly don't remember when.  From 1005C to 1007.  This was released in
> > march, so I assumed it was pretty stable, but it could be the cause.
> > I'm going to go downgrade now, but is this more likely to be a kernel
> > bug, or a hardware bug/new bios bug?
> 
> No problem here. I'm using 1007 since its release in first half
> of March.
> 
> Linux version 2.4.3-ac12-amd (root@ppc) (gcc version 3.0 20010402 (Debian prerelease)) #1 Mon Apr 23 02:31:13 CEST 2001
> ...
> Kernel command line: BOOT_IMAGE=Linux ro root=2105 video=matrox:vesa:0x105,fv:85 devfs=nomount
> Initializing CPU#0
> Detected 1009.013 MHz processor.
> ...
> CPU: AMD Athlon(tm) Processor stepping 02
> Enabling fast FPU save and restore... done.
> ...
> apm: BIOS version 1.2 Flags 0x03 (Driver version 1.14)
> ...
> 
> Except that I got 'ide only func: 14' today with my Promise PDC20265
> (which looks strange to me - either all Intel, VIA and Promise have
> same bug in their UDMA hardware, or there is a bug in Linux IDE
> driver...) (I had to reboot because of kernel somehow believed that
> it read some garbage instead of MBR from hdg, so I could not run my
> repartitioning session, as I found no way to invalidate hdg kernel
> cache).
> But machine for sure does not spontaneously reboot. And I have
> enabled local apic in kernel configuration. All previous kernels
> were built with Debian's 2.95.3-something, ac12 was built with
> gcc-3.0, as I wanted to update anyway, and ac12 just gave me a reason.
>                                         Best regards,
>                                                 Petr Vandrovec
>                                                 vandrove@vc.cvut.cz
