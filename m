Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262414AbUJ0M5C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262414AbUJ0M5C (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 08:57:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262416AbUJ0M5B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 08:57:01 -0400
Received: from pop.gmx.net ([213.165.64.20]:43755 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262414AbUJ0M45 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 08:56:57 -0400
Date: Wed, 27 Oct 2004 14:56:56 +0200 (MEST)
From: "Daniel Blueman" <daniel.blueman@gmx.net>
To: "Yu, Luming" <luming.yu@intel.com>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
MIME-Version: 1.0
References: <3ACA40606221794F80A5670F0AF15F84041ABFE9@pdsmsx403>
Subject: RE: [2.6.9] unhandled OHCI IRQs...
X-Priority: 3 (Normal)
X-Authenticated: #8973862
Message-ID: <6799.1098881816@www37.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I forgot to stop the OHCI controllers being disabled with a 'setpci
command=0' command on bootup. Now everything works perfectly!

> Please verify if APIC mode can help this case?
> 
> Thanks
> Luming 
> 
> >-----Original Message-----
> >From: linux-kernel-owner@vger.kernel.org 
> >[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Daniel Blueman
> >Sent: 2004Äê10ÔÂ25ÈÕ 4:20
> >To: linux-usb-devel@lists.sourceforge.net; linux-kernel@vger.kernel.org
> >Subject: [2.6.9] unhandled OHCI IRQs...
> >
> >When plugging in an Epson C62 USB 1.1 printer to my nForce 2 
> >OHCI + EHCI USB
> >controllers, the IRQ doesn't seem to get handled [1]. Tried both with
> >acpi=noirq and without, printer support and full USB support 
> >enabled. Kernel
> >is 2.6.9.
> >
> >Any ideas?
> >
> >--- [1]
> >
> >irq 7: nobody cared!
> > [<c01063d4>] __report_bad_irq+0x24/0x80
> > [<c01064b1>] note_interrupt+0x61/0x90
> > [<c010637b>] handle_IRQ_event+0x2b/0x60
> > [<c010676a>] do_IRQ+0x11a/0x130
> > [<c010479c>] common_interrupt+0x18/0x20
> > [<c0119f30>] __do_softirq+0x30/0x90
> > [<c0119fb6>] do_softirq+0x26/0x30
> > [<c010674b>] do_IRQ+0xfb/0x130
> > [<c010479c>] common_interrupt+0x18/0x20
> > [<c0101df0>] default_idle+0x0/0x30
> > [<c0101e13>] default_idle+0x23/0x30
> > [<c0101e8a>] cpu_idle+0x3a/0x60
> > [<c035c8e1>] start_kernel+0x141/0x160
> > [<c035c530>] unknown_bootoption+0x0/0x160
> >handlers:
> >[<c022dcd0>] (usb_hcd_irq+0x0/0x60)
> >Disabling IRQ #7
> >spurious 8259A interrupt: IRQ7.
> >
> >--- [2]
> >
> ># grep hcd /proc/interrupts 
> >  5:          0          XT-PIC  ohci_hcd
> >  7:     164004          XT-PIC  ohci_hcd
> > 12:          2          XT-PIC  ehci_hcd

-- 
Daniel J Blueman

Geschenkt: 3 Monate GMX ProMail + 3 Ausgaben der TV Movie mit DVD
++++ Jetzt anmelden und testen http://www.gmx.net/de/go/mail ++++

