Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129493AbQKFJko>; Mon, 6 Nov 2000 04:40:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129207AbQKFJkf>; Mon, 6 Nov 2000 04:40:35 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:39950
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S129493AbQKFJkZ>; Mon, 6 Nov 2000 04:40:25 -0500
Date: Mon, 6 Nov 2000 01:40:09 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Neil Brown <neilb@cse.unsw.edu.au>, ryan <ryan@netidea.com>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: Kernel 2.4.0test10 crash (RAID+SMP)
In-Reply-To: <3A067318.E9C6ADDF@mandrakesoft.com>
Message-ID: <Pine.LNX.4.10.10011060138320.14903-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Nov 2000, Jeff Garzik wrote:

> Neil Brown wrote:
> > It looks like an interupt is happening while another interrupt is
> > happening, which should be impossible... but it isn't.
> 
> If multiple interrupts are hitting a single code path (like IDE irqs 14
> -and- 15), you definitely have to think about that.  The reentrancy
> guarantee only exists when a single IRQ is assigned to a single
> handler...
Jeff,

This is likely the classic case where the driver hangs on to the global
lock way to lock because it is grabbed to early wrt what I am changing the
behavior to...

Cheers,

Andre Hedrick
CTO Timpanogas Research Group
EVP Linux Development, TRG
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
