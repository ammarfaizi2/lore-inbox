Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310979AbSCRO13>; Mon, 18 Mar 2002 09:27:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310981AbSCRO1O>; Mon, 18 Mar 2002 09:27:14 -0500
Received: from front1.mail.megapathdsl.net ([66.80.60.31]:42252 "EHLO
	front1.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S310979AbSCRO1D>; Mon, 18 Mar 2002 09:27:03 -0500
Message-ID: <3C95F77D.5040004@megapathdsl.net>
Date: Mon, 18 Mar 2002 06:19:41 -0800
From: Miles Lane <miles@megapathdsl.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020212
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.7-pre2 -- Error seeking in /dev/kmem.  Would someone please look into this!
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Skip Ford wrote:
 > Miles Lane wrote:
 > > Is anyone else seeing this?  I have been getting these errors
 > > throughout much of the 2.5 development cycle.  I am not sure
 > > when the problem started, since I have had a lot of trouble
 > > getting most of the 2.5 series kernels to build.
 > >
 > > Mar 17 11:15:02 turbulence kernel: Loaded 22474 symbols from
 > > /boot/System.map-2.5.7-pre2.
 > > Mar 17 11:15:02 turbulence kernel: Symbols match kernel version 2.5.7.
 > > Mar 17 11:15:02 turbulence kernel: Error seeking in /dev/kmem
 > > Mar 17 11:15:02 turbulence kernel: Symbol #af_packet, value d98dd000
 > > Mar 17 11:15:02 turbulence kernel: Error adding kernel module table 
entry.
 >
 > Mar 17 17:05:33 s kernel: Error seeking in /dev/kmem
 > Mar 17 17:05:33 s kernel: Symbol #ipt_LOG, value d0894000
 > Mar 17 17:05:33 s kernel: Error adding kernel module table entry.
 >
 > I've been wondering about those...they're always the first syslog
 > messages when I boot wth 2.5.7-pre1.

More importantly, a large chunk of the startup messages are lost,
including most of the early kernel log messages.  This makes it
quite hard to know whether my drivers and kernel are loading and
working properly.

Note that when I watch the machine booting, it appears that
all the correct stuff still gests dumped to the console terminal.

Mar 18 05:46:46 turbulence syslog: syslogd startup succeeded
Mar 18 05:46:46 turbulence kernel: klogd 1.4.1, log source = /proc/kmsg 
started.
Mar 18 05:46:46 turbulence kernel: Inspecting /boot/System.map-2.5.7-pre2
Mar 18 05:46:46 turbulence syslog: klogd startup succeeded
Mar 18 05:46:47 turbulence portmap: portmap startup succeeded
Mar 18 05:46:47 turbulence kernel: Loaded 22474 symbols from 
/boot/System.map-2.5.7-pre2.
Mar 18 05:46:47 turbulence kernel: Symbols match kernel version 2.5.7.
Mar 18 05:46:47 turbulence kernel: Error seeking in /dev/kmem
Mar 18 05:46:47 turbulence kernel: Symbol #af_packet, value d98dd000
Mar 18 05:46:47 turbulence kernel: Error adding kernel module table entry.
Mar 18 05:46:47 turbulence kernel: Device driver loaded
Mar 18 05:46:47 turbulence kernel: udf: registering filesystem
Mar 18 05:46:47 turbulence kernel: parport0: PC-style at 0x378 (0x778) 
[PCSPP,TRISTATE]
Mar 18 05:46:47 turbulence kernel: parport0: irq 7 detected
Mar 18 05:46:47 turbulence kernel: parport0: cpp_daisy: aa5500ff(38)
Mar 18 05:46:47 turbulence kernel: parport0: assign_addrs: aa5500ff(38)
Mar 18 05:46:47 turbulence kernel: parport0: cpp_daisy: aa5500ff(38)
Mar 18 05:46:47 turbulence rpc.statd[721]: Version 0.3.1 Starting
Mar 18 05:46:47 turbulence kernel: parport0: assign_addrs: aa5500ff(38)
Mar 18 05:46:47 turbulence nfslock: rpc.statd startup succeeded
Mar 18 05:46:47 turbulence kernel: Console: switching to colour frame 
buffer device 80x30
Mar 18 05:46:47 turbulence kernel: rivafb: PCI nVidia NV16 framebuffer 
ver 0.9.2a (GeForce-DDR, 32MB @ 0xE8000000)
Mar 18 05:46:47 turbulence kernel: Detected PS/2 Mouse Port.

	Miles

