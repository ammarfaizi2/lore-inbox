Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932116AbVLIOPa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbVLIOPa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 09:15:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbVLIOPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 09:15:30 -0500
Received: from smtp2.brturbo.com.br ([200.199.201.158]:27525 "EHLO
	smtp2.brturbo.com.br") by vger.kernel.org with ESMTP
	id S932116AbVLIOP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 09:15:29 -0500
Subject: Re: [STABLE PATCH] V4L/DVB: Fix analog NTSC for Thomson DTT 761X
	hybrid tuner
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
To: Michael Krufky <mkrufky@gmail.com>
Cc: stable@kernel.org, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <43991E34.60503@gmail.com>
References: <43991E34.60503@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: Fri, 09 Dec 2005 11:57:29 -0200
Message-Id: <1134136649.10677.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2-1mdk 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sex, 2005-12-09 às 01:03 -0500, Michael Krufky escreveu:
> he following bugfix is already in 2.6.15-git1.  Please queue this up 
> for 2.6.14.4
> 
> Thank you,
> 
> Michael Krufky


> 
> 
> 
> 
> 
> anexo Diferenças
> entre arquivos
> (thomson-dtt761x-tda9887-fix-ntsc.patch)
> 
> [PATCH] V4L/DVB: Fix analog NTSC for Thomson DTT 761X hybrid tuner
> 
> - Enable tda9887 on the following cx88 boards:
>   pcHDTV 3000
>   FusionHDTV3 Gold-T
> - This ensures that analog NTSC video will function properly, without 
>   this patch, the tuner may appear to be broken.
> 
> Signed-off-by: Michael Krufky <mkrufky@m1k.net>
> Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

Acked-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
> ---
> 
>  cx88-cards.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff -upr linux-2.6.14.3/drivers/media/video/cx88/cx88-cards.c
> linux/drivers/media/video/cx88/cx88-cards.c
> ---
> linux-2.6.14.3/drivers/media/video/cx88/cx88-cards.c        2005-10-27
> 20:02:08.000000000 -0400
> +++ linux/drivers/media/video/cx88/cx88-cards.c 2005-12-09
> 00:44:22.000000000 -0500
> @@ -567,6 +567,7 @@ struct cx88_board cx88_boards[] = {
>                 .radio_type     = UNSET,
>                 .tuner_addr     = ADDR_UNSET,
>                 .radio_addr     = ADDR_UNSET,
> +               .tda9887_conf   = TDA9887_PRESENT,
>                 .input          = {{
>                         .type   = CX88_VMUX_TELEVISION,
>                         .vmux   = 0,
> @@ -711,6 +712,7 @@ struct cx88_board cx88_boards[] = {
>                 .radio_type     = UNSET,
>                 .tuner_addr     = ADDR_UNSET,
>                 .radio_addr     = ADDR_UNSET,
> +               .tda9887_conf   = TDA9887_PRESENT,
>                 .input          = {{
>                          .type   = CX88_VMUX_TELEVISION,
>                          .vmux   = 0,
> 
Cheers, 
Mauro.

