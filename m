Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130903AbQKUTEk>; Tue, 21 Nov 2000 14:04:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130902AbQKUTEa>; Tue, 21 Nov 2000 14:04:30 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:51723
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S130701AbQKUTD7>; Tue, 21 Nov 2000 14:03:59 -0500
Date: Tue, 21 Nov 2000 10:33:28 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: David Woodhouse <dwmw2@infradead.org>
cc: Hakan Lennestal <hakanl@cdt.luth.se>,
        Peter Samuelson <peter@cadcamlab.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.0, test10, test11: HPT366 problem 
In-Reply-To: <27102.974813391@redhat.com>
Message-ID: <Pine.LNX.4.10.10011211033180.26689-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Does that fix it?

On Tue, 21 Nov 2000, David Woodhouse wrote:

> 
> hakanl@cdt.luth.se said:
> >  When it comes to the partition detection during bootup, udma4 or
> > udma3 doesn't seem to matter. It passes approx. one out of ten times
> > either way. 
> 
> How have you made it use udma3 at bootup? Something like the patch below?
> 
> Index: drivers/ide/hpt366.c
> ===================================================================
> RCS file: /inst/cvs/linux/drivers/ide/Attic/hpt366.c,v
> retrieving revision 1.1.2.10
> diff -u -r1.1.2.10 hpt366.c
> --- drivers/ide/hpt366.c	2000/11/10 14:56:31	1.1.2.10
> +++ drivers/ide/hpt366.c	2000/11/21 13:27:32
> @@ -55,6 +55,8 @@
>  };
>  
>  const char *bad_ata66_4[] = {
> +	"IBM-DTLA-307045",
> +	"IBM-DTLA-307030",
>  	"WDC AC310200R",
>  	NULL
>  };
> 
> --
> dwmw2
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

Andre Hedrick
CTO Timpanogas Research Group
EVP Linux Development, TRG
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
