Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271715AbRHUPKH>; Tue, 21 Aug 2001 11:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271716AbRHUPJ5>; Tue, 21 Aug 2001 11:09:57 -0400
Received: from pizda.ninka.net ([216.101.162.242]:46494 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S271715AbRHUPJk>;
	Tue, 21 Aug 2001 11:09:40 -0400
Date: Tue, 21 Aug 2001 08:09:53 -0700 (PDT)
Message-Id: <20010821.080953.66175161.davem@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] PCI 64-bit API up for testing
From: "David S. Miller" <davem@redhat.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As discussed much of last week between Jens and myself,
we need a PCI 64-bit API to make progress in certain
areas.  It is needed for other reasons, but what Jens
is trying to solve exacerbates this need.

Jens's current highmem no-bounce patches include this
stuff, but we feel it is useful to distribute just these
changes independantly.  Especially for review and to acquire
help from port maintainers.

I held off until today because I wanted to convert a few
drivers first for two reasons:

1) To provide useful 64-bit driver examples.
2) To make sure the API worked and was usable.  A lot
   of details were not fleshed out until I actually tried
   to use the API I had initially created :-)

So this patch serves two purposes.  First, it's for review
and to get feedback from other hackers and driver authors.
Second, it is for platform authors so that they can send me
the updates for their port.

Most platforms which are simple and never have more than 4GB
ram will simply define the pci_*() routines to pci64_*(), make
pci_dac_cycles_ok() always return '0' and define dma64_addr_t
to be typedef'd to "u32".

If platform maintainers could do this and send me an incremental
diff, I would appreciate it.

Currently it is "ported" and tested on ix86 and Sparc64.

Get the latest at:

ftp://ftp.kernel.org/pub/linux/kernel/people/davem/PCI64/

I've moved the older zerocopy stuff, which used to be at
the top level under davem/, to:

ftp://ftp.kernel.org/pub/linux/kernel/people/davem/ZEROCOPY/

Later,
David S. Miller
davem@redhat.com
