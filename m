Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131324AbRAFPwI>; Sat, 6 Jan 2001 10:52:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130267AbRAFPvr>; Sat, 6 Jan 2001 10:51:47 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:17419 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129857AbRAFPvi>; Sat, 6 Jan 2001 10:51:38 -0500
Subject: Re: [patch] drivers/net/359x.c
To: andrewm@uow.edu.au (Andrew Morton)
Date: Sat, 6 Jan 2001 15:53:32 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org (lkml)
In-Reply-To: <3A5711AB.D258FEB5@uow.edu.au> from "Andrew Morton" at Jan 06, 2001 11:38:03 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Evex-0001Cr-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> - Added a hack to override the PCI latency timer for 3c590's (merge
>   from Donald's drivers)

I suppose I should sort the pci quirk for that one out too some day. Some 
chipsets (SIS5598 and some other onboard pci video stuff) sulk with a large
pci latency

> - Added (vastly) extended busywait for command completion for the 3c905CX.
>   and module unload, I don't want to add scheduling to 3c59x's
>   open() method.

Nod

> - Don't free skbs we don't own on OOM path in vortex_open().
> 
>   This bug is probably fatal.  If the interface is opened
>   and it hits an out-of-memory in the right place we end
>   up passing NULL or old pointers to kfree_skb().

Whoops 8)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
