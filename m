Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964793AbWAFVyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964793AbWAFVyq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 16:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964799AbWAFVyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 16:54:46 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:3343 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964793AbWAFVyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 16:54:45 -0500
Date: Fri, 6 Jan 2006 22:54:36 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Willy Tarreau <willy@w.ods.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.4 patch] document that gcc 4 is not supported
Message-ID: <20060106215436.GH12131@stusta.de>
References: <20060106203727.GE12131@stusta.de> <20060106211115.GG7142@w.ods.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060106211115.GG7142@w.ods.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2006 at 10:11:15PM +0100, Willy Tarreau wrote:
> Hi Adrian,
> 
> On Fri, Jan 06, 2006 at 09:37:27PM +0100, Adrian Bunk wrote:
> > gcc 4 is not supported for compiling kernel 2.4, and I don't see any 
> > compelling reason why kernel 2.4 should ever be adapted to gcc 4.
> > 
> > This patch documents this fact.
> > 
> > Without this patch, your screen is flooded with warnings and errors when
> > accidentially trying to compile kernel 2.4 with gcc 4.
> > 
> > With this patch, the same happens, but the last lines contain the
> > explanation
> >   #error Sorry, your GCC is too recent for kernel 2.4
> 
> Well, why not putting this into include/linux/compiler.h instead ? It
> would shout earlier and will be easier to find.
>...
 
init/main.c is the first file that gets compiled, and therefore the 
traditional place for such compiler checks.

> > --- linux-2.4.31-rc1-full/README.old	2005-05-30 21:21:29.000000000 +0200
> > +++ linux-2.4.31-rc1-full/README	2005-05-30 21:21:59.000000000 +0200
> > @@ -152,6 +152,7 @@
> >  
> >   - Make sure you have gcc 2.95.3 available.  gcc 2.91.66 (egcs-1.1.2) may
> >     also work but is not as safe, and *gcc 2.7.2.3 is no longer supported*.
> > +   gcc 4 is *not* supported.
> 
> I would even explicitly state that gcc-3.3 and 3.4 should work in most
> cases, while gcc 4 will definitely not work. It's important IMHO to
> give the answers that most users will be looking for, and 3.3/3.4 are
> fairly common.
>...

gcc 2.95 is still the recommended compiler for kernel 2.4.

But if you want to improve the text, feel free to send a patch.  :-)

> Thanks,
> Willy

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

