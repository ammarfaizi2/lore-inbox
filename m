Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265783AbUBBTUx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 14:20:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265795AbUBBTUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 14:20:53 -0500
Received: from mail.kroah.org ([65.200.24.183]:20185 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265783AbUBBTUv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 14:20:51 -0500
Date: Mon, 2 Feb 2004 11:02:14 -0800
From: Greg KH <greg@kroah.com>
To: Deepak Saxena <dsaxena@plexity.net>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replace pci_pool with generic dma_pool
Message-ID: <20040202190214.GA31303@kroah.com>
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

Ok, I've applied these patches to my trees.  I did merge your first and
second patches into 1 patch so bitkeeper would show that you just moved
the pool.c file from one directory to another, which keeps the file
history correct.

I'll forward them off to Linus after 2.6.2 comes out.

thanks,

greg k-h
