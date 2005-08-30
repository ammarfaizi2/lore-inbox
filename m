Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932206AbVH3Q3q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbVH3Q3q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 12:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932207AbVH3Q3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 12:29:46 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:4620 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932206AbVH3Q3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 12:29:45 -0400
Date: Tue, 30 Aug 2005 18:29:44 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Olaf Hering <olh@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] add -Werror-implicit-function-declaration to CFLAGS
Message-ID: <20050830162944.GB7071@stusta.de>
References: <20050830145444.GC3708@stusta.de> <20050830161814.GA31940@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050830161814.GA31940@suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2005 at 06:18:14PM +0200, Olaf Hering wrote:
>  On Tue, Aug 30, Adrian Bunk wrote:
> 
> > Currently, using an undeclared function gives a compile warning, but it 
> > can lead to a link or even a runtime error.
> > 
> > With -Werror-implicit-function-declaration, we are getting an immediate 
> > compile error instead.
> 
> You have to fix CONFIG_SWAP=n as well.
> 
> http://lkml.org/lkml/2005/8/6/72

I don't see any such warning in the 2.6.13 sparc build at Jan's 
crosscompile page [1], and all my patch does is to turn a warning into 
an error.

If a #define is using it before the header with the prototype get's 
#include'd that's no problem as long as the prototype is available when 
the #define is _used_.

I'm not saying that there aren't cases this patch will break (and my 
patch shouldn't go into 2.6.14), but your example doesn't seem to cause 
problems.

cu
Adrian

[1] http://l4x.org/k/?d=6676

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

