Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262957AbVCWXzx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262957AbVCWXzx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 18:55:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262954AbVCWXzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 18:55:52 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:61711 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262959AbVCWXyX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 18:54:23 -0500
Date: Thu, 24 Mar 2005 00:54:20 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andreas Schwab <schwab@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/cdrom/gscd.c: kill dead code
Message-ID: <20050323235420.GH1948@stusta.de>
References: <20050322215505.GN1948@stusta.de> <jemzsvb8oz.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jemzsvb8oz.fsf@sykes.suse.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2005 at 11:46:20PM +0100, Andreas Schwab wrote:
> Adrian Bunk <bunk@stusta.de> writes:
> 
> > This patch removes some obviously dead code found by the Coverity 
> > checker.
> >
> > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> >
> > --- linux-2.6.12-rc1-mm1-full/drivers/cdrom/gscd.c.old	2005-03-22 20:58:54.000000000 +0100
> > +++ linux-2.6.12-rc1-mm1-full/drivers/cdrom/gscd.c	2005-03-22 20:59:46.000000000 +0100
> > @@ -694,12 +694,8 @@
> >  		do {
> >  			result = wait_drv_ready();
> >  		} while (result != 6 || result == 0x0E);
> >  
> > -		if (result != 6) {
> > -			cmd_end();
> > -			return;
> > -		}
> 
> I'd rather guess that (result != 6 || result == 0x0E) is borken, since
> it's equivalent to (result != 6).

This driver seems to be pretty unchanged for the last 10 years.

Unless someone really knows your assumption was correct, I'd prefer 
staying with the old behavior.

> Andreas.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


