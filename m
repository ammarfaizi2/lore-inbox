Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130664AbRBLS40>; Mon, 12 Feb 2001 13:56:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131029AbRBLS4I>; Mon, 12 Feb 2001 13:56:08 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:3341 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S130664AbRBLSzq>;
	Mon, 12 Feb 2001 13:55:46 -0500
To: Ion Badulescu <ionut@cs.columbia.edu>
Cc: Manfred Spraul <manfred@colorfullife.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, Alan Cox <alan@redhat.com>,
        <linux-kernel@vger.kernel.org>, Donald Becker <becker@scyld.com>
Subject: Re: [PATCH] starfire reads irq before pci_enable_device.
In-Reply-To: <Pine.LNX.4.30.0102091349410.31024-100000@age.cs.columbia.edu>
From: Jes Sorensen <jes@linuxcare.com>
Date: 12 Feb 2001 19:54:57 +0100
In-Reply-To: Ion Badulescu's message of "Fri, 9 Feb 2001 13:52:01 -0800 (PST)"
Message-ID: <d3vgqfafzy.fsf@lxplus015.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Ion" == Ion Badulescu <ionut@cs.columbia.edu> writes:

Ion> On 9 Feb 2001, Jes Sorensen wrote:
>>  Inefficient, my patch will make the unused code path disappear
>> during compilation, what you suggest results in an extra branch and
>> unused code.

Ion> Yes, but I'd rather let people turn off the always-copy behavior
Ion> by simply changing rx_copybreak. The unused code is not really
Ion> that much of a deal, it's only a few lines.

However, it is in the hot path code where it hurts the most.

Jes
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
