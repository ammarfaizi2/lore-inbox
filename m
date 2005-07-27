Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262198AbVG0MF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262198AbVG0MF7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 08:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262212AbVG0MF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 08:05:59 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:23059 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262198AbVG0MFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 08:05:52 -0400
Date: Wed, 27 Jul 2005 14:05:39 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] include/linux/bio.h: "extern inline" -> "static inline"
Message-ID: <20050727120539.GE3160@stusta.de>
References: <20050726145344.GO3160@stusta.de> <200507270149.j6R1n26u013077@laptop11.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507270149.j6R1n26u013077@laptop11.inf.utfsm.cl>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2005 at 09:49:02PM -0400, Horst von Brand wrote:
> Adrian Bunk <bunk@stusta.de> wrote:
> > "extern inline" doesn't make much sense.
> 
> The gcc info here (4.0.1-4 on Fedora rawhide) says it means that the
> function should be inlined, and no local copy should be generated
> ever. This way the build will bomb out when something isn't inlined.
> 
> It also says you should use:
> 
>    static inline void foo(some args) __attribute__((always_inline));

We are already doing this automatically.

> as a prototype in this case for future proofing (gcc inlining is not C99
> compatible!), but I don't know if that is supported as far back as 2.95.3
> (as per Documentation/Changes the required compiler).

__attribute__((always_inline)) is supported since gcc 3.1 .

> Side question: Is there anybody still seriously using such ancient
> compilers? I'd guess almost everybody is using newer versions, so this
> would really be not a supported combination anymore.

gcc 2.95 is still a 100% supported compiler.

Compilation of the complete kernel sources usually works [1] and I know 
several people still using gcc 2.95 for several reasons.

cu
Adrian

[1] on i386

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

