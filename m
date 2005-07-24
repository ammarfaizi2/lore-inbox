Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261965AbVGXOQH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261965AbVGXOQH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 10:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261967AbVGXOQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 10:16:07 -0400
Received: from zproxy.gmail.com ([64.233.162.197]:65319 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261965AbVGXOQF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 10:16:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XWp/nbAoRSwo9Se64d2S9ILfdrUd254uzAHYjJPcGmuZvYHqpEV6+MCo+Ad365yddFElImRNlaeaEpuGdwkHNpRSwogqNE+G3zzTigtT7Rf6ochK9dxWOJ3RjN+Ja0Oe1aHZxGMvEbwnzDNsInG81ICWKvqjMMDg3WPV9dKrems=
Message-ID: <9a87484905072407164f0e0eb5@mail.gmail.com>
Date: Sun, 24 Jul 2005 16:16:05 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: IRQ routing problem in 2.6.10-rc2
Cc: LKML <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <greg@kroah.com>
In-Reply-To: <42E395F6.8070301@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42E395F6.8070301@drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/24/05, Pierre Ossman <drzeus-list@drzeus.cx> wrote:
> Sorry about reporting this error so late but the machine in question had
> gone some time without upgrades.
> 
> The problem I'm seeing is that IRQs stop working for one of the IRQ
> slots on the machine. It's only that slot, not the entire IRQ, since the
> two slots (it's a small machine) both get routed to IRQ 10.
> 
> I've included dmesg from 2.6.10-rc1 (which works) and 2.6.10-rc2 (which
> doesn't).
> 
> I've also tried reverting the patches that modifies
> arch/i386/kernel/irq.c and arch/i386/pci/irq.c but it didn't solve the
> problem. So now I need some more input on which patches to try.
> 
[snip]
> 
> Linux version 2.6.10-rc2 (root@natasha.craffe.se) (gcc version 3.3.3 20040412 (Red Hat Linux 3.3.3-7)) #8 Wed Jul 20 02:57:15 CEST 2005
[snip]
> ACPI: Using PIC for interrupt routing
[snip]
> PCI: Using ACPI for IRQ routing
> ** PCI interrupts are no longer routed automatically.  If this
> ** causes a device to stop working, it is probably because the
> ** driver failed to call pci_enable_device().  As a temporary
> ** workaround, the "pci=routeirq" argument restores the old
> ** behavior.  If this argument makes the device work again,
> ** please email the output of "lspci" to bjorn.helgaas@hp.com
> ** so I can fix the driver.
[snip]
Have you tried the suggestion given "... As a temporary workaround,
the "pci=routeirq" argument..." ?
You could also try the pci=noacpi boot option to see if that changes anything.

Also, that's a fairly old kernel you have there, could you try
2.6.13-rc3, 2.6.13-rc3-git6 or 2.6.13-rc3-mm1 ?

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
