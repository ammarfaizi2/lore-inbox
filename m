Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290228AbSBKTVj>; Mon, 11 Feb 2002 14:21:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290223AbSBKTVb>; Mon, 11 Feb 2002 14:21:31 -0500
Received: from mail.libertysurf.net ([213.36.80.91]:43813 "EHLO
	mail.libertysurf.net") by vger.kernel.org with ESMTP
	id <S290216AbSBKTVR> convert rfc822-to-8bit; Mon, 11 Feb 2002 14:21:17 -0500
Date: Sun, 10 Feb 2002 21:20:05 +0100 (CET)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Pete Zaitcev <zaitcev@redhat.com>, <stodden@in.tum.de>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: pci_pool reap?
In-Reply-To: <E16a6sw-0005Jw-00@the-village.bc.nu>
Message-ID: <20020210211352.Q1910-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 11 Feb 2002, Alan Cox wrote:

> > There is a certain controversy about pci_free_consistent called
> > from an interrupt. It seems that most architectures would
> > have no problems, and only arm is problematic. RMK says that
>
> The discussion was about pci_alloc_consistent. The free case seems to be
> explicitly disallowed in all cases.
>
> (from DMA-mapping.txt)
>
> To unmap and free such a DMA region, you call:
>
>         pci_free_consistent(dev, size, cpu_addr, dma_handle);
>
> where dev, size are the same as in the above call and cpu_addr and
> dma_handle are the values pci_alloc_consistent returned to you.
> This function may not be called in interrupt context.

Such limitation looks poor implementation to me.

At least, could existing driver interface be clearly documented about what
methods may/may not/might/should/shall/ever will/never will/ etc.. be
called in interrupt context or whatever context and what others may be
called...
                 ...in a different way :-).

  Gérard.

