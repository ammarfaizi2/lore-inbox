Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265361AbTFFHFi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 03:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265365AbTFFHFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 03:05:38 -0400
Received: from palrel13.hp.com ([156.153.255.238]:23523 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S265361AbTFFHFi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 03:05:38 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16096.16492.286361.509747@napali.hpl.hp.com>
Date: Fri, 6 Jun 2003 00:19:08 -0700
To: "David S. Miller" <davem@redhat.com>
Cc: davidm@hpl.hp.com, manfred@colorfullife.com, axboe@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: problem with blk_queue_bounce_limit()
In-Reply-To: <20030605.235249.35666087.davem@redhat.com>
References: <16094.58952.941468.221985@napali.hpl.hp.com>
	<1054797653.18294.1.camel@rth.ninka.net>
	<16096.14281.621282.67906@napali.hpl.hp.com>
	<20030605.235249.35666087.davem@redhat.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Thu, 05 Jun 2003 23:52:49 -0700 (PDT), "David S. Miller" <davem@redhat.com> said:

  David> you're not setting PCI_DMA_BUS_IS_PHYS properly.  For IOMMU
  David> it should be set to zero.  This tells the block layer if
  David> you're IOMMU or not.

Ah, yes, thanks for pointing this out.

PCI_DMA_BUS_IS_PHYS (and it's description) is quite misleading: it
claims that it has something to do with there being an equivalence
between PCI bus and physical addresses.  That's actually the case for
(small) ia64 platforms so that's why we ended up setting it to 1.

	--david
