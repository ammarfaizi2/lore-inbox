Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291472AbSBMJkO>; Wed, 13 Feb 2002 04:40:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291473AbSBMJkF>; Wed, 13 Feb 2002 04:40:05 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23310 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291472AbSBMJjr>;
	Wed, 13 Feb 2002 04:39:47 -0500
Message-ID: <3C6A342C.E2123369@zip.com.au>
Date: Wed, 13 Feb 2002 01:38:52 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre9-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, lkml <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@uni-koblenz.de>
Subject: Re: [patch] printk and dma_addr_t
In-Reply-To: <E16avu8-0004lh-00@the-village.bc.nu> <3C6A331A.2D793119@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> Alan Cox wrote:
> >
> > > dma_addr_t type.   So the above usage will become
> > >
> > >       printk("stuff: " DMA_ADDR_T_FMT " %s", a, s);
> >
> > Vomit. How about adding a dma_addr_t %code to the printk function ?
> 
> heh, my comment on the patch was, "about as good as you can do without
> teaching printk and gcc about the type"

we could do:

	char *format_dma_addr_t(char *buf, dma_addr_t a);

-
