Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129027AbRBNBgV>; Tue, 13 Feb 2001 20:36:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129051AbRBNBgM>; Tue, 13 Feb 2001 20:36:12 -0500
Received: from cs.columbia.edu ([128.59.16.20]:47847 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S129027AbRBNBgG>;
	Tue, 13 Feb 2001 20:36:06 -0500
Date: Tue, 13 Feb 2001 17:35:56 -0800 (PST)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Jes Sorensen <jes@linuxcare.com>
cc: Manfred Spraul <manfred@colorfullife.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, Alan Cox <alan@redhat.com>,
        <linux-kernel@vger.kernel.org>, Donald Becker <becker@scyld.com>
Subject: Re: [PATCH] starfire reads irq before pci_enable_device.
In-Reply-To: <d3vgqfafzy.fsf@lxplus015.cern.ch>
Message-ID: <Pine.LNX.4.30.0102131715460.14404-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 Feb 2001, Jes Sorensen wrote:

> Ion> Yes, but I'd rather let people turn off the always-copy behavior
> Ion> by simply changing rx_copybreak. The unused code is not really
> Ion> that much of a deal, it's only a few lines.
> 
> However, it is in the hot path code where it hurts the most.

I couldn't measure any difference, really. And for one extra branch, I 
really wouldn't expect a measurable difference..

Not even defining final_version, which removes a *lot* more conditional
branches from the hot path, makes any measurable difference in the CPU
utilization.

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.


