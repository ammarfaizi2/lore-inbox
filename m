Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261221AbVBZPWp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbVBZPWp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 10:22:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261218AbVBZPWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 10:22:45 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:26124 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261221AbVBZPWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 10:22:43 -0500
Date: Sat, 26 Feb 2005 16:22:39 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] unexport do_settimeofday
Message-ID: <20050226152239.GL3311@stusta.de>
References: <20050224233742.GR8651@stusta.de> <20050224212448.367af4be.akpm@osdl.org> <20050225214326.GE3311@stusta.de> <20050225135504.7749942e.akpm@osdl.org> <20050225230246.GI3311@stusta.de> <20050225152009.14cdf450.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050225152009.14cdf450.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2005 at 03:20:09PM -0800, Andrew Morton wrote:
> Adrian Bunk <bunk@stusta.de> wrote:
> >
> > > +#ifdef MODULE
> > > +#define __deprecated_in_modules __deprecated
> > > +#else
> > > +#define __deprecated_in_modules /* OK in non-modular code */
> > > +#endif
> > > +
> > >...
> > 
> > Looks good.
> > 
> > 
> > One more question:
> > 
> > You get a false positive if the file containing the symbol is itself a 
> > module.
> 
> I don't understand what you mean.
> 
> You mean that a module is doing an EXPORT_SYMBOL of a symbol which is on
> death row?

Yes.

> If so: err, not sure.  I guess we could just live with the warning.
>...

OK.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

