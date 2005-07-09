Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263071AbVGICHW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263071AbVGICHW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 22:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263075AbVGICHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 22:07:22 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:14855 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263071AbVGICHU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 22:07:20 -0400
Date: Sat, 9 Jul 2005 04:07:18 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, kirk@braille.uwo.ca
Cc: linux-kernel@vger.kernel.org, speakup@braille.uwo.ca, gregkh@suse.de
Subject: 2.6.13-rc2-mm1: some speakup nitpicks
Message-ID: <20050709020717.GQ3671@stusta.de>
References: <20050707040037.04366e4e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050707040037.04366e4e.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2005 at 04:00:37AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.13-rc1-mm1:
>...
> +gregkh-driver-speakup-docs.patch
> +gregkh-driver-speakup-core.patch
> 
>  driver-core updates
>...

These aren't driver-core updates, these are new drivers.

It seems I missed when this was sent for review to linus-kernel.

Some random nitpicks:

- SPEAKUP_DEFAULT shouldn't be asked if SPEAKUP=n
- "make namespacecheck" shows tons of needlessly global code
- the static variable special_handler is EXPORT_SYMBOL'ed
- #define MIN should be removed
- the file cvsversion.h only for keeping a CVS date is a bit
  overkill
- spk_con_module.h is not exactly how we use header files in the kernel
- many of the #ifdef MODULE's point to things that could be done better
  (especially the #include "mod_code.c"'s)
- the things in synthlist.h could be done less ugly
- speakupconf is a userspace script that belongs under Documentation/
- dtload.c is not kernel code, and should therefore not be in that
  directory
- the code should follow Documentation/CodingStyle better
  (no spaces between the braces and function arguments)
- building speakup_keyhelp.c modular even in a kernel that doesn't
  support modules is silly
- #include <linux/...> belongs before #include <asm/...>

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

