Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282597AbRLDSOK>; Tue, 4 Dec 2001 13:14:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281505AbRLDSMt>; Tue, 4 Dec 2001 13:12:49 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:20936 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S283207AbRLDRn1>;
	Tue, 4 Dec 2001 12:43:27 -0500
From: David Mosberger <davidm@hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15373.2854.619707.822462@napali.hpl.hp.com>
Date: Tue, 4 Dec 2001 09:43:02 -0800
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: tony.luck@intel.com, arjanv@redhat.com (Arjan van de Ven),
        linux-kernel@vger.kernel.org, linux-ia64@linuxia64.org,
        marcelo@conectiva.com.br, davem@redhat.com, davidm@hpl.hp.com
Subject: Re: [Linux-ia64] patch to no longer use ia64's software mmu
In-Reply-To: <E16BJCz-0002jc-00@the-village.bc.nu>
In-Reply-To: <15372.63827.716885.948119@napali.hpl.hp.com>
	<E16BJCz-0002jc-00@the-village.bc.nu>
X-Mailer: VM 6.76 under Emacs 20.4.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 4 Dec 2001 17:18:17 +0000 (GMT), Alan Cox <alan@lxorguk.ukuu.org.uk> said:

  >> I think the issue at hand is whether, longer term, it is
  >> desirable to move all bounce buffer handling into the PCI DMA
  >> layer or whether Linux should continue to make bounce buffer
  >> management visible to drivers.  I'd be interested in hearing
  >> opinions.

  Alan> I think the performance figures we see currently answer that
  Alan> already.

The numbers I have seen so far don't make this obvious.  Tony Luck
reports 95Mbps with a CPU load of 20% after a fixing a performance bug
in the software I/O TLB.  Arjan reported the same 95Mbps figure with
the highmem approach.  Arjan didn't report the CPU load and neither
Tony nor Arjan specified the test environment they were using.

  Alan> IA64 also needs to correct its GFP_DMA to mean "low 16Mb" for
  Alan> ISA DMA. While there is no ISA DMA on ia64 (thankfully) many
  Alan> PCI cards have 26-31 bit limits.

We could do this if we there was a GFP_4GB zone.  Now that 2.5 is open
for business, it won't be long, right?

	--david
