Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279903AbRKVPrq>; Thu, 22 Nov 2001 10:47:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279904AbRKVPrh>; Thu, 22 Nov 2001 10:47:37 -0500
Received: from news.heim1.tu-clausthal.de ([139.174.234.200]:25881 "EHLO
	neuemuenze.heim1.tu-clausthal.de") by vger.kernel.org with ESMTP
	id <S279903AbRKVPrW>; Thu, 22 Nov 2001 10:47:22 -0500
Date: Thu, 22 Nov 2001 16:47:21 +0100
From: Sven.Riedel@tu-clausthal.de
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.14 Oops during boot (KT133A Problem?)
Message-ID: <20011122164721.A10968@moog.heim1.tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Again, I did not see my mail make it to the linux-kernel mailing list.
Again my apologies if you receive this mail twice. Now, who is munching
the mail I'm sending to the list?]

On Tue, Nov 20, 2001 at 08:31:05AM +0900, nakai wrote:
> Excuse me, I had holidays.
We all need those :)

> May I ask you how to get /proc/pci ?
Well as I said in my original posting:
Sidenote: booting the exact same kernel from floppy (debian rescue with
kernels exchanged and booting with 'linux root=/dev/hda6') gives me a
rather unstable system for a short while (uptime usually < 6 hours before
oopsing).
Currently, the "unstable" attribute doesn't really seem to apply
anymore, I get uptimes >1 day at the moment. Maybe /dev/random likes me
better now...
Anyway, I boot from floppy, so I do get a somewhat useable system. It's
just very annoying, and I don't really trust things showing this sort of
behaviour (likes floppy, dislikes harddisk).

> Is there any kernel which can run ?
2.4.7 ran fine from floppy (rather stable, I had uptimes > 14 days),
2.4.14 seems to work semi-fine from floppy. Other kernels may or may not
boot from floppy, most oops before the bootscripts finish running. No
kernel likes to be booted from harddisk at the moment.

> Is it correctly hardware trouble or kernel trouble ?
Good question, since there is _no_ difference between the kernels that
boot from harddisk and those that boot from floppy (at least I did not
change anything). So what is different?
* Bootlocation/Bootsector/MBR 
  I doubt it, since linux booted fine off the very same harddisk before I 
  exchanged board and CPU, and lilo (nor kernel) complain when writing
  a new setup to the harddisks MBR.

* Speed
  The kernel will be loaded much slower from floppy than from harddisk.

* NOT Mainboard, CPU, RAM
  Don't change when I boot from floppy ;). Maybe memory is used in a
  different way when the kernel is loaded from floppy?
  I severely doubt there is a problem with the RAM, I already ran
  memcheck86 for several hours, put the speed down to 100MHz in the
  BIOS, and the RAM is the same I used in my previous hardware
  configuration and linux booted fine from harddisk then. 

* Interrupts Triggered
  Maybe I should try writing a kernel to a bootable CDROM and try to
  boot from that (my CDROM drive is attached to a SCSI Adapter, so if
  this causes the kernel to Oops as well, the chances that it's the IDE
  Controller interrupt requests is lessened).

* Lilo version
  I doubt this is the cause either, since the kernel has already been
  loaded and is executing.

I can't think of anything else that may be different between floppy and
harddisk boot. I guess it may be more of a kernel problem now than
hardware problem, since the KT133A patch made it into the kernel and
I've tested the other KT133A patch with no different results as well. 
Although with the x86 architecture, who can be sure? :)

Regs,
Sven

-- 
Sven Riedel                      sr@gimp.org
Osteroeder Str. 6 / App. 13      sven.riedel@tu-clausthal.de
38678 Clausthal                  "Call me bored, but don't call me boring."
                                 - Larry Wall 
