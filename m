Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265568AbSLIN1I>; Mon, 9 Dec 2002 08:27:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265578AbSLIN1I>; Mon, 9 Dec 2002 08:27:08 -0500
Received: from pc1-cwma1-5-cust42.swan.cable.ntl.com ([80.5.120.42]:63163 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265568AbSLIN1H>; Mon, 9 Dec 2002 08:27:07 -0500
Subject: Re: /proc/pci deprecation?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Richard Henderson <rth@twiddle.net>, Patrick Mochel <mochel@osdl.org>,
       Willy Tarreau <willy@w.ods.org>, Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       jgarzik@pobox.com
In-Reply-To: <Pine.LNX.4.44.0212081747590.1209-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0212081747590.1209-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 09 Dec 2002 14:11:07 +0000
Message-Id: <1039443067.10475.19.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-12-09 at 01:54, Linus Torvalds wrote:
>  - we should _never_ update the PCI_INTERRUPT_LINE register, because it
>    destroys boot loader information (the same way we need to not overwrite
>    BIOS extended areas and ACPI areas etc in order to be able to reboot
>    cleanly)

I wonder if this is why we have all these problems with VIA chipset
interrupt handling. According to VIA docs they _do_ use
PCI_INTERRUPT_LINE on integrated devices to select the IRQ routing
between APIC and PCI/ISA etc, as well as 0 meaning "IRQ disabled"

Alan

