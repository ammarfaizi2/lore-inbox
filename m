Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267949AbTB1PUM>; Fri, 28 Feb 2003 10:20:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267951AbTB1PTw>; Fri, 28 Feb 2003 10:19:52 -0500
Received: from ns.suse.de ([213.95.15.193]:27149 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S267949AbTB1PTo>;
	Fri, 28 Feb 2003 10:19:44 -0500
Date: Fri, 28 Feb 2003 16:30:00 +0100
From: Andi Kleen <ak@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andi Kleen <ak@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Matthew Wilcox <willy@debian.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Proposal: Eliminate GFP_DMA
Message-ID: <20030228153000.GA17745@wotan.suse.de>
References: <20030228064631.G23865@parcelfarce.linux.theplanet.co.uk.suse.lists.linux.kernel> <p73heao7ph2.fsf@amdsimf.suse.de> <20030228141234.H23865@parcelfarce.linux.theplanet.co.uk> <1046445897.16599.60.camel@irongate.swansea.linux.org.uk> <20030228143405.I23865@parcelfarce.linux.theplanet.co.uk> <1046447737.16599.83.camel@irongate.swansea.linux.org.uk> <20030228145614.GA27798@wotan.suse.de> <20030228152502.GA32449@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030228152502.GA32449@gtf.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That's a bit broken...  I have an ALS4000 PCI soundcard that is a 24-bit
> soundcard.  pci_set_dma_mask should support 24-bits accordingly,
> otherwise it's a bug in your platform implementation...  Nobody will be
> able to use certain properly-written drivers on your platform otherwise.

It supports it for pci_alloc_consistent (by mapping it to an GFP_DMA
allocation)

Just for pci_map_single/pci_map_sg() it is not supported and will 
error out when the passed address doesn't fit the mask. That behaviour
is 100% compatible with IA32 which does the same. 

-Andi
