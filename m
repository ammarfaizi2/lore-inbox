Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264444AbUAaApb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 19:45:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264451AbUAaApa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 19:45:30 -0500
Received: from mail.kroah.org ([65.200.24.183]:64711 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264444AbUAaApY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 19:45:24 -0500
Date: Fri, 30 Jan 2004 16:34:35 -0800
From: Greg KH <greg@kroah.com>
To: Adam Belay <ambx1@neo.rr.com>, Russell King <rmk@arm.linux.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] Remove uneeded resource structures from pci_dev
Message-ID: <20040131003435.GC10465@kroah.com>
References: <20040130004841.GA12473@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040130004841.GA12473@neo.rr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 30, 2004 at 12:48:41AM +0000, Adam Belay wrote:
> Hi,
> 
> The following patch remove irq_resource and dma_resource from pci_dev.  It
> appears that the serial pci driver depends on irq_resource, however, it may be
> broken portions of an old quirk.  I attempted to maintain the existing behavior
> while removing irq_resource.  I changed FL_IRQRESOURCE to FL_NOIRQ.  Russell,
> could you provide any comments?  irq_resource and dma_resource are most likely
> remnants from when pci_dev was shared with pnp.

Ok, I've added this to my PCI bk tree, which will end up in the next -mm
release.  If that seems to work ok, I'll send it to Linus (after
whenever 2.6.2 comes out...)

thanks,

greg k-h
