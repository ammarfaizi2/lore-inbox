Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136497AbREIO36>; Wed, 9 May 2001 10:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136496AbREIO3u>; Wed, 9 May 2001 10:29:50 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:11867 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S136497AbREIO3j>; Wed, 9 May 2001 10:29:39 -0400
Date: Wed, 9 May 2001 16:29:28 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Cabaniols, Sebastien" <Sebastien.Cabaniols@Compaq.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] memory mngt > 2 Gbytes and DMA for the Alpha? pci_iommu.c
Message-ID: <20010509162928.M2506@athlon.random>
In-Reply-To: <1FF17ADDAC64D0119A6E0000F830C9EA04B3CDE0@aeoexc1.aeo.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1FF17ADDAC64D0119A6E0000F830C9EA04B3CDE0@aeoexc1.aeo.cpqcorp.net>; from Sebastien.Cabaniols@Compaq.com on Wed, May 09, 2001 at 04:12:41PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 09, 2001 at 04:12:41PM +0200, Cabaniols, Sebastien wrote:
> Hi lkml,
> 
> There is likely a bug in the management of memory above two Gigabytes and
> DMA in kernel 2.4.4
> (up to ac-6) with the alpha. :-(

remeber why last yaer I was advocating a CONFIG_HIGHMEM option also in
2.4 and not only in 2.2? If we had that now I would tell you "set
HIGHMEM to y until we fix it" and you could use more up to terabyte of
ram in the meantime.

> When I boot the system with mem=2048M, everything is back... network,
> storage...

can you try to set DEBUG_NODIRECT to 1 in pci_iommu.c and then to boot
with mem=2048M, if you can reproduce I should be able to reproduce too.

Andrea
