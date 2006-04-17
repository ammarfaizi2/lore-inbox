Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751006AbWDQOPn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006AbWDQOPn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 10:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751008AbWDQOPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 10:15:43 -0400
Received: from stokkie.demon.nl ([82.161.49.184]:60384 "HELO stokkie.net")
	by vger.kernel.org with SMTP id S1751004AbWDQOPn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 10:15:43 -0400
Date: Mon, 17 Apr 2006 16:15:16 +0200 (CEST)
From: "Robert M. Stockmann" <stock@stokkie.net>
To: Arjan van de Ven <arjan@infradead.org>
cc: linux-kernel@vger.kernel.org, Randy Dunlap <rddunlap@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Andre Hedrick <andre@linux-ide.org>,
       Manfred Spraul <manfreds@colorfullife.com>, Alan Cox <alan@redhat.com>,
       Kamal Deen <kamal@kdeen.net>
Subject: Re: irqbalance mandatory on SMP kernels?
In-Reply-To: <1145279422.2847.44.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.44.0604171608400.28728-100000@hubble.stokkie.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: scanned for viruses by AMaViS 0.2.3 (ftp://crashrecovery.org/pub/linux/amavis/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Apr 2006, Arjan van de Ven wrote:

> Date: Mon, 17 Apr 2006 15:10:22 +0200
> 
> > [jackson:stock]:(/usr/src/linux)$ cat /proc/interrupts 
> >            CPU0       CPU1       
> >   0:    3139568          0    IO-APIC-edge  timer
> >   1:       8923          0    IO-APIC-edge  i8042
> >   3:         10          0    IO-APIC-edge  serial
> >   4:         37          0    IO-APIC-edge  serial
> >   8:          0          0    IO-APIC-edge  rtc
> >   9:        240          0   IO-APIC-level  acpi
> >  12:      75316          0    IO-APIC-edge  i8042
> >  14:      64291          0    IO-APIC-edge  ide0
> >  15:      64291          0    IO-APIC-edge  ide1
> >  16:     235408          0   IO-APIC-level  HiSax, nvidia
> >  17:      15823          0   IO-APIC-level  libata, AMD AMD8111
> >  19:        241          0   IO-APIC-level  ohci_hcd, ohci_hcd, ohci1394
> >  24:      50761          0   IO-APIC-level  eth0
> > NMI:         89         28 
> > LOC:    3139042    3139125 
> > ERR:          0
> > MIS:          0
> > [jackson:stock]:(/usr/src/linux)$ 
> 
> this may or may not be a problem depending on how long a time you used
> to collect this. Based on your timer tick count it really looks like
> your irq rates are so low that it really doesn't matter much
> 
> > 
> > Only when firing up the irqbalance util at boot time will activate
> > true SMP, distributing IRQ's across CPU's. Is this on purpose?
> > Because afaik a Linux SMP kernel, 2.4.xx or 2.6.xx should always
> > result in distributed IRQ loads across CPU's.
> 
> that is a chipset feature if it happens; not all chipsets do this (and
> most that do, do it badly). 
> 
> I'm not sure what your actual problem is btw, the irqbalance tool is
> supposed to automatically start at boot, did it not do that ?
> (and no the kernel doesn't need to do everything, something like this
> can perfectly well be done in userspace as irqbalance shows)

My question is if the irqbalance util is really needed to activate IRQ 
balancing these days. Which kernel versions and higher (2.4xx and 
2.6.xx) do need this tool? 

To my understanding can a Linux/UNIX kernel not be called SMP if it 
does not activate Symmetric IRQ balancing out of the box. Why was 
irqbalance introduced as a tool inside kernel-utils in the 1st place?  
In other words: What happened to the Linux kernel that we today now 
need a tool called irqbalance ?

Robert
-- 
Robert M. Stockmann - RHCE
Network Engineer - UNIX/Linux Specialist
crashrecovery.org  stock@stokkie.net

