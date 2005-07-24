Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261546AbVGXJNf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261546AbVGXJNf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 05:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261864AbVGXJNf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 05:13:35 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:27143 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261546AbVGXJNe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 05:13:34 -0400
Date: Sun, 24 Jul 2005 11:13:27 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Grant Coady <lkml@dodo.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3 test: finding compile errors with make randconfig
Message-ID: <20050724091327.GQ3160@stusta.de>
References: <f8b6e1h2t4tlto7ia8gs8aanpib68mhit6@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8b6e1h2t4tlto7ia8gs8aanpib68mhit6@4ax.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 24, 2005 at 04:28:54PM +1000, Grant Coady wrote:

> Greetings,

Hi Grant,

> Few days ago I compiled 241 random configurations of 2.6.13-rc3, today 
> I finally got around to parsing the results, top 40, sorted by name.  
> Percentage is error_builds / total_builds.
> 
> build script similar to:
> count=0
> while [ $((++count)) -le $limit ]; do
>         trial=$(printf %003d $count)
>         make randconfig
>         cp .config "$store/$trial-config"
>         make clean
>         make -j2 2> "$store/$trial-error"
> done
> 
> Curious whether this is worth doing, I'm about to start a run for 2.6.12.3, 
> any interesting errors I can find the particular config + error to recover 
> context.  Deliberately simplistic for traceability at the moment, truncated 
> error length for this post.
>...

it's generally useful, but the target kernel should be the latest -mm
kernel. 

And doing the compilations is really the trivial part of the work, the 
main work is to analyze what causes the build failures and sending 
patches.

> Grant.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

