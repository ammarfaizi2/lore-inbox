Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264422AbUFLAV7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264422AbUFLAV7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 20:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264426AbUFLAV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 20:21:59 -0400
Received: from mail.kroah.org ([65.200.24.183]:16839 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264422AbUFLAV5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 20:21:57 -0400
Date: Fri, 11 Jun 2004 17:13:03 -0700
From: Greg KH <greg@kroah.com>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clarify pci.txt wrt IRQ allocation
Message-ID: <20040612001302.GA10294@kroah.com>
References: <200406111529.16419.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406111529.16419.bjorn.helgaas@hp.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2004 at 03:29:16PM -0600, Bjorn Helgaas wrote:
> I think we should make it explicit that PCI IRQs shouldn't be relied
> upon until after pci_enable_device().  This patch:
> 
>     ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7-rc3/2.6.7-rc3-mm1/broken-out/bk-acpi.patch
> 
> does PCI interrupt routing (based on ACPI _PRT) and IRQ allocation
> at pci_enable_device()-time.
> 
> (To avoid breaking things in 2.6, the above patch still allocates
> all PCI IRQs in pci_acpi_init(), before any drivers are initialized.
> But that shouldn't be needed by correct drivers, and I'd like to
> remove it in 2.7.)

I agree.

> Here's a possible update:

Thanks, I've applied this to my trees.

greg k-h
