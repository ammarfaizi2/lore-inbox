Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261744AbUKALfJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbUKALfJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 06:35:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261754AbUKALfJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 06:35:09 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:33285 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261744AbUKALfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 06:35:03 -0500
Date: Mon, 1 Nov 2004 11:34:58 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: David Vrabel <dvrabel@arcom.com>
Cc: Greg KH <greg@kroah.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] PCI: Add is_bridge to pci_dev to allow fixups to disable bridge functionality.
Message-ID: <20041101113458.A2117@flint.arm.linux.org.uk>
Mail-Followup-To: David Vrabel <dvrabel@arcom.com>,
	Greg KH <greg@kroah.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <4174F909.1040804@arcom.com> <20041030032357.GA1441@kroah.com> <41861701.3020008@arcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <41861701.3020008@arcom.com>; from dvrabel@arcom.com on Mon, Nov 01, 2004 at 10:59:13AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 01, 2004 at 10:59:13AM +0000, David Vrabel wrote:
> Greg KH wrote:
> > On Tue, Oct 19, 2004 at 12:22:49PM +0100, David Vrabel wrote:
> > 
> >>The plan was to make the CardBus driver (drivers/pcmcia/yenta_socket.c) 
> >>honour the is_bridge flag and not bother with CardBus stuff if it's cleared.
> > 
> > But why can't any code that wants to check this, just look at the
> > dev->hdr_type instead?  I don't think we need to add a new bit for this
> > because of that, right?
> 
> Using the is_bridge flag allows PCI device fixups to disable the CardBus 
> portion of the driver.  And you obviously can't tweak the hdr_type since 
> the device header is still a CardBus/bridge type header.

Why not make the PCI spaces for cardbus bridges configurable?  Eg,

cardbusmem=1M cardbusio=8K

?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
