Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275913AbTHOLy0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 07:54:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275917AbTHOLy0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 07:54:26 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:54532 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S275913AbTHOLx5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 07:53:57 -0400
Subject: Re: Trying to run 2.6.0-test3
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Norman Diamond <ndiamond@wta.att.ne.jp>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <0b8801c36314$17890fa0$1aee4ca5@DIAMONDLX60>
References: <0a5b01c36305$4dec8b80$1aee4ca5@DIAMONDLX60>
	 <1060937593.604.14.camel@teapot.felipe-alfaro.com>
	 <0b8801c36314$17890fa0$1aee4ca5@DIAMONDLX60>
Content-Type: text/plain
Message-Id: <1060948426.589.3.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 15 Aug 2003 13:53:46 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-08-15 at 12:00, Norman Diamond wrote:

> > Have you upgraded to latest modutils package? Modules are implemented
> > quite differently in 2.6.
> 
> "seems to be a result of compiling the new modules packages manually at a
> time when I could not persuade the rpm --rebuild command to target the
> correct cpu."  Yes, "the new modules packages" meant the new modules
> packages.  I did have to ask about this at the beginning of -test1 days.  (I
> never had time to try testing a 2.5 kernel but the appearance of 2.6.0-test1
> made it look like testing would become valuable.)

I can't understand why manually compiling modules (make modules) could
cause you problems that "rpm --rebuild" couldn't.

> > > Kernel command line: acpi=off apm=on root=/dev/hda8
> >
> > I suggest you to recompile your kernel with ACPI support to see if it
> > works correctly. Else, recompile it disabling ACPI support and enabling
> > APM support.
> 
> Guess why I compiled it without ACPI support and with APM support.  Guess
> why my kernel command line has acpi=off apm=on.  (Although the command line
> options are redundant with the self-compiled kernel configuration, they are
> necessary when booting a generic kernel.  Yes I know that the machine has
> just enough ACPI hooks to cause problems when anyone other than Windows 98
> tries to use ACPI.  It's not even recommended to force ACPI on when
> installing Windows 98 on this machine.  Windows 2000 blue screens if ACPI is
> forced on.  Linux doesn't panic when its default ACPI takes over, but it
> does prevent APM from working.)

If you turn ACPI on, you won't need APM support. Well, ACPI has still
some broken functionality, like S3 states, but usually, you can do
pretty well with ACPI. There was a long time ago since I used APM for
the very last time.

> Fine, but I didn't think I had to worry about that, since it looked like
> Linux already properly detected the fact.
> 
> > > PCI: IRQ 0 for device 0000:00:01.2 doesn't match PIRQ mask - try pci=usepirqmask
> > > PCI: IRQ 0 for device 0000:00:0a.0 doesn't match PIRQ mask - try pci=usepirqmask
> > > PCI: IRQ 0 for device 0000:00:0a.1 doesn't match PIRQ mask - try pci=usepirqmask
> >
> > Please, add "pci=usepirqmask" to your kernel command line in GRUB/Lilo.
> 
> Oh, that could be it, I just noticed that the second and third occurences
> relate to the PCMCIA slots.  May I ask though, what PIRQ mask is it, that is
> failing to be matched?  It seems to me that it might be more useful for
> 2.6.0 to do as good a job as 2.4.19 did in figuring out the IRQs, and I
> would like to continue testing this.  (Probably I can only spend about one
> day a week on it though.)

To be sincere, I don't know exactly why "pci=usepirqmask" needs to be
used. I'm no hardware expert. But I know that I needed it when I wasn't
using ACPI.

Probably, if you disable APM support and enable ACPI, you won't need to
boot using "pci=usepirqmask".

