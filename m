Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130893AbRBLTGq>; Mon, 12 Feb 2001 14:06:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130251AbRBLTGh>; Mon, 12 Feb 2001 14:06:37 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:16 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S130893AbRBLTGE>;
	Mon, 12 Feb 2001 14:06:04 -0500
To: Gérard Roudier <groudier@club-internet.fr>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Ion Badulescu <ionut@cs.columbia.edu>,
        Alan Cox <alan@redhat.com>, Donald Becker <becker@scyld.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] starfire reads irq before pci_enable_device.
In-Reply-To: <Pine.LNX.4.10.10102100932360.1117-100000@linux.local>
From: Jes Sorensen <jes@linuxcare.com>
Date: 12 Feb 2001 20:01:48 +0100
In-Reply-To: Gérard Roudier's message of "Sat, 10 Feb 2001 09:48:41 +0100 (CET)"
Message-ID: <d3n1brafoj.fsf@lxplus015.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Gérard" == Gérard Roudier <groudier@club-internet.fr> writes:

Gérard> On Fri, 9 Feb 2001, Alan Cox wrote:

>> DMA to main memory normally invalidates those lines in the CPU
>> cache rather than the cache snooping and updating its view of them.

Gérard> In PCI, it is the Memory Write and Invalidate PCI transaction
Gérard> that is intended to allow core-logics to optimize DMA this
Gérard> way. For normal Memory Write PCI transactions or when the
Gérard> core-logic is aliasing MWI to MW, the snooping may well
Gérard> happen. All that stuff, very probably, varies a lot depending
Gérard> on the core-logic.

In fact one has to look out for this and disable the feature in some
cases. On the acenic not disabling Memory Write and Invalidate costs
~20% on performance on some systems.

Jes
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
