Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932289AbWA0Ehe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932289AbWA0Ehe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 23:37:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932352AbWA0Ehe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 23:37:34 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:50664
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S932289AbWA0Ehd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 23:37:33 -0500
Date: Thu, 26 Jan 2006 20:37:34 -0800
From: Greg KH <greg@kroah.com>
To: "Miller, Mike (OS Dev)" <Mike.Miller@hp.com>
Cc: "Grundler, Grant G" <grant.grundler@hp.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: Problems with MSI-X on ia64
Message-ID: <20060127043734.GA32009@kroah.com>
References: <D4CFB69C345C394284E4B78B876C1CF10B8481F1@cceexc23.americas.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D4CFB69C345C394284E4B78B876C1CF10B8481F1@cceexc23.americas.cpqcorp.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2006 at 02:37:14PM -0600, Miller, Mike (OS Dev) wrote:
> > -----Original Message-----
> > From: Grundler, Grant G 
> > > We're using a 2.6.9 variant and a cciss driver with 
> > MSI/MSI-X support.
> > > The kernel has MSI enabled. On ia64 the MSI-X table is all zeroes.
> > 
> > Could you post the debug output you've collected so far?
> 
> There are 2 MSI-X capable controllers in the system. On IPF this is what
> the tables look like:
> 
> cciss: offset = 0xfe000 table offset = 0xfe000 BIR = 0x0
> cciss: 0: vector = 0,msg data = 0, msg upper addr = 0,msg addr = 0
> cciss: 1: vector = 0,msg data = 0, msg upper addr = 0,msg addr = 0
> cciss: 2: vector = 0,msg data = 0, msg upper addr = 0,msg addr = 0
> cciss: 3: vector = 0,msg data = 0, msg upper addr = 0,msg addr = 0
> cciss: using DAC cycles
> ACPI: PCI interrupt 0000:88:00.0[A] -> GSI 71 (level, low) -> IRQ 61
> cciss: MSI-X enabled
> cciss: offset = 0xfe000 table offset = 0xfe000 BIR = 0x0
> cciss: 0: vector = 0,msg data = 0, msg upper addr = 0,msg addr = 0
> cciss: 1: vector = 0,msg data = 0, msg upper addr = 0,msg addr = 0
> cciss: 2: vector = 0,msg data = 0, msg upper addr = 0,msg addr = 0
> cciss: 3: vector = 0,msg data = 0, msg upper addr = 0,msg addr = 0
> cciss: using DAC cycles
> blocks= 143305920 block_size= 512
> heads= 255, sectors= 32, cylinders= 17562
>  
> blocks= 142130880 block_size= 512
> heads= 255, sectors= 32, cylinders= 17418
>  
> cciss/c2d0:
> 
> And this is where we hang, when enabling interrupts in the driver.

Can you try 2.6.15, or possibly 2.6.16-rc1-mm3?

thanks,

greg k-h
