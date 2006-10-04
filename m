Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030732AbWJDC72@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030732AbWJDC72 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 22:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030733AbWJDC72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 22:59:28 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:64919 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1030732AbWJDC71 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 22:59:27 -0400
Date: Tue, 3 Oct 2006 20:59:26 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Jeff Garzik <jeff@garzik.org>
Cc: Frederik Deweerdt <deweerdt@free.fr>, linux-kernel@vger.kernel.org,
       arjan@infradead.org, alan@lxorguk.ukuu.org.uk, akpm@osdl.org,
       rdunlap@xenotime.net, gregkh@suse.de
Subject: Re: [RFC PATCH] add pci_{request,free}_irq take #2
Message-ID: <20061004025925.GA28596@parisc-linux.org>
References: <20061003220732.GE2785@slug> <4522E0E0.9020404@garzik.org> <20061003222910.GJ2785@slug> <4522E618.2070004@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4522E618.2070004@garzik.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2006 at 06:37:12PM -0400, Jeff Garzik wrote:
> Frederik Deweerdt wrote:
> >My bad, I've mixed your proposal and Matthew's, isn't this just a
> >matter of:
> >s/ARCH_VALIDATE_PCI_IRQ/ARCH_VALIDATE_IRQ/ ?
> >
> >I'll look if there's some non-PCI code that might check the irq's value
> >and thus might benefit from this.
> 
> The irq value comes from the PCI subsystem...  The PCI subsystem should 
> validate it.

That's not true.  The value in the pci_dev->irq field has been changed
by the architecture.  See, for example, pci_read_irq_line() in
arch/powerpc/kernel/pci_32.c.  It's a Linux IRQ number, not a PCI IRQ
number.
