Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288928AbSAQPA1>; Thu, 17 Jan 2002 10:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288944AbSAQPAR>; Thu, 17 Jan 2002 10:00:17 -0500
Received: from galba.tp1.ruhr-uni-bochum.de ([134.147.240.75]:49419 "EHLO
	galba.tp1.ruhr-uni-bochum.de") by vger.kernel.org with ESMTP
	id <S288928AbSAQO76>; Thu, 17 Jan 2002 09:59:58 -0500
Date: Thu, 17 Jan 2002 15:59:31 +0100 (CET)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
To: Jes Sorensen <jes@trained-monkey.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>,
        <torvalds@transmeta.com>, Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [patch] VAIO irq assignment fix
In-Reply-To: <15430.55835.417188.484427@trained-monkey.org>
Message-ID: <Pine.LNX.4.33.0201171556060.19753-100000@chaos.tp1.ruhr-uni-bochum.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jan 2002, Jes Sorensen wrote:

> >> I have gotten a Sony VAIO R505TL laptop which has a Richo RL5C574
> >> Cardbus controller however the broken bios doesn't assign an irq to
> >> the controller even though it is attached.
> 
> Alan> Surely pci_enable_device should do that anyway?
> 
> The problem is that the interrupt is not set in the PIRQ table so if we
> don't shoehorn it in, the interrupt source wont be found.

Is the interrupt in the ACPI PCI IRQ routing table? Basic support for that
is in the latest ACPI patch, 20011218 (www.sf.net/projects/acpi), it'll
print the _PRT entries during boot. However, the info isn't used to
actually setup the routing, so it won't help your problem. I have a patch
which uses the ACPI table for setting up IRQ routing, that should make
sure system work properly.

--Kai

