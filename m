Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312491AbSDSQTr>; Fri, 19 Apr 2002 12:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312498AbSDSQTq>; Fri, 19 Apr 2002 12:19:46 -0400
Received: from venus.ci.uw.edu.pl ([193.0.74.207]:1542 "EHLO
	venus.ci.uw.edu.pl") by vger.kernel.org with ESMTP
	id <S312491AbSDSQTp>; Fri, 19 Apr 2002 12:19:45 -0400
Date: Fri, 19 Apr 2002 18:14:12 +0200 (CEST)
From: Jan Slupski <jslupski@email.com>
To: Pete Zaitcev <zaitcev@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Wrong IRQ for USB on Sony Vaio (dmi_scan.c, pci-irq.c)
In-Reply-To: <200204191556.g3JFuw131245@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.21.0204191801410.11418-100000@venus.ci.uw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Apr 2002, Pete Zaitcev wrote:

> > Broken BIOS of these notebooks assigns IRQ 10 for USB,
> > even though it is actually wired to IRQ 9.
> > 
> > I use PCG-FX240 model of Sony Vaio, but I have proofs of other users, 
> > that exactly the same problem exists on models:
> > FX200, FX220, FX250, FX270, FX290, FX370, FX503, R505JS, R505JL
> > These models use Intel's 82801BA controller, and Phoenix bios.
> 
> My Z505JE works perfectly without it. In general Z505's are
> known to work.

I don't know nothing more than this...
I already send an email, and I hope I'll get DMI & PCI informations
for these computers.

(fwd)
From: girish <girishji@yahoo.com>

Thanks for your USB patch. I got the USB mouse to work
on Sony Vaio PCG-R505JL. I installed RedHat 7.2 first
and the mouse would work for a few minutes and die
(with timeout messages appearing on
/var/log/messages). I did not find the source code for
redhat on the CD. So I ended up compiling the latest
kernel (2.4.18). This is the first time I compiled the
linux kernel, couldn't have been easier!

(fwd)
From: Kirk VanOpdorp <kirk@chpc.utah.edu>

I had the same USB problem on the Sony PCG-R505JS laptop. Your kernel
patch worked perfectly. At least on the 2.4.18 kernel.

> > +             dev->irq = 9;
> > +             pci_write_config_byte(dev, PCI_INTERRUPT_LINE, 9);
> > +             r->set(pirq_router_dev, dev, pirq, 9);
> > +     }
>
> So...
> 
>         if (dev->irq == 9) {
>                 dev->irq = 9;
>         }
> 
> Are you sure it's right?

OK.
This line isn't very important. ;)
Other two are!

I just modified HP Pavillion code taht do the same, but 
numbers are other .

Jan

   _  _  _  _  _____________________________________________
   | |_| |\ |  S L U P S K I              jslupski@email.com
 |_| | | | \|                 http://www.pm.waw.pl/~jslupski  



