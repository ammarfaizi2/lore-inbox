Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267599AbUHYPHG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267599AbUHYPHG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 11:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267827AbUHYPHF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 11:07:05 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:50953 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267599AbUHYPHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 11:07:03 -0400
Date: Wed, 25 Aug 2004 16:06:40 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Ralf Baechle <ralf@linux-mips.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ioc3-eth.c: add missing pci_enable_device()
Message-ID: <20040825160640.A8840@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Bjorn Helgaas <bjorn.helgaas@hp.com>,
	Jeff Garzik <jgarzik@pobox.com>, Ralf Baechle <ralf@linux-mips.org>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200408242225.i7OMPGLQ029847@hera.kernel.org> <412BE006.8040606@pobox.com> <200408250903.28133.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200408250903.28133.bjorn.helgaas@hp.com>; from bjorn.helgaas@hp.com on Wed, Aug 25, 2004 at 09:03:27AM -0600
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2004 at 09:03:27AM -0600, Bjorn Helgaas wrote:
> OK, I don't know anything about ioc3, other than the fact that it
> appeared to use pci_dev->irq without doing pci_enable_device().
> All ACPI-based PCI interrupt routing is now done in pci_enable_device()
> (in -mm, not yet in mainline), so if ioc3 were used in an ACPI-based
> system, it would likely be broken.

The ioc3 is only used on mips-based systems (and some very early IA64-based
prototypes from SGI), and neither of them supports ACPI.

