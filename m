Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262607AbUKLSko@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262607AbUKLSko (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 13:40:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262605AbUKLSko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 13:40:44 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:3847 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262608AbUKLSkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 13:40:37 -0500
Date: Fri, 12 Nov 2004 19:40:05 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Dave Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
Subject: Re: kconfig/build question..
Message-ID: <20041112184005.GH2249@stusta.de>
References: <Pine.LNX.4.58.0411100110170.1637@skynet> <Pine.LNX.4.61.0411101253460.17266@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0411101253460.17266@scrub.home>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2004 at 12:55:32PM +0100, Roman Zippel wrote:
> Hi,
> 
> On Wed, 10 Nov 2004, Dave Airlie wrote:
> 
> > So what I want to do and what I think Kbuild can't do is:
> > 
> > if CONFIG_AGP=n then CONFIG_DRM can be n,m,y
> > if CONFIG_AGP=m then CONFIG_DRM can be m but not y
> > if CONFIG_AGP=y then CONFIG_DRM can be m,y
> 
> Do you really want to say that DRM can't be disabled if AGP is enabled?
> Otherwise this should do it:
> 
> 	depends on AGP || AGP=n

I dislike this solution.

consider:
AGP=n
DRM=y

If the user then adds modular AGP to his kernel this will cause DRM=m 
which might cause problems if he tries to use these modules.

I'm still of the opinion that adding a module shoudn't change the 
static kernel.

> bye, Roman

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

