Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129928AbQKFXuU>; Mon, 6 Nov 2000 18:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130310AbQKFXuJ>; Mon, 6 Nov 2000 18:50:09 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:27140 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129928AbQKFXuG>; Mon, 6 Nov 2000 18:50:06 -0500
Message-ID: <3A0742B0.653A5AAF@timpanogas.org>
Date: Mon, 06 Nov 2000 16:45:52 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: David Hinds <dhinds@valinux.com>
CC: David Ford <david@linux.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: current snapshots of pcmcia
In-Reply-To: <3A06757F.3C63F1A8@linux.com> <20001106104927.A19573@valinux.com> <3A073C8D.B6511746@linux.com> <20001106154039.A19860@valinux.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


David [Hinds],

On a related topic, I've pulled down your stuff at sourceforge and we
are using it for our 2.4 build.  Is this the baest place or do you have
somewhere more recent and is this the list to report bugs?  We have seen
some problems with IBM thinkpads with DSP devices having some issues
(like the volume control doesn't work right on 2.4).  Most are just
annoyances and what I would classify as level IV bugs (very
non-critical).

Thanks,

Jeff

David Hinds wrote:
> 
> On Mon, Nov 06, 2000 at 03:19:41PM -0800, David Ford wrote:
> >
> > Undoubtedly :(  But it used to work when I used your i82365 module instead of
> > the kernel's yenta module.  The i82365 module now gives the same failure
> > output as the yenta module.
> 
> How long ago was this?  I would need to know what kernel versions and
> what PCMCIA driver versions were involved.  It has been months since I
> changed any of the PCI bridge setup code in the PCMCIA modules.
> 
> > I modprobed the following to get things up and running, (all your pkg)
> > pcmcia_core, i82365, and ds.  Then ran cardmgr.  All was well.  Now when I
> > load i82365, it yields the pci irq failure and the irq type is changed.
> >
> > 2nd sentc: What changed in the last two-three weeks?  I notice that the
> > current pcmcia (yours) code loads a new module called pci_fixup.
> 
> There is no module called pci_fixup.  There is an object file called
> pci_fixup that is linked into pcmcia_core.  This has been there since
> PCMCIA release 3.1.11.
> 
> > Intel PCIC probe: <4>PCI: No IRQ known for interrupt pin A of device 00:03.0.
> > PCI: No IRQ known for interrupt pin B of device 00:03.1.
> 
> This is a PCI subsystem issue; the PCMCIA code asks the PCI subsystem
> to activate the bridge device and isn't working.
> 
> >   Ricoh RL5C478 rev 03 PCI-to-CardBus at slot 00:03, mem 0x10000000
> >     host opts [0]: [isa irq] [io 3/6/1] [mem 3/6/1] [no pci irq] [lat
> > 168/176] [bus 2/5]
> >     host opts [1]: [serial irq] [io 3/6/1] [mem 3/6/1] [no pci irq] [lat
> > 168/176] [bus 6/9]
> >     ISA irqs (default) = 3,4,7,11 polling interval = 1000 ms
> >
> > Previous output was:
> >   Ricoh RL5C478 rev 03 PCI-to-CardBus at slot 00:03, mem 0x10000000
> >     host opts [0]: [serial irq] [io 3/6/1] [mem 3/6/1] [no pci irq] [lat
> > 168/176] [bus 2/5]
> >     host opts [1]: [serial irq] [io 3/6/1] [mem 3/6/1] [no pci irq] [lat
> > 168/176] [bus 6/9]
> >     ISA irqs (default) = 3,4,7,11 polling interval = 1000 ms
> >
> > Notice the change from serial irq to isa irq.
> 
> This is odd.  I don't have an explanation for this, especially without
> knowing what PCMCIA driver releases were involved.  Unless you specify
> otherwise, the i82365 driver just reports the bridge settings that it
> finds; it won't change the interrupt delivery mode unless told to do
> so.  So something else has caused your two sockets to be set up in
> different ways; there isn't any way to tell the i82365 module to do
> that.
> 
> -- Dave
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
