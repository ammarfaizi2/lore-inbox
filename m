Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271103AbTHQWFJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 18:05:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271091AbTHQWFJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 18:05:09 -0400
Received: from www.13thfloor.at ([212.16.59.250]:35289 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S271105AbTHQWFB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 18:05:01 -0400
Date: Mon, 18 Aug 2003 00:05:12 +0200
From: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>
To: Karel =?iso-8859-1?Q?Kulhav=FD?= <clock@twibright.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NMI appears to be stuck! (2.4.22-rc2 on dual Athlon)
Message-ID: <20030817220512.GA10967@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: Karel =?iso-8859-1?Q?Kulhav=FD?= <clock@twibright.com>,
	linux-kernel@vger.kernel.org
References: <20030817212824.GA9025@www.13thfloor.at> <20030818014000.A29722@beton.cybernet.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20030818014000.A29722@beton.cybernet.src>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 18, 2003 at 01:40:00AM +0200, Karel Kulhavý wrote:
> It seems NMI watchdog doesn't work on nforce2 (Athlon) chipset boards when APIC
> is enabled.

hmm, this is on a   
  - Tyan Tiger MPX S2466N-4M
  - AMD Dual 1.8GHZ Athlon

00:00.0 Host bridge: Advanced Micro Devices [AMD]: Unknown device 700c (rev 11)
00:01.0 PCI bridge: Advanced Micro Devices [AMD]: Unknown device 700d
00:07.0 ISA bridge: Advanced Micro Devices [AMD]: Unknown device 7440 (rev 05)

isn't nForce2 from nVIDIA ?

> I don't know if it works if APIC is disabled and also don't know
> about other boards.

it works perfectly, only the nmi_watchdog cannot be
enabled ...

thanks,
Herbert

> On Sun, Aug 17, 2003 at 11:28:24PM +0200, Herbert Pötzl wrote:
> > 
> > Hi All!
> > 
> > Still no nmi_watchdog on dual Athlon systems?
> > 
> > Linux version 2.4.22-rc2 on dual
> > 
> > processor	: 0
> > vendor_id	: AuthenticAMD
> > cpu family	: 6
> > model		: 6
> > model name	: AMD Athlon(tm) MP 1800+
> > stepping	: 2
> > cpu MHz		: 1533.401
> > cache size	: 256 KB
> > 
> > Total of 2 processors activated (6127.61 BogoMIPS).                                                                                      ENABLING IO-APIC IRQs                                                                                                                    ..TIMER: vector=0x31 pin1=2 pin2=0                                                                                                       activating NMI Watchdog ... done.                                                                                                        testing NMI watchdog ... CPU#0: NMI appears to be stuck!                                                                                 testing the IO APIC.......................                                                                                                                                                                                                                                        .................................... done.                                                                                               Using local APIC timer interrupts.                                                                                                       calibrating APIC timer ...                                                                                                               
> > 
> > 
> > just for curiosity, if I do not give the nmi_watchdog=1 
> > option on the kernel boot line, the nmi seems to work fine?
> > 
> > # cat /proc/interrupts 
> >            CPU0       CPU1       
> >   0:       4275       2602    IO-APIC-edge  timer
> >   1:          0          2    IO-APIC-edge  keyboard
> >   2:          0          0          XT-PIC  cascade
> >   4:        157        150    IO-APIC-edge  serial
> >   8:          1          0    IO-APIC-edge  rtc
> >   9:        169        186   IO-APIC-level  acpi
> >  15:         12          3    IO-APIC-edge  ide1
> >  16:       1195       1155   IO-APIC-level  aic7xxx
> >  17:        149        144   IO-APIC-level  eth1
> >  19:          1          3   IO-APIC-level  eth0
> > NMI:       4034       3577 
> > LOC:       6782       6777 
> > ERR:          0
> > MIS:          0
> > 
> > is this intentional, or have I missed something
> > terrible important? if you need more information,
> > let me know ...
> > 
> > TIA,
> > Herbert
