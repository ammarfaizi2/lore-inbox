Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750947AbWBDCuE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750947AbWBDCuE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 21:50:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946271AbWBDCuD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 21:50:03 -0500
Received: from [205.233.219.253] ([205.233.219.253]:22149 "EHLO
	conifer.conscoop.ottawa.on.ca") by vger.kernel.org with ESMTP
	id S1750947AbWBDCuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 21:50:02 -0500
Date: Fri, 3 Feb 2006 21:43:54 -0500
From: Jody McIntyre <scjody@modernduck.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, bcollins@debian.org,
       linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.ne,
       sam@ravnborg.org
Subject: Re: 2.6.16-rc1-mm5: drivers/ieee1394/oui O=... builds broken
Message-ID: <20060204024354.GA22002@conscoop.ottawa.on.ca>
References: <20060203000704.3964a39f.akpm@osdl.org> <20060203212507.GR4408@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060203212507.GR4408@stusta.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2006 at 10:25:07PM +0100, Adrian Bunk wrote:
> ...
>   OUI2C   drivers/ieee1394/oui.c
> /bin/sh: drivers/ieee1394/oui2c.sh: No such file or directory
> make[3]: *** [drivers/ieee1394/oui.c] Error 127

I can't reproduce this.  What steps are you using to build the kernel?

Cheers,
Jody

> 
> <--  snip  -->
> 
> 
> The change that broke it is:
> 
> 
>  quiet_cmd_oui2c = OUI2C   $@
> -      cmd_oui2c = $(CONFIG_SHELL) $(srctree)/$(src)/oui2c.sh < $< > $@
> +      cmd_oui2c = $(CONFIG_SHELL) $(src)/oui2c.sh < $< > $@
> 
> 
> cu
> Adrian
> 
> -- 
> 
>        "Is there not promise of rain?" Ling Tan asked suddenly out
>         of the darkness. There had been need of rain for many days.
>        "Only a promise," Lao Er said.
>                                        Pearl S. Buck - Dragon Seed
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
