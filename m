Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261665AbTCaOrW>; Mon, 31 Mar 2003 09:47:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261674AbTCaOrW>; Mon, 31 Mar 2003 09:47:22 -0500
Received: from 62-177-202-82.bbeyond.nl ([62.177.202.82]:39034 "EHLO
	exch2k-01.infopart.nl") by vger.kernel.org with ESMTP
	id <S261665AbTCaOrU> convert rfc822-to-8bit; Mon, 31 Mar 2003 09:47:20 -0500
content-class: urn:content-classes:message
Subject: PCMCIA IRQ Problems
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Date: Mon, 31 Mar 2003 16:58:36 +0200
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
Message-ID: <D502122A1694B04EAE0F53D53CC2F7640175B8@exch2k-01.infopart.nl>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PCMCIA IRQ Problems
Thread-Index: AcL3lgIUUGefDMOQRsWNI3dazafs+g==
From: "Ferry van Steen" <ferry.van.steen@InfoPart.nl>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey there,

with the 2.4.21-pre4 kernel everything was working fine. However, since
pre5 (and pre6 thus) my PCMCIA card won't work (tried 2 different ones,
both networking). The error I get is that the IRQ is in use.

Now there are several things I don't get on this. A couple of years ago
I was still into hardware a little, not too much now. Anyways from those
days I know IRQ's can be shared on PCI devices, only this is really
nuts. Almost all devices that don't have any of the standard IRQ's (like
parallel = 7) appearantly are on the same IRQ. I've heared several
things about this, but don't know what to believe...

Some say ACPI (the power management feature) needs all PCI devices on
the same IRQ for the power management. This I've seen before (and HATE
it's crap on both windows and linux) and has caused me many problems
with machines with like 5 cards or more. This machine (a Dell Inspiron
5000e) however works fine on windows with all the devices on the same
IRQ (which I still don't like :-)). Anyways, it's a phoenix bios which
doesn't allow me to do much in opposite to award/ami bios'es. Anyways, I
tried enabling ACPI in the kernel, but it still gives me IRQ errors.

Others say it has to do with APIC (Advanced Programmable Interrupt
Controller) which allows for 'virtual' IRQ's. I've seen machines with
this feature having IRQ's up till 24, however, this machine does NOT
have an APIC, so enabling it for single processor did nothing at all.

In the 2.4.21-pre4 kernel atleast I could things working (that is, after
using the network card (the PCMCIA one :-)) intensively for 15-20
minutes the machine would lock up) now I can't do anything :-(

Anyways, if anyone could help me with this problem I would really
appreciate it. Also, if anyone has nice links to the 'why are all PCI
devices that don't have some pre-defined IRQ to the old standards on the
same IRQ' answers/docs/useful info I would really appreciate that too as
I've had a whole bundle of problems with it so far on both windows and
linux and never seem to be able to solve them (that is, without
disabling ACPI in the bios, which works, but is impossible on this
notebook).

For the convenience attached is a text file with in there the output of
dmesg right after kernelboot (and after starting cardmgr -f) and the
output of lspci -v. Gcc is 3.2.1 btw on gentoo linux 1.4rc2 pretty
updated, stage 1.

If you guys require any info at all I'll be glad to supply it. I'm new
to programming, but I pick up things quick so let me know...

Kind regards
