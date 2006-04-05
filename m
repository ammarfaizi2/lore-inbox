Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751295AbWDERTe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbWDERTe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 13:19:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751273AbWDERTe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 13:19:34 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:60426 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751295AbWDERTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 13:19:33 -0400
Date: Wed, 5 Apr 2006 19:19:21 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: mpm@selenic.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [2.6 patch] drivers/char/random.c: unexport secure_ipv6_port_ephemeral
Message-ID: <20060405171921.GJ8673@stusta.de>
References: <20060405163610.GG8673@stusta.de> <20060405101111.0edc161a@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060405101111.0edc161a@localhost.localdomain>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2006 at 10:11:11AM -0700, Stephen Hemminger wrote:
> On Wed, 5 Apr 2006 18:36:10 +0200
> Adrian Bunk <bunk@stusta.de> wrote:
> 
> > This patch removes the unused EXPORT_SYMBOL(secure_ipv6_port_ephemeral).
> > 
> > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> > 
> > --- linux-2.6.17-rc1-mm1-full/drivers/char/random.c.old	2006-04-05 17:00:04.000000000 +0200
> > +++ linux-2.6.17-rc1-mm1-full/drivers/char/random.c	2006-04-05 17:00:22.000000000 +0200
> > @@ -1584,7 +1584,6 @@
> >  
> >  	return twothirdsMD4Transform(daddr, hash);
> >  }
> > -EXPORT_SYMBOL(secure_ipv6_port_ephemeral);
> >  #endif
> >  
> >  #if defined(CONFIG_IP_DCCP) || defined(CONFIG_IP_DCCP_MODULE)
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe netdev" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> NAK
> 
> If IPV6 is built as a module, then it is needed.

No, it isn't:
  obj-$(subst m,y,$(CONFIG_IPV6)) += inet6_hashtables.o

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

