Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262276AbVESL2y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262276AbVESL2y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 07:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262445AbVESL2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 07:28:53 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:60172 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262441AbVESL2q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 07:28:46 -0400
Date: Thu, 19 May 2005 13:28:40 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: "Gilbert, John" <JGG@dolby.com>, linux-kernel@vger.kernel.org
Subject: Re: Illegal use of reserved word in system.h
Message-ID: <20050519112840.GE5112@stusta.de>
References: <2692A548B75777458914AC89297DD7DA08B0866F@bronze.dolby.net> <20050518195337.GX5112@stusta.de> <6EA08D88-7C67-48ED-A9EF-FEAAB92D8B8F@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6EA08D88-7C67-48ED-A9EF-FEAAB92D8B8F@mac.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2005 at 10:22:24PM -0400, Kyle Moffett wrote:
> 
> On May 18, 2005, at 15:53:37, Adrian Bunk wrote:
> >Looking at the source code of MySQL, it seems MySQL does some dirty
> >tricks for using the inlines from asm/atomic.h in userspace.
> >
> >It's _really_ wrong to do this.
> 
> A project that had some discussion a while ago was to clean up the
> kernel headers and separate them from the kernel-ABI ones, such that
> the ABI headers don't need to use CONFIG_* defines or anything else.
> that might be iffy.
>...

The whole kernel headers issue contains real problems that have to be 
solved properly.

But in this case, this is not the problem:

What MySQL uses from asm/atomic.h doesn't seem to have anything to do 
with any kind of kernel <-> userspace interface (which is what userspace 
might validly require kernel headers for).

> Cheers,
> Kyle Moffett

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

