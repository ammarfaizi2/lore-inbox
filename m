Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932456AbVKREAN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932456AbVKREAN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 23:00:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932457AbVKREAM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 23:00:12 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:6151 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932449AbVKREAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 23:00:11 -0500
Date: Fri, 18 Nov 2005 05:00:09 +0100
From: Adrian Bunk <bunk@stusta.de>
To: proski@gnu.org, orinoco-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, jgarzik@pobox.com, netdev@vger.kernel.org
Subject: Re: [Orinoco-devel] [2.6 patch] drivers/net/wireless/orinoco.h: "extern inline" -> "static inline"
Message-ID: <20051118040009.GZ11494@stusta.de>
References: <20051118033329.GU11494@stusta.de> <20051118035236.GB23760@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051118035236.GB23760@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2005 at 02:52:36PM +1100, David Gibson wrote:
> On Fri, Nov 18, 2005 at 04:33:29AM +0100, Adrian Bunk wrote:
> > "extern inline" doesn't make much sense.
> 
> Yes it does.  "extern inline" tells gcc not to fall back to out of
> line version if it can't inline the function.  These functions *must*
> by inlined, or they'll break horribly on Sparc, at least.
>...

For any non-ancient gcc and !alpha, we are already telling gcc via 
__attribute__((always_inline)) that it should abort compilation if it 
can't inline the function.

The problem is that "extern inline" gives warnings with 
-Wmissing-prototypes, and I want to add this flag to the CFLAGS since it 
helps us to avoid a class of nasty runtime errors.

> David Gibson

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

