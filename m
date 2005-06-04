Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbVFDUHs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbVFDUHs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 16:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261247AbVFDUHr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 16:07:47 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:46098 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261232AbVFDUHh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 16:07:37 -0400
Date: Sat, 4 Jun 2005 21:07:33 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Support for read-only MMC cards
Message-ID: <20050604210733.B23449@flint.arm.linux.org.uk>
Mail-Followup-To: Pierre Ossman <drzeus-list@drzeus.cx>,
	LKML <linux-kernel@vger.kernel.org>
References: <42A2070D.9060608@drzeus.cx> <20050604205810.A23449@flint.arm.linux.org.uk> <42A2096C.9010108@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <42A2096C.9010108@drzeus.cx>; from drzeus-list@drzeus.cx on Sat, Jun 04, 2005 at 10:05:00PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 04, 2005 at 10:05:00PM +0200, Pierre Ossman wrote:
> Russell King wrote:
> >I'd prefer this to be:
> >
> >	printk(KERN_INFO "%s: %s %s %dKiB%s\n",
> > 		md->disk->disk_name, mmc_card_id(card), mmc_card_name(card),
> > 		(card->csd.capacity << card->csd.read_blkbits) / 1024,
> >		card->csd.cmdclass & CCC_BLOCK_WRITE ? "" : " (ro)");
> >
> >  
> >
> 
> I'd rather not since the SD patches have a similar test but on a
> different condition.

That's just a case of adding another %s and ?:.  I'd really prefer it
to be done this way.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
