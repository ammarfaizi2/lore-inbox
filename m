Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbTFGQAW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 12:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbTFGQAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 12:00:22 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:48339 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261939AbTFGQAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 12:00:19 -0400
Date: Sat, 7 Jun 2003 18:13:49 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Jean Tourrilhes <jt@bougret.hpl.hp.com>, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: Re: [patch] fix vlsi_ir.c compile if !CONFIG_PROC_FS
Message-ID: <20030607161348.GC3708@fs.tum.de>
References: <20030607152434.GQ15311@fs.tum.de> <20030607155826.GA20118@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030607155826.GA20118@mars.ravnborg.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 07, 2003 at 05:58:27PM +0200, Sam Ravnborg wrote:
> On Sat, Jun 07, 2003 at 05:24:34PM +0200, Adrian Bunk wrote:
> > I got the following compile error with !CONFIG_PROC_FS:
> >   CC      drivers/net/irda/vlsi_ir.o
> > drivers/net/irda/vlsi_ir.c:2047: `PROC_DIR' undeclared (first use in this function)
> > The following patch fixes it:
> > 
> 
> [snip]
> 
> I prefer the following patch:
> Get rid of one ifdef/endif pair.


Yup, I agree, your patch is better.


> 	Sam
> 
> ===== drivers/net/irda/vlsi_ir.c 1.16 vs edited =====
> --- 1.16/drivers/net/irda/vlsi_ir.c	Thu Apr 24 14:17:12 2003
> +++ edited/drivers/net/irda/vlsi_ir.c	Sat Jun  7 17:55:29 2003
> @@ -1993,9 +1993,7 @@
>  #endif
>  };
>  
> -#ifdef CONFIG_PROC_FS
>  #define PROC_DIR ("driver/" DRIVER_NAME)
> -#endif
>  
>  static int __init vlsi_mod_init(void)
>  {

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

