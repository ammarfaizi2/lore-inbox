Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314492AbSD1UfY>; Sun, 28 Apr 2002 16:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314495AbSD1UfX>; Sun, 28 Apr 2002 16:35:23 -0400
Received: from natpost.webmailer.de ([192.67.198.65]:6350 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S314492AbSD1UfW>; Sun, 28 Apr 2002 16:35:22 -0400
Content-Type: text/plain; charset=US-ASCII
From: Dominik Brodowski <devel@brodo.de>
To: Pavel Machek <pavel@ucw.cz>,
        ACPI mailing list <acpi-devel@lists.sourceforge.net>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI] 2.5.10+ acpi0419 breakage
Date: Sun, 28 Apr 2002 22:31:34 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <20020428110630.GA702@elf.ucw.cz>
MIME-Version: 1.0
Message-Id: <02042822313402.00870@sonnenschein>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On Sunday, 28. April 2002 13:06, Pavel Machek wrote:
> Hi!
>
> On athlon desktop:
>
> ....
> ide: unexpected interrupt 1 15
> ide1 at 0x170-0x177,0x376 on irq 15
> ide: unexpected interrupt 0 14
> ...
> hcd.c: new USB bus registered, assigned bus number 1
> [hang]
>
> acpi=off fixes it.
IOAPIC enabled or present? Please wait for the next acpi-release, ACPI + 
IOAPICs does not work at the moment. If not, please see comments for Toshiba 
below:

> On toshiba notebook, boot is broken *only after cold boot*. I can boot
> successfully from warm boot.
Strange. Could you please send me a dmesg?

> It says
> ide: unexpected interrupt 1 15
> Unable to handle NULL pointer dereference
> EIP=somewhere in __ide_end_request. acpi=off does not fix this one.
Could you please try the pciirq.9.acpi.diff or -even better- pciirq.12, 
available at
http://www.brodo.de/english/pub/acpi/pci_irq/

The assignation of non-dynamic IRQs is somewhat broken (by me :-( in 
acpi-20020419, I suspect your systems are affected by that bug. Sorry for 
that.

Dominik
