Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314622AbSD0WQU>; Sat, 27 Apr 2002 18:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314623AbSD0WQT>; Sat, 27 Apr 2002 18:16:19 -0400
Received: from natwar.webmailer.de ([192.67.198.70]:46438 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S314622AbSD0WQS>; Sat, 27 Apr 2002 18:16:18 -0400
Content-Type: text/plain; charset=US-ASCII
From: Dominik Brodowski <devel@brodo.de>
To: tomas szepe <kala@pinerecords.com>
Subject: Re: ACPI in 2.5 kills kbd on Via-ACPI systems [Re: kernel 2.5.10 problems]
Date: Sun, 28 Apr 2002 00:15:39 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <20020427150206.A30695@louise.pinerecords.com> <28493.1019938454@www26.gmx.net>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <02042800153901.01292@sonnenschein>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, 27. April 2002 22:14, tomas szepe wrote:
> > 2. When ACPI support is installed the kernel gives a "Keyboard not found"
> > error when booting and I have to push the reset switch to reboot. This
> > problem has also been mentioned before but I don't think anyone has
> > related it to the ACPI support.
>
> You're right! I tried to point out before that my system had ignored the
> keyboard since about the time of 2.5.7/2.5.8, but it didn't occur to me
> that the problem could be ACPI related. Indeed, after compiling 2.5.10-dj1
> (2.5.10 vanilla barfs an oops at me upon boot) w/ ACPI support turned off,
> I found the system perfectly responsive again -- both mouse and keyboard
> work.
>
> Thus I dare assume it's highly probable that input support has been broken
> for VIA chipset-based systems by the recent ACPI changes in 2.5.x.

Actually it is ACPI PCI-IRQ routing which has been broken since 2.5.8-pre3; 
the next acpi-release ( http://sourceforge.net/projects/acpi/ ) will include 
updates for that feature. For the time being, you might try one of my 
patches:

x v.9 or v.12 [for acpi-20020404(*)] of my ACPI-PIC-pci-irq 
rewrite, which is available at
http://www.brodo.de/english/pub/acpi/pci_irq/

or

x "Do not use IRQ 1" at 
http://www.brodo.de/english/pub/acpi/20020404/bugfixes.html



Dominik

(*) acpi-20020404 got merged into 2.5.8-pre3
