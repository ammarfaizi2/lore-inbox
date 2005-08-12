Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751117AbVHLAuU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbVHLAuU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 20:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932339AbVHLAuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 20:50:20 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:18180 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751117AbVHLAuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 20:50:19 -0400
Date: Fri, 12 Aug 2005 02:50:11 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>, linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] DLM must depend on IPV6 || IPV6=n
Message-ID: <20050812005011.GU4006@stusta.de>
References: <20050809155001.GZ4006@stusta.de> <20050809155827.GD17488@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050809155827.GD17488@lug-owl.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2005 at 05:58:27PM +0200, Jan-Benedict Glaw wrote:
> On Tue, 2005-08-09 17:50:01 +0200, Adrian Bunk <bunk@stusta.de> wrote:
> > This patch fixes the following compile error with CONFIG_DLM=y and 
> > CONFIG_IPV6=m:
> 
> [...]
> 
> > --- linux-2.6.13-rc3-mm3-modular/drivers/dlm/Kconfig.old	2005-07-30 14:07:12.000000000 +0200
> > +++ linux-2.6.13-rc3-mm3-modular/drivers/dlm/Kconfig	2005-07-30 14:07:41.000000000 +0200
> > @@ -3,6 +3,7 @@
> >  
> >  config DLM
> >  	tristate "Distributed Lock Manager (DLM)"
> > +	depends on IPV6 || IPV6=n
> >  	select IP_SCTP
> >  	help
> >  	A general purpose distributed lock manager for kernel or userspace
> 
> Why don't you allow modular builds of both? ...or aren't the IPv6
> symbols exported?

Modular builds of both are supported.

CONFIG_DLM=y and CONFIG_IPV6=m is the evil combination since
CONFIG_IP_SCTP=y and CONFIG_IPV6=m doesn't compile.

> MfG, JBG

cu
Adrian

BTW: Please don't strip people from replies.

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

