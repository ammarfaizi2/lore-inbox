Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266176AbRF2Uiw>; Fri, 29 Jun 2001 16:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266178AbRF2Uim>; Fri, 29 Jun 2001 16:38:42 -0400
Received: from [216.101.162.242] ([216.101.162.242]:36518 "EHLO
	pizda.ninka.net") by vger.kernel.org with ESMTP id <S266176AbRF2Uif>;
	Fri, 29 Jun 2001 16:38:35 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15164.59159.645521.383074@pizda.ninka.net>
Date: Fri, 29 Jun 2001 13:37:43 -0700 (PDT)
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jes@sunsite.dk (Jes Sorensen), bcrl@redhat.com (Ben LaHaise),
        hiren_mehta@agilent.com ("MEHTA,HIREN (A-SanJose,ex1)"),
        linux-kernel@vger.kernel.org ('linux-kernel@vger.kernel.org')
Subject: Re: (reposting) how to get DMA'able memory within 4GB on 64-bit m achi ne
In-Reply-To: <E15Fv14-0008TB-00@the-village.bc.nu>
In-Reply-To: <15164.18270.460245.219060@pizda.ninka.net>
	<E15Fv14-0008TB-00@the-village.bc.nu>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan Cox writes:
 > > And when the IOMMU is "full" what happens to all the SAC only
 > > cards in the machine?  pci_map_{single,sg}() are not allowed
 > > to fail.
 > 
 > Thats something we already know has to be fixed. Its true with or without
 > an IOMMU that there may be cases where there is no free mapping space

True, but my intended point is that starving the SAC-only users then
returning DAC addresses to DAC-capable devices is just as unacceptable.

When we have one of these compute cluster cards in the box, and Jes's
suggested algorithm is used, the rest of the SAC devices in the box
would be totally screwed once the IOMMU fills up.

Later,
David S. Miller
davem@redhat.com
