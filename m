Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317463AbSGXSgB>; Wed, 24 Jul 2002 14:36:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317468AbSGXSgB>; Wed, 24 Jul 2002 14:36:01 -0400
Received: from employees.nextframe.net ([212.169.100.200]:62193 "EHLO
	sexything.nextframe.net") by vger.kernel.org with ESMTP
	id <S317463AbSGXSgA>; Wed, 24 Jul 2002 14:36:00 -0400
Date: Wed, 24 Jul 2002 20:50:19 +0200
From: Morten Helgesen <morten.helgesen@nextframe.net>
To: Chris Snyder <csnyder@mvpsoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problems with Mylex DAC960P RAID controller
Message-ID: <20020724205019.A2356@sexything>
Reply-To: morten.helgesen@nextframe.net
References: <3D3ED215.3080900@mvpsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D3ED215.3080900@mvpsoft.com>
User-Agent: Mutt/1.3.22.1i
X-Editor: VIM - Vi IMproved 6.0
X-Keyboard: PFU Happy Hacking Keyboard
X-Operating-System: Slackware Linux (of course)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey, 

On Wed, Jul 24, 2002 at 12:13:09PM -0400, Chris Snyder wrote:
> I emailed this list a couple of weeks ago with problems I was having 
> with an Intergraph SMP server.  I ended up giving up with that box, and 
> built a new server with a 2 ghz Athlon, 1GB RAM, etc.  I kept the RAID 
> array, however, as it was the most expensive part of the old server, and 
> is still usable.  The array is three 9 gig IBM SCSI-2UW disks on a Mylex 
> DAC960P controller.  The controller was recently updated to the latest 
> firmware (2.73)

DAC960P ? I`ve got a box running 2.4.18 with a Mylex DAC960PTL1 card. The
box is rock solid. If my memory isn`t hosed, the correct name 
of the card is 'Mylex AccelRaid 250'.

> I'm having problems, however, trying to get the card to work.  Whenever 
> I try to insert the module for the card into my kernel, the system 
> completely hangs.  I tried this both with the kernel version that comes 
> with my distro CD, and 2.4.18, compiling it directly into the kernel 
> with the latter.  In both cases, it hanged when trying to load the 

I`ve got it compiled in.

> driver.  It will display the version information, but that's it.

The DAC960 driver is quite verbose - this is what I`ve got :

kernel: DAC960: ***** DAC960 RAID Driver Version 2.4.11 of 11 October 2001 *****
kernel: DAC960: Copyright 1998-2001 by Leonard N. Zubkoff <lnz@dandelion.com>
kernel: DAC960#0: Configuring Mylex DAC960PTL1 PCI RAID Controller
kernel: DAC960#0:   Firmware Version: 4.07-0-29, Channels: 1, Memory Size: 8MB
kernel: DAC960#0:   PCI Bus: 0, Device: 15, Function: 1, I/O Address: Unassigned
kernel: DAC960#0:   PCI Address: 0xD9000000 mapped at 0xE0800000, IRQ Channel: 11
kernel: DAC960#0:   Controller Queue Depth: 124, Maximum Blocks per Command: 128
kernel: DAC960#0:   Driver Queue Depth: 123, Scatter/Gather Limit: 33 of 33 Segments
kernel: DAC960#0:   Stripe Size: 64KB, Segment Size: 8KB, BIOS Geometry: 255/63
kernel: DAC960#0:   Physical Devices:
kernel: DAC960#0:     0:2  Vendor: IBM       Model: DNES-309170W      Revision: SAH0
kernel: DAC960#0:          Serial Number:         AJLCD237
kernel: DAC960#0:          Disk Status: Online, 17915904 blocks
kernel: DAC960#0:     0:4  Vendor: IBM       Model: DNES-309170W      Revision: SAH0
kernel: DAC960#0:          Serial Number:         AJLCD597
kernel: DAC960#0:          Disk Status: Online, 17915904 blocks
kernel: DAC960#0:     0:6  Vendor: IBM       Model: DNES-309170W      Revision: SAH0
kernel: DAC960#0:          Serial Number:         AJLCE762
kernel: DAC960#0:          Disk Status: Online, 17915904 blocks
kernel: DAC960#0:   Logical Drives:
kernel: DAC960#0:     /dev/rd/c0d0: RAID-5, Online, 35831808 blocks, Write Thru


> 
> Any idea what's going on?  I just convinced the boss to spend some money 

Never had problems with the DAC960 driver in 2.4 (or 2.2 for that matter) ...
Could you provide the message printed by your kernel ? We can continue from
there ... maybe Leonard has an idea of what`s going on ... Leonard ?

> for new equipment, and I'd rather not have to spend more at the moment. 
>  TIA.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Cheers, 
Morten

-- 

"Livet er ikke for nybegynnere" - sitat fra en klok person.

mvh
Morten Helgesen 
UNIX System Administrator & C Developer 
Nextframe AS
admin@nextframe.net / 93445641
http://www.nextframe.net
