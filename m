Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129114AbRBMNHs>; Tue, 13 Feb 2001 08:07:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131313AbRBMNHi>; Tue, 13 Feb 2001 08:07:38 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:27432 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S131312AbRBMNHT> convert rfc822-to-8bit; Tue, 13 Feb 2001 08:07:19 -0500
Date: Tue, 13 Feb 2001 07:06:44 -0600 (CST)
From: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>
To: Jes Sorensen <jes@linuxcare.com>
cc: Gérard Roudier <groudier@club-internet.fr>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Donald Becker <becker@scyld.com>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] starfire reads irq before pci_enable_device.
In-Reply-To: <d3n1brafoj.fsf@lxplus015.cern.ch>
Message-ID: <Pine.LNX.3.96.1010213070337.31857F-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 Feb 2001, Jes Sorensen wrote:
> >>>>> "Gérard" == Gérard Roudier <groudier@club-internet.fr> writes:
> Gérard> In PCI, it is the Memory Write and Invalidate PCI transaction
> Gérard> that is intended to allow core-logics to optimize DMA this
> Gérard> way. For normal Memory Write PCI transactions or when the
> Gérard> core-logic is aliasing MWI to MW, the snooping may well
> Gérard> happen. All that stuff, very probably, varies a lot depending
> Gérard> on the core-logic.
> 
> In fact one has to look out for this and disable the feature in some
> cases. On the acenic not disabling Memory Write and Invalidate costs
> ~20% on performance on some systems.

And in another message, On Mon, 12 Feb 2001, David S. Miller wrote:
> 3) The acenic/gbit performance anomalies have been cured
>    by reverting the PCI mem_inval tweaks.


Just to be clear, acenic should or should not use MWI?

And can a general rule be applied here?  Newer Tulip hardware also
has the ability to enable/disable MWI usage, IIRC.

	Jeff




