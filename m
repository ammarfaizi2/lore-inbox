Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752450AbWAFSGc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752450AbWAFSGc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 13:06:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751588AbWAFSGc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 13:06:32 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:24077 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751586AbWAFSGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 13:06:31 -0500
Date: Fri, 6 Jan 2006 19:06:26 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] don't allow users to set CONFIG_BROKEN=y
Message-ID: <20060106180626.GV12131@stusta.de>
References: <20060106173547.GR12131@stusta.de> <9a8748490601060949g4765a4dcrfab4adab4224b5ad@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490601060949g4765a4dcrfab4adab4224b5ad@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2006 at 06:49:55PM +0100, Jesper Juhl wrote:
> On 1/6/06, Adrian Bunk <bunk@stusta.de> wrote:
> > Do not allow people to create configurations with CONFIG_BROKEN=y.
> >
> > The sole reason for CONFIG_BROKEN=y would be if you are working on
> > fixing a broken driver, but in this case editing the Kconfig file is
> > trivial.
> >
> > Never ever should a user enable CONFIG_BROKEN.
> >
> I disagree (slightly) with this patch for a few reasons:
> 
> - It's very convenient to be able to enable it through menuconfig.

And when do you really need it?

> - Being able to easily enable it in menuconfig, then browse through
> the menus to look for something matching your hardware is nice, even
> if that something is marked BROKEN at least you've then found a place
> to start working on. A lot simpler than digging through directories.

Our menus are mostly made for _users_.

The more common are users accidentially enabling CONFIG_BROKEN and then 
wondering why a driver isn't compiling or working.

And in my experience, when searching whether hardware might be supported 
a grep through the kernel sources brings you more than reading often 
outdated Kconfig help texts. Besides this, a BROKEN driver usually has 
the same value for the user as a non-existing driver.

> - Some things marked BROKEN may not be 100% broken and may actually
> work for some specific things, so if you know that it works for your
> use, then being able to easily enable BROKEN and then whatever it is
> you need is nice.

In reality, people accidentially turn on CONFIG_BROKEN, enable a broken 
driver, and wonder why it isn't working as expected.

If you know the driver is marked as BROKEN and if you want to use it 
despite this, editing the Kconfig file is trivial.

Unless you _really_ know what you are doing, no driver for your hard 
disk is better than a broken driver.

> Perhaps just move it below the Kernel Hacking menu instead, users
> don't go there (or if they do they damn well should know what they are
> doing).
>...

Enabling MAGIC_SYSRQ for being able to sync the disks for crashed 
machines...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

