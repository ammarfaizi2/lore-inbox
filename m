Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261975AbREUILx>; Mon, 21 May 2001 04:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261983AbREUILn>; Mon, 21 May 2001 04:11:43 -0400
Received: from pizda.ninka.net ([216.101.162.242]:13729 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261975AbREUILf>;
	Mon, 21 May 2001 04:11:35 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15112.52655.885447.500126@pizda.ninka.net>
Date: Mon, 21 May 2001 01:11:27 -0700 (PDT)
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: andrewm@uow.edu.au (Andrew Morton), andrea@suse.de (Andrea Arcangeli),
        ink@jurassic.park.msu.ru (Ivan Kokshaysky),
        rth@twiddle.net (Richard Henderson), linux-kernel@vger.kernel.org
Subject: Re: alpha iommu fixes
In-Reply-To: <E151kf4-0003TY-00@the-village.bc.nu>
In-Reply-To: <15112.51569.744590.398000@pizda.ninka.net>
	<E151kf4-0003TY-00@the-village.bc.nu>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan Cox writes:
 > Pages allocated in main memory and mapped for access by PCI devices. On some
 > HP systems there is now way for such a page to stay coherent. It is quite
 > possible to sync the view but there is no sane way to allow any
 > pci_alloc_consistent to succeed

This is not what the HP folk told me, and in fact they said that
pci_alloc_consistent could be made to work via disabling the cache
attribute in the cpu side mappings or something similar in the PCI
controller IOMMU mappings.

Please someone on the HPPA team provide details :-)

Later,
David S. Miller
davem@redhat.com
