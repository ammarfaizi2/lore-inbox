Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281420AbRLDSIM>; Tue, 4 Dec 2001 13:08:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281147AbRLDSGs>; Tue, 4 Dec 2001 13:06:48 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:5323 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S281158AbRLDSGY>;
	Tue, 4 Dec 2001 13:06:24 -0500
From: David Mosberger <davidm@hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15373.4236.462183.167170@napali.hpl.hp.com>
Date: Tue, 4 Dec 2001 10:06:04 -0800
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: davidm@hpl.hp.com, tony.luck@intel.com,
        arjanv@redhat.com (Arjan van de Ven), linux-kernel@vger.kernel.org,
        linux-ia64@linuxia64.org, marcelo@conectiva.com.br, davem@redhat.com
Subject: Re: [Linux-ia64] patch to no longer use ia64's software mmu
In-Reply-To: <E16BJqq-0002qu-00@the-village.bc.nu>
In-Reply-To: <15373.2854.619707.822462@napali.hpl.hp.com>
	<E16BJqq-0002qu-00@the-village.bc.nu>
X-Mailer: VM 6.76 under Emacs 20.4.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 4 Dec 2001 17:59:28 +0000 (GMT), Alan Cox <alan@lxorguk.ukuu.org.uk> said:

  Alan> ISA DMA. While there is no ISA DMA on ia64 (thankfully) many
  Alan> PCI cards have 26-31 bit limits.
  >>  We could do this if we there was a GFP_4GB zone.  Now that 2.5
  >> is open for business, it won't be long, right?

  Alan> I don't see the need: GFP_DMA is the ISA DMA zone. pci_* API
  Alan> is used by everyone else [for 2.5].

Without a 4GB zone, you may end up creating bounce buffers needlessly
for 32-bit capable DMA devices, no?

	--david
