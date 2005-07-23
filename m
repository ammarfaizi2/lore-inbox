Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262373AbVGWQtG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262373AbVGWQtG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 12:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262368AbVGWQtG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 12:49:06 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:60177 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262375AbVGWQsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 12:48:08 -0400
Date: Sat, 23 Jul 2005 18:48:01 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Bodo Eggert <7eggert@gmx.de>
Cc: perex@suse.cz, akpm@osdl.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [2.6 patch] sound drivers select'ing ISAPNP must depend on PNP && ISA
Message-ID: <20050723164801.GE3160@stusta.de>
References: <Pine.LNX.4.58.0507171702030.12446@be1.lrz> <20050719163640.GK5031@stusta.de> <Pine.LNX.4.58.0507192232230.4182@be1.lrz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0507192232230.4182@be1.lrz>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2005 at 10:50:53PM +0200, Bodo Eggert wrote:
> On Tue, 19 Jul 2005, Adrian Bunk wrote:
> > On Sun, Jul 17, 2005 at 05:07:48PM +0200, Bodo Eggert wrote:
> 
> > > In sound/isa/Kconfig, select ISAPNP and depend on ISAPNP are intermixed, 
> > > resulting in funny behaviour. (Soundcarts get selectable if other 
> > > soundcards are selected).
> > > 
> > > This patch changes the "depend on ISAPNP"s to select.
> > >...
> > 
> > I like the idea of this patch, but it brings to more drivers to a 
> > violation of the "if you select something, you have to ensure that the 
> > dependencies of what you select are fulfilled" rule causing link errors 
> > with invalid .config's.
> 
> That should be mentioned in kconfig-language.txt. OTOH, the build system
> should automatically propagate the dependencies. I asume that should be
> easy, except for having the time to implement that.
>...

There are nontrivial problems:
E.g. what should happen if you select option A that depends on (B || C)?

There's one opinion that options should be either select'able _or_ user 
visible.

The current policy in the kernel is not 100% dogmatic regarding this 
issue, but it shouldn't be violated without a good reason.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

