Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277440AbRJJWTS>; Wed, 10 Oct 2001 18:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277473AbRJJWTH>; Wed, 10 Oct 2001 18:19:07 -0400
Received: from www.inreko.ee ([195.222.18.2]:23520 "EHLO www.inreko.ee")
	by vger.kernel.org with ESMTP id <S277440AbRJJWSw>;
	Wed, 10 Oct 2001 18:18:52 -0400
Date: Thu, 11 Oct 2001 00:36:10 +0200
From: Marko Kreen <marko@l-t.ee>
To: Andris Pavenis <pavenis@latnet.lv>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.11: mount flag noexec still broken for VFAT partition
Message-ID: <20011011003609.B18573@l-t.ee>
In-Reply-To: <Pine.LNX.4.21.0110102258290.28429-100000@gulbis.latnet.lv> <20011010151333.G10443@turbolinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011010151333.G10443@turbolinux.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2001 at 03:13:33PM -0600, Andreas Dilger wrote:
> On Oct 10, 2001  23:01 +0300, Andris Pavenis wrote:
> > Similary as with 2.4.10 mount flag noexec does not work for VFAT
> > partition. I have following in fstab
> > 
> > /dev/hda1      /c       vfat     noexec,gid=201,umask=002,quiet  1    0
> > /dev/hda5      /d       vfat     noexec,gid=201,umask=002,quiet  1    0
> > 
> > but I see that all files in corresponding filesystems are still 
> > exectuable
> 
> Probably because your uid or gid match the above, so your access permission
> is done by checking "user" or "group" and not "other".  Try "umask=113"
> instead.

Um.  'noexec' does not touch flags, it only disallows exec'ing
on particular mountpoint.  So Andris, have you tried executing
anything on those partitions?

umask also sets directory permissions, so with umask=113 you
cant acces any dirs there...

-- 
marko

