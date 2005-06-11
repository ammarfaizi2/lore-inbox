Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261185AbVFKPhD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261185AbVFKPhD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 11:37:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261363AbVFKPhD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 11:37:03 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:26372 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261185AbVFKPg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 11:36:58 -0400
Date: Sat, 11 Jun 2005 17:36:56 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Patch series to remove devfs [00/22]
Message-ID: <20050611153656.GB3770@stusta.de>
References: <20050611074327.GA27785@kroah.com> <20050611102133.GA3770@stusta.de> <20050611143904.GA30612@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050611143904.GA30612@suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 11, 2005 at 07:39:04AM -0700, Greg KH wrote:
> On Sat, Jun 11, 2005 at 12:21:34PM +0200, Adrian Bunk wrote:
> > On Sat, Jun 11, 2005 at 12:43:27AM -0700, Greg KH wrote:
> > >...
> > > Comments welcome.
> > >...
> > 
> > Please don't remove the !CONFIG_DEVFS_FS dummies from devfs_fs_kernel.h.
> > 
> > I'm sure some driver maintainers will want to keep the functions in 
> > their code because they share their drivers between 2.4 and 2.6 .
> 
> All drivers should be in the mainline kernel tree, so why would they
> need this?  Remember, out-of-the-tree drivers are on their own...

I'm talking about drivers in the mainline kernel tree.

In some cases the driver author supports both 2.4 and 2.6 and prefers to 
support them in one file. Sometimes he submits the latest version of his 
driver to Marcelo or Linus.

If you remove the global function dummies, you force every driver 
maintainer who works this way to add the function dummies to their 
drivers.

Yes, there are many places where 2.4 and 2.6 are not source compatible 
for good reasons. But if the effort for maintaining compatibility 
between 2.4 and 2.6 in one area is as easy as keeping a header file with 
some dummy funtions it's worth considering.

And keeping the compatibility stuff in one file instead of spreaded 
through the kernel sources makes the cleanup to remove the last 
occurences a few years from now easier.

> thanks,
> 
> greg k-h

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

