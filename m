Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263792AbUA3IqE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 03:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263742AbUA3IqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 03:46:04 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:29959 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263792AbUA3IqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 03:46:02 -0500
Date: Fri, 30 Jan 2004 08:45:21 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Adam Belay <ambx1@neo.rr.com>, greg@kroah.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] Remove uneeded resource structures from pci_dev
Message-ID: <20040130084521.A9894@flint.arm.linux.org.uk>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>, greg@kroah.com,
	linux-kernel@vger.kernel.org
References: <20040130004841.GA12473@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040130004841.GA12473@neo.rr.com>; from ambx1@neo.rr.com on Fri, Jan 30, 2004 at 12:48:41AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 30, 2004 at 12:48:41AM +0000, Adam Belay wrote:
> I changed FL_IRQRESOURCE to FL_NOIRQ.  Russell, could you provide any
> comments?  irq_resource and dma_resource are most likely
> remnants from when pci_dev was shared with pnp.

Unfortunately there isn't much I can say about this, other than it looks
like the right thing to do.

A lot of these PCI and PNP serial controllers are provided by various
people, and unfortunately no record was kept as to who has what hardware.
Of course, this makes testing these types of changes impossible.

So, the best thing I can suggest is to get the patch into Linus/akpm's
kernel and watch what happens.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
