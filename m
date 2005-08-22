Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750746AbVHVToo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbVHVToo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 15:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbVHVToo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 15:44:44 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:56337 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750746AbVHVTon (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 15:44:43 -0400
Date: Mon, 22 Aug 2005 21:44:41 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] fs/adfs/adfs.h: "extern inline" doesn't make sense
Message-ID: <20050822194441.GF9927@stusta.de>
References: <20050819234119.GD3615@stusta.de> <20050819234443.GG3615@stusta.de> <43087A08.3080400@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43087A08.3080400@drzeus.cx>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 21, 2005 at 02:56:40PM +0200, Pierre Ossman wrote:
> Adrian Bunk wrote:
> > [ this time with a better subject ]
> > 
> > "extern inline" doesn't make sense.
> > 
> > 
> > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> > 
> 
> Isn't 'extern inline' an old gcc trick to force inlining? (instead of
> just hinting)

For gcc >= 3.1, we are already telling the compiler that it should 
either inline the code or abort compilation.

"extern inline" doesn't make much sense. And it gives a warning with 
-Wmissing-prototypes.

I'm currently cleaning up warnings with -Wmissing-prototypes to get them 
to an acceptable level. -Wmissing-prototypes will help us to enforce a 
coding style that will avoid a class of nasty runtime errors that are 
currently sometimes hitting us.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

