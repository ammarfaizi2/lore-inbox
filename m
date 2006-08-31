Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932309AbWHaNtO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbWHaNtO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 09:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932316AbWHaNtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 09:49:14 -0400
Received: from cantor.suse.de ([195.135.220.2]:3012 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932309AbWHaNtN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 09:49:13 -0400
To: Matt Porter <mporter@embeddedalley.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       gregkh@suse.de
Subject: Re: [RFC] Simple userspace interface for PCI drivers
References: <20060830062338.GA10285@kroah.com>
	<20060830143410.GB19477@gate.crashing.org>
From: Andi Kleen <ak@suse.de>
Date: 31 Aug 2006 15:49:10 +0200
In-Reply-To: <20060830143410.GB19477@gate.crashing.org>
Message-ID: <p73pseh582x.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Porter <mporter@embeddedalley.com> writes:
> 
> What about portable access to the PCI DMA API from userspace? 

We'll definitely need this for X11 anyways. Currently it is not
possible to run the standard X server with a IOMMU that isolates
the graphics card because it has no way to get at the GPU MMIO
registers then.

My long-term plan was to integrate it in /sys/bus/pci mmaps
(together with PAT etc.). When you mmap it there the kernel
allocates a DMA mapping and then frees it on unmap.

Then it should hopefully just work.

-Andi
