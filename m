Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261937AbUL0Rnm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261937AbUL0Rnm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 12:43:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261938AbUL0Rnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 12:43:41 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:772 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261937AbUL0RnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 12:43:24 -0500
Date: Mon, 27 Dec 2004 18:43:19 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Cannot compile without sysctl (+semi-patch)
Message-ID: <20041227174319.GC5345@stusta.de>
References: <Pine.LNX.4.61.0412271803300.10322@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0412271803300.10322@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 27, 2004 at 06:06:35PM +0100, Jan Engelhardt wrote:

> Hi,

Hi Jan,

> in trying to make the smallest possible kernel for an old pc's needs (read: 
> 386sx) disabling sysctl support (CONFIG_SYSCTL) does not work, sys_setgroups 
> and sys_setgroups16 still require it. (I get a linking error.)
> It's not a blocker, but it would be nice if this got wrapped up in #ifdef or 
> something :-) so that either sysctl is always on or sys_setgroups behaves a 
> little different.
> 
> Preferably:
> include/linux/limits.h:
> #ifdef __KERNEL__
> extern int ngroups_max;
> # define NGROUPS_MAX ngroups_max
> #else
> # define NGROUPS_MAX __NGROUPS_MAX
> #endif
> 
> to
>...

you should also tell us which kernel version you observed this problem 
in - neither the latest 2.4 nor the latest 2.6 kernels have a limits.h 
like the one you describe...

> Jan Engelhardt

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

