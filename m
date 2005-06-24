Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263273AbVFXWcl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263273AbVFXWcl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 18:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263265AbVFXWck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 18:32:40 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:19983 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261630AbVFXWbQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 18:31:16 -0400
Date: Sat, 25 Jun 2005 00:31:15 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Christian Hesse <mail@earthworm.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Kernel .patches support
Message-ID: <20050624223115.GL6656@stusta.de>
References: <200506232358.34897.mail@earthworm.de> <20050624073624.GB26545@stusta.de> <200506242303.17813.mail@earthworm.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506242303.17813.mail@earthworm.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2005 at 11:03:17PM +0200, Christian Hesse wrote:
> On Friday 24 June 2005 09:36, Adrian Bunk wrote:
> > On Thu, Jun 23, 2005 at 11:58:27PM +0200, Christian Hesse wrote:
> > > Hi everybody,
> > >
> > > every time I apply a patch to my kernel tree I (or my scripts) make an
> > >
> > > echo $PATCHNAME $PATCHVERSION >> .patches
> > >
> > > This patch makes the file accessible via /proc/patches.gz. I think this
> > > can be handy if you want to know what patches you (or your distributor)
> > > applied to your running kernel...
> > >...
> > > Let me know what you think.
> >
> > To be honest, I'm not a fan of it.
> >
> > If e.g. looking at a Debian kernel source that has 289 different patches
> > with names like tty-locking-fixes7 applied, you'll see that this often
> > won't give you much valuable information.
> 
> You can search Debian lists, archives, ... for "tty-locking-fixes7". After 
> that you probably know what the fix is good for.

The _only_ Google hit for "tty-locking-fixes7" isn't very helpful.

I could simply download the source package for the kernel...

> On the other hand if there is a security fix in a Debian list you can check if 
> your kernel is patched by running "zcat /proc/patches.gz | grep 
> security-fix-foo-bar".

"zless /usr/share/doc/<pkgname>/Debian.src.changelog.gz" already gives 
you the same information plus information about the contents of the 
patches including CAN references and bug numbers.

> > You'd need an uniform naming convention for patches across
> > distributions, and I don't think such things are worth the effort.
> 
> If a distribution has a naming convention for itself this patch can already be 
> useful I think. Even without it can be.

If you are building your own kernel, you have to manually check that you 
don't forget to add every patch you apply to .patches .

In a distribution, the information is already present at better places.

> Christian

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

