Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270049AbTGNPHt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 11:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270411AbTGNPHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 11:07:49 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:38418 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S270049AbTGNPGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 11:06:53 -0400
Date: Mon, 14 Jul 2003 16:21:38 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Michael Frank <mflt1@micrologica.com.hk>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@suse.cz>, John Belmonte <jvb@prairienet.org>
Subject: Re: 2.5.75-mm1 yenta-socket lsPCI IRQ reads incorrect
Message-ID: <20030714162138.B31395@flint.arm.linux.org.uk>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Michael Frank <mflt1@micrologica.com.hk>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Pavel Machek <pavel@suse.cz>, John Belmonte <jvb@prairienet.org>
References: <200307141333.03911.mflt1@micrologica.com.hk> <200307141725.27304.mflt1@micrologica.com.hk> <20030714120134.A18177@flint.arm.linux.org.uk> <200307141937.29584.mflt1@micrologica.com.hk> <20030714155051.A31395@flint.arm.linux.org.uk> <20030714150435.GB5118@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030714150435.GB5118@gtf.org>; from jgarzik@pobox.com on Mon, Jul 14, 2003 at 11:04:35AM -0400
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 14, 2003 at 11:04:35AM -0400, Jeff Garzik wrote:
> On Mon, Jul 14, 2003 at 03:50:51PM +0100, Russell King wrote:
> >  	yenta_allocate_resources(socket);
> > +
> > +	pci_save_state(dev, socket->saved_state);
> >  
> >  	socket->cb_irq = dev->irq;
> >  
> 
> This reminds me, PCI Express makes the PCI config area larger, going
> from 256 bytes to either 4K or 64K IIRC.
> 
> I wonder if we want new pci_{save,restore}_xstate functions?
> Or change the pci_{save,restore}_state API now to work with larger
> config areas?

Maybe we really want an API where you can pass in the size of your
buffer (which also determines how much gets saved) ?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

