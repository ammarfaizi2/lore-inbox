Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265144AbTGCLdS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 07:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265229AbTGCLdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 07:33:18 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:11745 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265144AbTGCLdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 07:33:13 -0400
Date: Thu, 3 Jul 2003 13:47:26 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: maximilian attems <maks@sternwelten.at>
Cc: linux-kernel@vger.kernel.org,
       Thomas Winischhofer <thomas@winischhofer.net>
Subject: Re: [2.5 patch] move an unused variable in sis_main.c
Message-ID: <20030703114726.GK282@fs.tum.de>
References: <20030703104700.GA939@mail.sternwelten.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030703104700.GA939@mail.sternwelten.at>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 03, 2003 at 12:47:00PM +0200, maximilian attems wrote:
> The patch below moves an used variable from drivers/video/sis/sis_main.c
> 
> i've tested the compilation with 2.5.74
> 
> please apply
> maks
> 
> 
> --- linux-2.5.74/drivers/video/sis/sis_main.c	Wed Jul  2 22:50:59 2003
> +++ linux/drivers/video/sis/sis_main.c	Thu Jul  3 12:06:58 2003
> @@ -619,11 +619,11 @@
>  	double drate = 0, hrate = 0;
>  	int found_mode = 0;
>  	int old_mode;
> -	unsigned char reg;
>  
>  	TWDEBUG("Inside do_set_var");
>  	
>  #if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)	
> +	unsigned char reg;
>  	inSISIDXREG(SISCR,0x34,reg);
>  	if(reg & 0x80) {
>  	   printk(KERN_INFO "sisfb: Cannot change display mode, X server is active\n");


If TWDEBUG does anything your patch breaks the compilation on kernel 2.4 
with gcc 2.95 .


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

