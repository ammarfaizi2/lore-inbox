Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129764AbRCAVLN>; Thu, 1 Mar 2001 16:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130037AbRCAVII>; Thu, 1 Mar 2001 16:08:08 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:1043 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S130016AbRCAVGe>;
	Thu, 1 Mar 2001 16:06:34 -0500
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: netdev@oss.sgi.com,
        Linux Knernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: New net features for added performance
In-Reply-To: <3A9842DC.B42ECD7A@mandrakesoft.com>
From: Jes Sorensen <jes@linuxcare.com>
Date: 01 Mar 2001 22:06:16 +0100
In-Reply-To: Jeff Garzik's message of "Sat, 24 Feb 2001 18:25:16 -0500"
Message-ID: <d3y9upurlj.fsf@lxplus015.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Jeff" == Jeff Garzik <jgarzik@mandrakesoft.com> writes:

Jeff> 1) Rx Skb recycling.  It would be nice to have skbs returned to
Jeff> the driver after the net core is done with them, rather than
Jeff> have netif_rx free the skb.  Many drivers pre-allocate a number
Jeff> of maximum-sized skbs into which the net card DMA's data.  If
Jeff> netif_rx returned the SKB instead of freeing it, the driver
Jeff> could simply flip the DescriptorOwned bit for that buffer,
Jeff> giving it immediately back to the net card.

Jeff> Advantages: A de-allocation immediately followed by a
Jeff> reallocation is eliminated, less L1 cache pollution during
Jeff> interrupt handling.  Potentially less DMA traffic between card
Jeff> and host.

Jeff> Disadvantages?

I already tried this with the AceNIC GigE driver some time ago, and
after Ingo came up with a per-CPU slab patch the gain was gone. I am
not sure the complexity is worth it.

Jes
