Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283211AbRLDShU>; Tue, 4 Dec 2001 13:37:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283221AbRLDSfi>; Tue, 4 Dec 2001 13:35:38 -0500
Received: from zeus.kernel.org ([204.152.189.113]:30201 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S281659AbRLDSPk>;
	Tue, 4 Dec 2001 13:15:40 -0500
From: David Mosberger <davidm@hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15373.4756.967721.930336@napali.hpl.hp.com>
Date: Tue, 4 Dec 2001 10:14:44 -0800
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: davidm@hpl.hp.com, tony.luck@intel.com,
        arjanv@redhat.com (Arjan van de Ven), linux-kernel@vger.kernel.org,
        linux-ia64@linuxia64.org, marcelo@conectiva.com.br, davem@redhat.com
Subject: Re: [Linux-ia64] patch to no longer use ia64's software mmu
In-Reply-To: <E16BKAe-0002x7-00@the-village.bc.nu>
In-Reply-To: <15373.4236.462183.167170@napali.hpl.hp.com>
	<E16BKAe-0002x7-00@the-village.bc.nu>
X-Mailer: VM 6.76 under Emacs 20.4.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 4 Dec 2001 18:19:55 +0000 (GMT), Alan Cox <alan@lxorguk.ukuu.org.uk> said:

  Alan> I don't see the need: GFP_DMA is the ISA DMA zone. pci_* API
  Alan> is used by everyone else [for 2.5].
  >>  Without a 4GB zone, you may end up creating bounce buffers
  >> needlessly for 32-bit capable DMA devices, no?

  Alan> Yes - but it becomes an implementation detail. Drivers don't
  Alan> go around asking for kmalloc in 4Gb zone anymore they ask for
  Alan> PCI memory that a 32bit pci address can hit. I'm sure a 4Gb
  Alan> zone is what will be there internally but you don't need
  Alan> GFP_4GBZONE as a visible driver detail.

Oh, OK, we're in agreement then.  When I looked at the zone stuff the
last time, I didn't think you could have an internal 4GB zone without
abusing an existing zone making some changes to the header files in
linux/*.h, but perhaps I missed something.

	--david
