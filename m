Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267980AbTBYPeE>; Tue, 25 Feb 2003 10:34:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267997AbTBYPeE>; Tue, 25 Feb 2003 10:34:04 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:57805 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S267980AbTBYPeD>; Tue, 25 Feb 2003 10:34:03 -0500
Date: Tue, 25 Feb 2003 16:44:13 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: chas williams <chas@locutus.cmf.nrl.navy.mil>
Cc: jgarzik@pobox.com, Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.63: fore200e.c doesn't compile
Message-ID: <20030225154412.GN7685@fs.tum.de>
References: <200302251445.h1PEjpGi030617@locutus.cmf.nrl.navy.mil> <200302251453.h1PErvGi030679@locutus.cmf.nrl.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302251453.h1PErvGi030679@locutus.cmf.nrl.navy.mil>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2003 at 09:53:57AM -0500, chas williams wrote:
> missed a semicolon--it should be:
> 
> Index: linux/drivers/atm/fore200e.c
> ===================================================================
> RCS file: /home/chas/CVSROOT/linux/drivers/atm/fore200e.c,v
> retrieving revision 1.1.1.1
> diff -u -d -b -w -r1.1.1.1 fore200e.c
> --- linux/drivers/atm/fore200e.c	20 Feb 2003 13:45:03 -0000	1.1.1.1
> +++ linux/drivers/atm/fore200e.c	25 Feb 2003 14:42:06 -0000
> @@ -1132,8 +1132,7 @@
>  	return;
>      } 
>  
> -	do_gettimeofday(&vcc->timestamp);
> -    skb->stamp = vcc->timestamp;
> +    do_gettimeofday(&skb->stamp);
>      
>  #ifdef FORE200E_52BYTE_AAL0_SDU
>      if (cell_header) {


Thanks, this patch fixed it.


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

