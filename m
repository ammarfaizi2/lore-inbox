Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130038AbRDJRb7>; Tue, 10 Apr 2001 13:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130317AbRDJRbu>; Tue, 10 Apr 2001 13:31:50 -0400
Received: from pua.physik.fu-berlin.de ([160.45.33.106]:2061 "EHLO
	pua.physik.fu-berlin.de") by vger.kernel.org with ESMTP
	id <S130038AbRDJRbn>; Tue, 10 Apr 2001 13:31:43 -0400
Date: Tue, 10 Apr 2001 19:31:25 +0200
From: Axel Thimm <Axel.Thimm@physik.fu-berlin.de>
To: "Manuel A. McLure" <mmt@unify.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Still IRQ routing problems with VIA
Message-ID: <20010410193125.A31792@pua.domain>
In-Reply-To: <419E5D46960FD211A2D5006008CAC79902E5C1A0@pcmailsrv1.sac.unify.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <419E5D46960FD211A2D5006008CAC79902E5C1A0@pcmailsrv1.sac.unify.com>; from mmt@unify.com on Tue, Apr 10, 2001 at 09:51:18AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2001 at 09:51:18AM -0700, Manuel A. McLure wrote:
> Axel Thimm said...
> > Several weeks ago there had been a thread on the pirq assignments of newer
> > VIA and SiS chipsets ending with everybody happy.
> > Everybody? Not everybody - there is a small village of chipsets resisting
> > the advent of 2.4.x :(
> > The system is a KT133A (MSI's K7T Turbo MS-6330 board)/Duron 700
> > system. Kernel 2.4.x have IRQ routing problems and USB failures (the
> > latter will most probably be due to IRQ mismatches, I believe).
> I have the same motherboard with the same lspci output (i.e. I get the "pin
> ?" part), but I don't see any problems running 2.4.3 or 2.4.3-ac[23]. I am
> only using a trackball on my USB port - what problems are you seeing?

Well, a part of the attached dmesg output yields:

> PCI: Found IRQ 11 for device 00:07.2
> IRQ routing conflict in pirq table for device 00:07.2
> IRQ routing conflict in pirq table for device 00:07.3
> PCI: The same IRQ used for device 00:0e.0
> uhci.c: USB UHCI at I/O 0x9400, IRQ 5

and later:

> uhci: host controller process error. something bad happened
> uhci: host controller halted. very bad

0.7.[2,3] are the usb devices. BIOS (and 2.2 kernels) had them at IRQ 5. 2.4
somehow picks the irq of the ethernet adapter, iqr 11, instead.

At least usb is then unusable.

As you say that you have the same board, what is the output of dump_pirq - are
your link values in the set of {1,2,3,5} or are they continuous 1-4? Maybe you
are lucky - or better say, I am having bad luck :(
-- 
Axel.Thimm@physik.fu-berlin.de
