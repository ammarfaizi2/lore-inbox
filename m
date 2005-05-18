Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262419AbVERX7N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262419AbVERX7N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 19:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262417AbVERX7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 19:59:13 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:31492 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262419AbVERX7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 19:59:07 -0400
Date: Thu, 19 May 2005 01:59:02 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andi Kleen <ak@muc.de>
Cc: "Gilbert, John" <JGG@dolby.com>, linux-kernel@vger.kernel.org
Subject: Re: Illegal use of reserved word in system.h
Message-ID: <20050518235902.GB5112@stusta.de>
References: <2692A548B75777458914AC89297DD7DA08B0866F@bronze.dolby.net> <m1ll6cyucb.fsf@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1ll6cyucb.fsf@muc.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2005 at 01:42:28AM +0200, Andi Kleen wrote:
> "Gilbert, John" <JGG@dolby.com> writes:
> >
> > I think it's been in there a while, but only really blows up when built
> >
> > under recent kernels.
> >
> > I agree, it's probably not the right way to go.
> 
> It's quite dangerous. I suppose it uses this for atomic.h, but it
> means that a mysql compiled under a uniprocessor kernel (or rather
> with a autoconf.h of a uniprocessor kernel, it can even be SMP) will
> have subtle races when run on a SMP system because the atomic
> instructions will miss lock prefixes. Sounds like an open
> deathtrap to me.
>...

They work around this issue by doing

#ifndef CONFIG_SMP
#define CONFIG_SMP
#endif

> -Andi

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

