Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270336AbTGNOtx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 10:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270465AbTGNOtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 10:49:53 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:65002
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S270336AbTGNOtr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 10:49:47 -0400
Date: Mon, 14 Jul 2003 11:04:35 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Michael Frank <mflt1@micrologica.com.hk>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@suse.cz>, John Belmonte <jvb@prairienet.org>
Subject: Re: 2.5.75-mm1 yenta-socket lsPCI IRQ reads incorrect
Message-ID: <20030714150435.GB5118@gtf.org>
References: <200307141333.03911.mflt1@micrologica.com.hk> <200307141725.27304.mflt1@micrologica.com.hk> <20030714120134.A18177@flint.arm.linux.org.uk> <200307141937.29584.mflt1@micrologica.com.hk> <20030714155051.A31395@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030714155051.A31395@flint.arm.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 14, 2003 at 03:50:51PM +0100, Russell King wrote:
>  	yenta_allocate_resources(socket);
> +
> +	pci_save_state(dev, socket->saved_state);
>  
>  	socket->cb_irq = dev->irq;
>  


This reminds me, PCI Express makes the PCI config area larger, going
from 256 bytes to either 4K or 64K IIRC.

I wonder if we want new pci_{save,restore}_xstate functions?
Or change the pci_{save,restore}_state API now to work with larger
config areas?

Intel probably has some patches internally for this, I bet.

	Jeff



