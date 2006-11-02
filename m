Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752713AbWKBH6x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752713AbWKBH6x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 02:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752726AbWKBH6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 02:58:53 -0500
Received: from brick.kernel.dk ([62.242.22.158]:34114 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1752713AbWKBH6w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 02:58:52 -0500
Date: Thu, 2 Nov 2006 09:00:41 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       John Stoffel <john@stoffel.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [git patches] libata fixes
Message-ID: <20061102080041.GW13555@kernel.dk>
References: <20061101021301.GA21568@havoc.gtf.org> <17736.43507.649685.484648@smtp.charter.net> <1162391435.11965.128.camel@localhost.localdomain> <20061101160207.6b5e4c29.akpm@osdl.org> <4549447D.5010500@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4549447D.5010500@garzik.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01 2006, Jeff Garzik wrote:
> Andrew Morton wrote:
> >On Wed, 01 Nov 2006 14:30:35 +0000
> >Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> >
> >>Ar Mer, 2006-11-01 am 09:06 -0500, ysgrifennodd John Stoffel:
> >>>Jeff> +	{ 0x8086, 0x7110, PCI_ANY_ID, PCI_ANY_ID, 0, 0, piix_pata_33 
> >>>},
> >>>Jeff>  	{ 0x8086, 0x7111, PCI_ANY_ID, PCI_ANY_ID, 0, 0, piix_pata_33 
> >>>},
> >>>
> >>>Umm, according to lspci -nn on my 440GX box, isn't the 0x8086/0x7110
> >>>an ISA bridge, not a PIIX? controller?  
> >>Correct - the 7110 doesn't belong on that list.
> >
> >So should it be moved elsewhere, or simply removed?
> 
> Well, according to Jens' own comment message, the PCI ID he needed was 
> already in the driver (my eyes didn't catch this).
> 
> It looks like it should be reverted, based on this thread and also the 
> patch's commit message itself.

I think so, I must have botched the lspci -> lspci -n read. I'll retest
and see what went wrong on this notebook, but I can definitely ack that
0x7110 is an isa bridge here as well.

-- 
Jens Axboe

