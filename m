Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312574AbSDOCKU>; Sun, 14 Apr 2002 22:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312581AbSDOCKT>; Sun, 14 Apr 2002 22:10:19 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:32004
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S312574AbSDOCKS>; Sun, 14 Apr 2002 22:10:18 -0400
Date: Sun, 14 Apr 2002 19:09:58 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] for 2.4.19-pre6
In-Reply-To: <200204150023.g3F0NKi21975@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.LNX.4.10.10204141908040.1699-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Well I sent the rest of the patch in that got lost.
It is the fs/* directory that is missing things.

There was a decouple of code from 2.4.X-ac to marcelo.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

On Sun, 14 Apr 2002, Richard Gooch wrote:

>   Hi, Marcelo. The last few pre-patches have broken IDE as modules. I
> would have though this would have been fixed by now, but perhaps
> no-one else noticed. Here is a patch that fixes the problem.
> 
> 				Regards,
> 
> 					Richard....
> Permanent: rgooch@atnf.csiro.au
> Current:   rgooch@ras.ucalgary.ca
> 
> diff -urN linux-2.4.19-pre6/drivers/ide/ide-probe.c linux/drivers/ide/ide-probe.c
> --- linux-2.4.19-pre6/drivers/ide/ide-probe.c	Sat Apr  6 14:15:17 2002
> +++ linux/drivers/ide/ide-probe.c	Sun Apr 14 15:51:51 2002
> @@ -987,7 +987,6 @@
>  }
>  
>  #ifdef MODULE
> -extern int (*ide_xlate_1024_hook)(kdev_t, int, int, const char *);
>  
>  int init_module (void)
>  {
> @@ -997,14 +996,12 @@
>  		ide_unregister(index);
>  	ideprobe_init();
>  	create_proc_ide_interfaces();
> -	ide_xlate_1024_hook = ide_xlate_1024;
>  	return 0;
>  }
>  
>  void cleanup_module (void)
>  {
>  	ide_probe = NULL;
> -	ide_xlate_1024_hook = 0;
>  }
>  MODULE_LICENSE("GPL");
>  #endif /* MODULE */
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

