Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283639AbRLEAty>; Tue, 4 Dec 2001 19:49:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283621AbRLEAto>; Tue, 4 Dec 2001 19:49:44 -0500
Received: from 238-VALL-X5.libre.retevision.es ([62.83.215.238]:40455 "EHLO
	ragnar-hojland.com") by vger.kernel.org with ESMTP
	id <S283616AbRLEAth>; Tue, 4 Dec 2001 19:49:37 -0500
Date: Tue, 4 Dec 2001 00:02:21 +0100
From: Ragnar Hojland Espinosa <ragnar@ragnar-hojland.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.16: kmalloc tidying
Message-ID: <20011204000221.B1034@ragnar-hojland.com>
In-Reply-To: <20011203193751.A10125@ragnar-hojland.com> <E16BBxS-0001Pn-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16BBxS-0001Pn-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, Dec 04, 2001 at 09:33:46AM +0000
Organization: Mediocrity Naysayers Ltd
X-Homepage: http://lightside.eresmas.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2001 at 09:33:46AM +0000, Alan Cox wrote:
> > +++ linux-2.4.16/drivers/sbus/char/envctrl.c	Tue Nov 13 05:31:02 2001
> > @@ -897,10 +897,6 @@ static void envctrl_init_i2c_child(struc
> >  		}
> > =20
> >                  pchild->tables =3D kmalloc(tbls_size, GFP_KERNEL);
> > -		if (!pchild->tables) {
> > -			printk("envctrl: Failed to get table, not enough memory.\n");
> 
> Why are you removing the checks here ?

Hrmpf.. reversed patch, I was actually adding them.

> >  	current->mm->rss =3D 0;
> > -	setup_arg_pages(bprm); /* XXX: check error */
> > +	retval =3D setup_arg_pages(bprm);
> > +	if (retval)=20
> > +		goto out_free_dentry;
> 
> At this point you need to do more drastic things - see the last -ac patch
> for a possible solution

That does sound entertaining.. :)

-- 
____/|  Ragnar Højland      Freedom - Linux - OpenGL |    Brainbench MVP
\ o.O|  PGP94C4B2F0D27DE025BE2302C104B78C56 B72F0822 | for Unix Programming
 =(_)=  "Thou shalt not follow the NULL pointer for  | (www.brainbench.com)
   U     chaos and madness await thee at its end."
