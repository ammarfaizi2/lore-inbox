Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275139AbRJJJac>; Wed, 10 Oct 2001 05:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275140AbRJJJaN>; Wed, 10 Oct 2001 05:30:13 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:31212 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S275139AbRJJJ37>; Wed, 10 Oct 2001 05:29:59 -0400
Date: Wed, 10 Oct 2001 11:30:25 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: =?iso-8859-1?q?willy=20tarreau?= <wtarreau@yahoo.fr>
cc: linux-kernel@vger.kernel.org, <acme@conectiva.com.br>
Subject: Re: Linux 2.4.10-ac10
In-Reply-To: <20011010092011.50158.qmail@web20501.mail.yahoo.com>
Message-ID: <Pine.NEB.4.40.0110101130050.28306-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Oct 2001, willy tarreau wrote:

> Adrian,
>
> I think this simple patch should solve your problem.
> It may have
> been a simple thinko replacing check_region with
> request_region.
>
> Cheers,
> Willy
>
> --- linux/drivers/sound/ad1816.c        Wed Oct 10
> 11:15:53 2001
> +++ linux/drivers/sound/ad1816.c        Wed Oct 10
> 11:16:12 2001
> @@ -1015,7 +1015,7 @@
>                options,
>                isa_dma_bridge_buggy);
>
> -       if (request_region(io_base, 16, "AD1816
> Sound")) {
> +       if (!request_region(io_base, 16, "AD1816
> Sound")) {
>                 printk(KERN_WARNING "ad1816: I/O port
> 0x%03x not free\n",
>                                     io_base);
>                 goto err;


Thanks, this fixed my problem!


cu
Adrian

-- 

Get my GPG key: finger bunk@debian.org | gpg --import

Fingerprint: B29C E71E FE19 6755 5C8A  84D4 99FC EA98 4F12 B400

