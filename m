Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261980AbREUIKd>; Mon, 21 May 2001 04:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261975AbREUIKN>; Mon, 21 May 2001 04:10:13 -0400
Received: from pizda.ninka.net ([216.101.162.242]:10657 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261941AbREUIKH>;
	Mon, 21 May 2001 04:10:07 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15112.52566.955443.247834@pizda.ninka.net>
Date: Mon, 21 May 2001 01:09:58 -0700 (PDT)
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: andrea@suse.de (Andrea Arcangeli), andrewm@uow.edu.au (Andrew Morton),
        ink@jurassic.park.msu.ru (Ivan Kokshaysky),
        rth@twiddle.net (Richard Henderson), linux-kernel@vger.kernel.org
Subject: Re: alpha iommu fixes
In-Reply-To: <E151kbW-0003T4-00@the-village.bc.nu>
In-Reply-To: <15112.47990.828744.956717@pizda.ninka.net>
	<E151kbW-0003T4-00@the-village.bc.nu>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan Cox writes:
 > Ok how about a PIV Xeon with 64Gb of memory and 5 AMI Megaraids, which are
 > limited to the low 2Gb range for pci mapping and otherwise need bounce buffers.
 > Or how about any consistent alloc on certain HP machines which totally lack
 > coherency - also I suspect the R10K on an O2 might fall into that - Ralf ?

If they need bounce buffers because of a device specific DMA range
limitation (this is what I gather this is), then the PCI dma interface
is of no help to this case.

 > Look at the history of kernel API's over time. Everything that can
 > go wrong eventually does.

I agree, and it will be dealt with in 2.5.x

The scsi layer in 2.4.x is simply not able to handle failure in these
code paths, as Gerard Roudier has mentioned.

Later,
David S. Miller
davem@redhat.com
