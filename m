Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261845AbVCaUkv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261845AbVCaUkv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 15:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261921AbVCaUku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 15:40:50 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:53262 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261845AbVCaUkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 15:40:41 -0500
Date: Thu, 31 Mar 2005 22:40:39 +0200
From: Adrian Bunk <bunk@stusta.de>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Yum Rayan <yum.rayan@gmail.com>, linux-kernel@vger.kernel.org,
       mvw@planets.elm.net
Subject: Re: [PATCH] Reduce stack usage in acct.c
Message-ID: <20050331204039.GG3185@stusta.de>
References: <df35dfeb05033023394170d6cc@mail.gmail.com> <20050331150548.GC19294@wohnheim.fh-wedel.de> <424C5912.90607@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <424C5912.90607@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2005 at 12:09:54PM -0800, Randy.Dunlap wrote:
> Jörn Engel wrote:
>...
> >In principle, all recursive paths should consume as little stack as
> >possible.  Or the recursion itself could be avoided, even better.  And
> >some of the call chains with ~3k of stack consumption may be
> >problematic on other platforms, like the x86-64.  Taking care of those
> >could result in smaller stacks for the respective platform.
> 
> Here is 2.6.12-rc1-bk3 raw checkstack output on x86-64:
> http://developer.osdl.org/~rddunlap/doc/checkstack1.out

Looking at the stack usage numbers, this was with a gcc that supports
unit-at-a-time.

If you use gcc 3.4 and enable unit-at-a-time (see my other email) the 
i386 numbers look quite similar.

I doubt there are many architecture or 64 bit [1] specific stack usage 
problems, so working on i386 might be enough.

> ~Randy

cu
Adrian

[1] theoretically a factor of two was possible due to the different
    pointer sizes - but I have yet to see any example where this
    really matters

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

