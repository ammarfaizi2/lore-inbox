Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129072AbRBIVxK>; Fri, 9 Feb 2001 16:53:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129448AbRBIVwv>; Fri, 9 Feb 2001 16:52:51 -0500
Received: from cs.columbia.edu ([128.59.16.20]:5085 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S129072AbRBIVwJ>;
	Fri, 9 Feb 2001 16:52:09 -0500
Date: Fri, 9 Feb 2001 13:52:01 -0800 (PST)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Jes Sorensen <jes@linuxcare.com>
cc: Manfred Spraul <manfred@colorfullife.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, Alan Cox <alan@redhat.com>,
        <linux-kernel@vger.kernel.org>, Donald Becker <becker@scyld.com>
Subject: Re: [PATCH] starfire reads irq before pci_enable_device.
In-Reply-To: <d38znfwmzq.fsf@lxplus015.cern.ch>
Message-ID: <Pine.LNX.4.30.0102091349410.31024-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 Feb 2001, Jes Sorensen wrote:

> Manfred> What about changing the default for rx_copybreak instead?
> Manfred> Set it to 1536 on ia64 and Alpha, 0 for the rest.  tulip and
> Manfred> eepro100 use that aproach.
> 
> Inefficient, my patch will make the unused code path disappear during
> compilation, what you suggest results in an extra branch and unused
> code.

Yes, but I'd rather let people turn off the always-copy behavior by simply 
changing rx_copybreak. The unused code is not really that much of a deal, 
it's only a few lines.

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
