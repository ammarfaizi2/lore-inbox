Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265764AbUHAKkh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265764AbUHAKkh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 06:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265768AbUHAKke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 06:40:34 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:51173 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265764AbUHAKkb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 06:40:31 -0400
Date: Sun, 1 Aug 2004 12:40:26 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com
Subject: Re: Some cleanup patches for: '...lvalues is deprecated'
Message-ID: <20040801104026.GK2746@fs.tum.de>
References: <200407310841.i6V8frSq021638@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407310841.i6V8frSq021638@harpo.it.uu.se>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 31, 2004 at 10:41:53AM +0200, Mikael Pettersson wrote:
>...
> Did you know that there is a larger gcc-3.4 fixes patch:
> <http://www.csd.uu.se/~mikpe/linux/patches/2.4/patch-gcc340-fixes-v4-2.4.27-rc3>
> ?
> 
> This patch handles all issues when using gcc-3.4 to compile
> the current 2.4 kernel, of which cast-as-lvalue is just one.
> The only difference, AFAIK, is that gcc-3.4 "merely" warns
> about cast-as-lvalue while gcc-3.5 errors out on them.
> 
> All changes in the gcc-3.4 fixes patch are backports from
> the 2.6 kernel, except in very few cases when 2.4 and 2.6
> have diverged making slightly different fixes more appropriate
> for 2.4.
>...


BTW:

Please don't include the compiler.h part of your patch.
It's already reverted in -mm, and we're currently fixing the inlines
in 2.6 .

This was started after with this patch in 2.6 somewhere a required 
inlining did no longer occur (and a compile error is definitely better 
than a potential runtime problem).

Although fixing it correctly touches at about three dozen files, these 
are pretty straightforward patches (removing inlines or moving code 
inside files). After all these issues are sorted out in 2.6, the inline 
fixes could be backported to 2.4 .


> /Mikael

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

