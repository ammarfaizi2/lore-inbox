Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278594AbRJSSvY>; Fri, 19 Oct 2001 14:51:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278595AbRJSSvP>; Fri, 19 Oct 2001 14:51:15 -0400
Received: from mail.cogenit.fr ([195.68.53.173]:64435 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S278594AbRJSSvB>;
	Fri, 19 Oct 2001 14:51:01 -0400
Date: Fri, 19 Oct 2001 20:51:31 +0200
From: Francois Romieu <romieu@cogenit.fr>
To: "MEHTA,HIREN (A-SanJose,ex1)" <hiren_mehta@agilent.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: pci_alloc_consistent question
Message-ID: <20011019205131.B14409@se1.cogenit.fr>
In-Reply-To: <01A7DAF31F93D511AEE300D0B706ED9208E4A1@axcs13.cos.agilent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01A7DAF31F93D511AEE300D0B706ED9208E4A1@axcs13.cos.agilent.com>; from hiren_mehta@agilent.com on Fri, Oct 19, 2001 at 12:32:19PM -0600
X-Organisation: Marie's fan club - II
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MEHTA,HIREN (A-SanJose,ex1) <hiren_mehta@agilent.com> :
[...]
> Is there any limitation on the amount of contiguous dmaable memory that
> can be allocated using a single call to pci_alloc_consistent() ?

See comment in arch/i386/kernel/pci-dma.c for pc world:
/*
 * Dynamic DMA mapping support.
 *
 * On i386 there is no hardware dynamic DMA address translation,
 * so consistent alloc/free are merely page allocation/freeing.
[...]

It fails as __get_free_pages does.

-- 
Ueimor
