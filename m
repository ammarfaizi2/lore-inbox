Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263330AbTKKDsi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 22:48:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264184AbTKKDsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 22:48:38 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:39070 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S263330AbTKKDsf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 22:48:35 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 10 Nov 2003 19:48:36 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Alexander ZVYAGIN <Alexander.Zviagine@cern.ch>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PCI with SiS: Cannot allocate resource.
In-Reply-To: <200311101847.07792.Alexander.Zviagine@cern.ch>
Message-ID: <Pine.LNX.4.44.0311101557020.2097-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Nov 2003, Alexander ZVYAGIN wrote:

> Hello Davide,
> 
> On Sunday 09 November 2003 16:45, Davide Libenzi wrote:
> > On Sun, 9 Nov 2003, Alexander ZVYAGIN wrote:
> > > > Can you try to apply this over test9:
> > > >
> > > > http://www.kernel.org/pub/linux/kernel/v2.6/snapshots/patch-2.6.0-test9
> > > >-bk1 3.bz2
> > >
> > > I see the same messages...
> >
> > $ cat /proc/interrupts
> >
> > Also you can try to disable:
> >
> > CONFIG_X86_UP_APIC
> > CONFIG_X86_UP_IOAPIC
> > CONFIG_X86_LOCAL_APIC
> > CONFIG_X86_IO_APIC
> 
> Still the same.... See the attachments.

Running really out of options here. The dmesg shows that you're sharing 
the IRQ5 but it does not even show up in your int list. Your card seems to 
be sharing IRQ 5 with:

PCI: Sharing IRQ 5 with 0000:00:01.6
PCI: Sharing IRQ 5 with 0000:00:0c.1

IIRC one is the modem, and I do not remember the other one. If your BIOS 
has the option to shut those device off, you can try that. Also you can 
try (if you can) to change the interrupt pin.



- Davide



