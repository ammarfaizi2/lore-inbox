Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262309AbUKQNK0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262309AbUKQNK0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 08:10:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262308AbUKQNK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 08:10:26 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:56077 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262309AbUKQNJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 08:09:27 -0500
Date: Wed, 17 Nov 2004 14:08:20 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] DEBUG_BUGVERBOSE for i386 (fwd)
Message-ID: <20041117130820.GQ4943@stusta.de>
References: <20041117043228.GH4943@stusta.de> <20041117003032.7fd91c47.akpm@osdl.org> <20041117113755.GL4943@stusta.de> <Pine.LNX.4.61.0411171347300.17266@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0411171347300.17266@scrub.home>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2004 at 01:57:05PM +0100, Roman Zippel wrote:

> Hi,

Hi Roman,

> On Wed, 17 Nov 2004, Adrian Bunk wrote:
> 
> > I simply did it as on other architectures.
> > 
> > Do you want the following?
> > 
> > config DEBUG_BUGVERBOSE
> >         bool "Verbose BUG() reporting (adds 70K)" if EMBEDDED
> >         depends on (DEBUG_KERNEL || EMBEDDED=n) && (ARM || ...)
> > 	default y
> 
> What are you trying to do here?

- if EMBEDDED=n, always enable it
- if EMBEDDED=y:
  - disable if DEBUG_KERNEL=n
  - ask if DEBUG_KERNEL=y

> I guess you want something more like this?
> 
> config DEBUG_BUGVERBOSE
> 	bool "Verbose BUG() reporting (adds 70K)" if DEBUG_KERNEL && EMBEDDED
> 	depends on ARM || ...
> 	default y

This has a different semantics:

If you want no kernel debugging in an embedded environment, 
DEBUG_BUGVERBOSE would be automatically enabled.

This is definitely not intended.

> bye, Roman

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

