Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750974AbWBFEhk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974AbWBFEhk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 23:37:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750976AbWBFEhk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 23:37:40 -0500
Received: from [205.233.219.253] ([205.233.219.253]:49867 "EHLO
	conifer.conscoop.ottawa.on.ca") by vger.kernel.org with ESMTP
	id S1750973AbWBFEhk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 23:37:40 -0500
Date: Sun, 5 Feb 2006 23:31:27 -0500
From: Jody McIntyre <scjody@modernduck.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, bcollins@debian.org,
       linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.ne,
       sam@ravnborg.org, Johannes Berg <johannes@sipsolutions.net>
Subject: Re: 2.6.16-rc1-mm5: drivers/ieee1394/oui O=... builds broken
Message-ID: <20060206043127.GQ22002@conscoop.ottawa.on.ca>
References: <20060203000704.3964a39f.akpm@osdl.org> <20060203212507.GR4408@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060203212507.GR4408@stusta.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2006 at 10:25:07PM +0100, Adrian Bunk wrote:

> The change that broke it is:
> 
> 
>  quiet_cmd_oui2c = OUI2C   $@
> -      cmd_oui2c = $(CONFIG_SHELL) $(srctree)/$(src)/oui2c.sh < $< > $@
> +      cmd_oui2c = $(CONFIG_SHELL) $(src)/oui2c.sh < $< > $@

Reverted.

Johannes, please fix this such that builds with O= still work, or change
your out-of-tree Makefile so that this change is not needed.

Cheers,
Jody

> 
> 
> cu
> Adrian
> 
> -- 
> 
>        "Is there not promise of rain?" Ling Tan asked suddenly out
>         of the darkness. There had been need of rain for many days.
>        "Only a promise," Lao Er said.
>                                        Pearl S. Buck - Dragon Seed
> 

-- 
