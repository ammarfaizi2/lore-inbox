Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135616AbREIAxa>; Tue, 8 May 2001 20:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135617AbREIAxU>; Tue, 8 May 2001 20:53:20 -0400
Received: from pizda.ninka.net ([216.101.162.242]:42933 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S135616AbREIAxD>;
	Tue, 8 May 2001 20:53:03 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15096.38109.228916.621891@pizda.ninka.net>
Date: Tue, 8 May 2001 17:52:45 -0700 (PDT)
To: David Brownell <david-b@pacbell.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Pete Zaitcev <zaitcev@redhat.com>, johannes@erdfelt.com,
        rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: pci_pool_free from IRQ
In-Reply-To: <050701c0d80f$8f876ca0$6800000a@brownell.org>
In-Reply-To: <200105082108.f48L8X1154536@saturn.cs.uml.edu>
	<E14xFD5-0000hh-00@the-village.bc.nu>
	<15096.27479.707679.544048@pizda.ninka.net>
	<050701c0d80f$8f876ca0$6800000a@brownell.org>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


David Brownell writes:
 > Pete's patch to pci_pool_free() is fine with me, and I'd be glad
 > to see that bit of pci interface cleaned up.  Any changes needed
 > other than the pci.txt doc update?

Ummm... What Alan's saying is:

1) Whatever driver is trying to shut down from IRQ context
   is broken must be fixed.  pci_pool is fine.

2) The Documentation/ files which suggest that such device
   removal from IRQs is "OK" must be fixed because it is not
   "OK" to handle device removal from IRQ context.

So Pete's change is not needed.  A fix for the documentation and
broken drivers is needed instead.

Later,
David S. Miller
davem@redhat.com
