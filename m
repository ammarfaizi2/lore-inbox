Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261713AbVFGEVM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261713AbVFGEVM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 00:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261715AbVFGEVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 00:21:12 -0400
Received: from colo.lackof.org ([198.49.126.79]:64437 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S261713AbVFGEVG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 00:21:06 -0400
Date: Mon, 6 Jun 2005 22:24:42 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Greg KH <gregkh@suse.de>, "David S. Miller" <davem@davemloft.net>,
       tom.l.nguyen@intel.com, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, roland@topspin.com
Subject: Re: pci_enable_msi() for everyone?
Message-ID: <20050607042442.GA12781@colo.lackof.org>
References: <20050603224551.GA10014@kroah.com> <20050605.124612.63111065.davem@davemloft.net> <20050606225548.GA11184@suse.de> <42A4D771.7080400@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42A4D771.7080400@pobox.com>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2005 at 07:08:33PM -0400, Jeff Garzik wrote:
> Not only the differences DaveM mentioned, but also simply that you may 
> assume your interrupt is not shared with anyone else.

I had the impression the CPU vector could be shared.
But PCI 2.3 spec says:
| An MSI is by definition a non-shared interrupt that enforces data
| consistency (ensures the iterrupt service routine accesses the most
| recent data). The system guarantees that any data written by the
| device prior to sending the MSI has reached its final destination
| before the interrupt service routine accesses that data. Therefore,
| a device driver is not required to read its device before servicing
| its MSI.


I guess that's pretty clear....

grant
