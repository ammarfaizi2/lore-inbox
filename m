Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261829AbSKTWAA>; Wed, 20 Nov 2002 17:00:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262806AbSKTV76>; Wed, 20 Nov 2002 16:59:58 -0500
Received: from berta.E-Technik.Uni-Dortmund.DE ([129.217.182.12]:25096 "HELO
	kt.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S261829AbSKTV7w>; Wed, 20 Nov 2002 16:59:52 -0500
Date: Wed, 20 Nov 2002 23:06:55 +0100
From: Wolfgang Wegner <ww@kt.e-technik.uni-dortmund.de>
To: Jules Kongslie <chatos@omgwallhack.org>
Cc: Karen Shaeffer <shaeffer@neuralscape.com>, linux-kernel@vger.kernel.org
Subject: Re: Prism 2.5 Wavelan chipset
Message-ID: <20021120230655.A5805@bigmac.e-technik.uni-dortmund.de>
References: <20021119153059.A5143@synapse.neuralscape.com> <1037826932.7092.6.camel@cassius.omgwallhack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1037826932.7092.6.camel@cassius.omgwallhack.org>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

concerning all intersil-based cards, the linux-wlan-ng driver seems much
more efficient than the in-kernel or pcmcia-cs code. However, linux-wlan-ng
supports only prism cards.

In general, if you have a low-performance machine, go for a real PCI card
(like one of those mini-pci boards on a pci adaptor card, like the Tekram
PC-400 or what it's name is). The pcmcia cards (at least those non-cardbus,
i did not have my hands on a cardbus card yet) impose a great load on the
machine for transferring the data over the "ISA" bus.
(That's another big problem of the in-kernel and pcmcia-cs "orinoco" drivers:
for full-size packets, interrupts are blocked for almost 1ms for every
packet. Not a problem on a GHz machine, but ugly on a 75MHz pentium 8) )

Regards,
Wolfgang

