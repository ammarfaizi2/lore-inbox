Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314520AbSD1VgP>; Sun, 28 Apr 2002 17:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314523AbSD1VgP>; Sun, 28 Apr 2002 17:36:15 -0400
Received: from natpost.webmailer.de ([192.67.198.65]:22405 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S314520AbSD1VgO>; Sun, 28 Apr 2002 17:36:14 -0400
Content-Type: text/plain; charset=US-ASCII
From: Dominik Brodowski <devel@brodo.de>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: [ACPI] 2.5.10+ acpi0419 breakage
Date: Sun, 28 Apr 2002 23:30:24 +0200
X-Mailer: KMail [version 1.2]
Cc: ACPI mailing list <acpi-devel@lists.sourceforge.net>,
        kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20020428110630.GA702@elf.ucw.cz> <02042822313402.00870@sonnenschein> <20020428215046.A275@elf.ucw.cz>
MIME-Version: 1.0
Message-Id: <02042823302401.01233@sonnenschein>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On Sunday, 28. April 2002 21:50, Pavel Machek wrote:
> I don't know. How can I find out if it has IOAPIC.
<snip>
> ACPI: Using PIC for interrupt routing
either from this line [reliably when using pciirq.12 from 
http://www.brodo.de/english/pub/acpi/pci_irq/ on], or a dmesg | grep IOAPIC 
should show something... your system uses a PIC, though.

<snip>
> acpi_bus-0288 [296] acpi_bus_get_device   : Error getting context for
> object [c3eef698] pci_root-0201 [295] acpi_pci_get_link_for_: Invalid IRQ
> router
A problem either in the ACPI tables, in the parsing code or in the 
higer-level stuff. Probably the first... but could you please re-try the next 
acpi-release, and if it doesn't work then, re-send this bug report? The 
function the error occurs in is completely re-written, so things might 
(hopefully) change. Thanks.

> > Could you please try the pciirq.9.acpi.diff or -even better- pciirq.12,
> > available at
> > http://www.brodo.de/english/pub/acpi/pci_irq/
> >
> > The assignation of non-dynamic IRQs is somewhat broken (by me :-( in
> > acpi-20020419, I suspect your systems are affected by that bug. Sorry for
> > that.
>
> Will try if I have time.

Thanks - or wait for the next acpi-release.

Dominik
