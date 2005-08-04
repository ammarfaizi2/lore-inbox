Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262668AbVHDUmV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262668AbVHDUmV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 16:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262667AbVHDUju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 16:39:50 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:271 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262629AbVHDUif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 16:38:35 -0400
Date: Thu, 4 Aug 2005 22:38:31 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] remove support for gcc < 3.2
Message-ID: <20050804203831.GD4029@stusta.de>
References: <20050731222606.GL3608@stusta.de> <21d7e99705080318347d6b58d5@mail.gmail.com> <20050804065447.GB25606@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050804065447.GB25606@lug-owl.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2005 at 08:54:47AM +0200, Jan-Benedict Glaw wrote:
>...
> Current GCC from CVS (plus minor configury patches) seems to work. We
> had -fno-unit-at-a-time missing in our arch Makefile which hides a bug
> in kernel's sources.
> 
> I guess that if you remove -fno-unit-at-a-time from i386 and use a
> current GCC, you'll run into that fun, too.

What bug exactly?

I'm sometimes using kernels compiled with gcc 4.0 and without 
-fno-unit-at-a-time and except for the kernel image being smaller I 
haven't noticed any difference. Besides this, all architectures except 
i386 and um are not disabling unit-at-a-time.

There are a few parts of the kernel that might still have stack problems 
with unit-at-a-time, but I assume that's not what you are talking about?

> MfG, JBG
>...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

