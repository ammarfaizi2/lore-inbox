Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264481AbUAaBFU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 20:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264488AbUAaBFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 20:05:20 -0500
Received: from mail.kroah.org ([65.200.24.183]:21710 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264481AbUAaBFP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 20:05:15 -0500
Date: Fri, 30 Jan 2004 17:05:15 -0800
From: Greg KH <greg@kroah.com>
To: Deepak Saxena <dsaxena@plexity.net>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replace pci_pool with generic dma_pool
Message-ID: <20040131010515.GH10860@kroah.com>
References: <20040131003205.GA24967@plexity.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040131003205.GA24967@plexity.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 30, 2004 at 05:32:05PM -0700, Deepak Saxena wrote:
> 
> All,
> 
> This set of patches against 2.6.2-rc2 removes the PCI-specific pci_pool 
> structure and replaces it with a generic dma_pool. For compatibility with 
> existing PCI drivers, macros are provided that map pci_pool_* to dma_pool_*.
> This is extremely useful for architecture that have non-PCI devices but 
> require DMA buffer pools. A good example is USB, where we've had to make
> some hacks in the ARM implementation of the DMA API to get around the
> USB's usage of the PCI DMA API and pci_pools with non-PCI device.
> The patch has been tested on x86, ppc, and xscale (ARM).
> 
> Patch portions are posted as replies to this email.
> 
> If this patch is accepted, I'll post a follow-on patch to the USB list 
> to clean up the USB layer to only use the generic DMA functions instead 
> of the PCI functions.

These patches look sane.  I'll apply them to my PCI tree this weekend,
which will propagate to the -mm tree.  If nothing breaks there, I'll
send them on to Linus after 2.6.2 comes out.

thanks a lot for this.

greg k-h
