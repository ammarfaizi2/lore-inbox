Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261685AbVCCNoM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbVCCNoM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 08:44:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261675AbVCCNmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 08:42:00 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:53266 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261669AbVCCNlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 08:41:14 -0500
Date: Thu, 3 Mar 2005 14:41:12 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: kai@germaschewski.name, sam@ravnborg.org, rusty@rustcorp.com.au,
       vincent.vanackere@gmail.com, keenanpepper@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: Undefined symbols in 2.6.11-rc5-mm1
Message-ID: <20050303134112.GU4608@stusta.de>
References: <422550FC.9090906@gmail.com> <20050302012331.746bf9cb.akpm@osdl.org> <65258a58050302014546011988@mail.gmail.com> <20050302032414.13604e41.akpm@osdl.org> <20050302140019.GC4608@stusta.de> <20050302082846.1b355fa4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050302082846.1b355fa4.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2005 at 08:28:46AM -0800, Andrew Morton wrote:
> Adrian Bunk <bunk@stusta.de> wrote:
> >
> > > In lib/Makefile, remove parser.o from the lib-y: rule and add
> >  > 
> >  > obj-y	+= parser.o
> > 
> >  This I didn't find.
> > 
> >  Is it really the intention to silently omit objects that are not 
> >  referenced or could this be changed?
> 
> In some cases, yes, it it desirable.  For example, lib/extable.c provides a
> default implementation of an exception table sorter but if the architecture
> defies its own, the linker will skip the default version in lib/.
> 
> At least, that's what the thinking was a few years ago.  But it's such a
> special-case that we can probably forget about it and just drive the build
> and linkage with config now.
>...

lib/extable.c already uses two ARCH_HAS_* defines, simply because the 
linker couldn't help if only one of two functions in a file were needed.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

