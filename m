Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263027AbVGNNyN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263027AbVGNNyN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 09:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263029AbVGNNyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 09:54:04 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:12302 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263027AbVGNNxg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 09:53:36 -0400
Date: Thu, 14 Jul 2005 14:53:27 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       Jon Smirl <jonsmirl@gmail.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 2.6] remove PCI_BRIDGE_CTL_VGA handling from setup-bus.c
Message-ID: <20050714145327.B7314@flint.arm.linux.org.uk>
Mail-Followup-To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
	Jon Smirl <jonsmirl@gmail.com>, linux-pci@atrey.karlin.mff.cuni.cz,
	linux-kernel@vger.kernel.org
References: <20050714155344.A27478@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050714155344.A27478@jurassic.park.msu.ru>; from ink@jurassic.park.msu.ru on Thu, Jul 14, 2005 at 03:53:44PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2005 at 03:53:44PM +0400, Ivan Kokshaysky wrote:
> The setup-bus code doesn't work correctly for configurations
> with more than one display adapter in the same PCI domain.
> This stuff actually is a leftover of an early 2.4 PCI setup code
> and apparently it stopped working after some "bridge_ctl" changes.
> So the best thing we can do is just to remove it and rely on the fact
> that any firmware *has* to configure VGA port forwarding for the boot
> display device properly.

What happens when there is no firmware?

I'm sure this code would not have been added had there not been a reason
for it.  Do we know why it was added?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
