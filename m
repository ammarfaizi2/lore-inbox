Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281063AbRKDR6B>; Sun, 4 Nov 2001 12:58:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281064AbRKDR5x>; Sun, 4 Nov 2001 12:57:53 -0500
Received: from postfix1-2.free.fr ([213.228.0.130]:54913 "HELO
	postfix1-2.free.fr") by vger.kernel.org with SMTP
	id <S281063AbRKDR5g> convert rfc822-to-8bit; Sun, 4 Nov 2001 12:57:36 -0500
Date: Sun, 4 Nov 2001 16:12:01 +0100 (CET)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linux <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>
Subject: Re: SYM-2 patches against latest kernels available
In-Reply-To: <3BE564A4.D88D1951@mandrakesoft.com>
Message-ID: <20011104160540.X1663-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 4 Nov 2001, Jeff Garzik wrote:

> Gérard Roudier wrote:
> > The patch against linux-2.4.13 has been sent to Alan Cox for inclusion in
> > newer stable kernels. Alan wants to test it on his machines which is a
> > good thing. Anyway, those patches just add the new driver version to
> > kernel tree and leave stock sym53c8xx and ncr53c8xx in place.
>
> Are the older sym/ncr drivers going away in 2.5?
>
>
> > Any report, especially on large memory machines using 64 bit DMA (2.4
> > kernels + PCI DAC capable controllers only), is welcome. I can't test 64
> > bit DMA, since my fatest machine has only 512 MB of memory.
> >
> > To configure the driver, you must select "SYM53C8XX version 2 driver" from
> > kernel config. For large memory machines, a new "DMA addressing mode"
> > option is to be configured as follows (help texts have been added to
> > Configure.help):
> >
> > Value 0: 32 bit DMA addressing
> > Value 1: 40 bit DMA addressing (upper 24 bytes set to zero)
> > Value 2: 64 bit DMA addressing limited to 16 segments of 4 GB (64 GB) max.
>
> Are you using the new pci64 API under 2.4.x?

Didn't see any. Only the dma_addr_t thing can be 32 bit or 64 bit
depending on some magic. Apart this, the driver is asking for the
appropriate dma mask given the configured dma adressing mode.

  Gérard.

PS: There is some pci64* API on some arch., but nobody will want to
ever use it, in my opinion.

