Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965011AbVLNW0j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965011AbVLNW0j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 17:26:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965006AbVLNW0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 17:26:38 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:19215 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965004AbVLNW0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 17:26:38 -0500
Date: Wed, 14 Dec 2005 23:26:38 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] offer CC_OPTIMIZE_FOR_SIZE only if EXPERIMENTAL
Message-ID: <20051214222638.GH23349@stusta.de>
References: <20051214191006.GC23349@stusta.de> <20051214140531.7614152d.akpm@osdl.org> <20051214221304.GE23349@stusta.de> <20051214142216.57d1900a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051214142216.57d1900a.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2005 at 02:22:16PM -0800, Andrew Morton wrote:
> Adrian Bunk <bunk@stusta.de> wrote:
> >
> > CC_OPTIMIZE_FOR_SIZE is still an experimental feature that doesn't work 
> > with all supported gcc/architecture combinations.
> > 
> > 
> > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> > 
> > --- linux-git/init/Kconfig.old	2005-12-14 23:08:51.000000000 +0100
> > +++ linux-git/init/Kconfig	2005-12-14 23:09:09.000000000 +0100
> > @@ -257,7 +257,7 @@
> >  source "usr/Kconfig"
> >  
> >  config CC_OPTIMIZE_FOR_SIZE
> > -	bool "Optimize for size"
> > +	bool "Optimize for size (EXPERIMENTAL)" if EXPERIMENTAL
> >  	default y if ARM || H8300
> >  	help
> >  	  Enabling this option will pass "-Os" instead of "-O2" to gcc
> 
> This will cause arm and h8300 to accidentally stop using -Os if they have
> !EXPERIMENTAL.

No, arm and h8300 will use -Os with !EXPERIMENTAL.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

