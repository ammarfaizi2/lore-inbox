Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272737AbRJKGJw>; Thu, 11 Oct 2001 02:09:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272818AbRJKGJh>; Thu, 11 Oct 2001 02:09:37 -0400
Received: from gulbis.latnet.lv ([159.148.108.9]:9991 "HELO gulbis.latnet.lv")
	by vger.kernel.org with SMTP id <S272593AbRJKGJY>;
	Thu, 11 Oct 2001 02:09:24 -0400
Date: Thu, 11 Oct 2001 09:09:54 +0300 (EEST)
From: Andris Pavenis <pavenis@latnet.lv>
To: Marko Kreen <marko@l-t.ee>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.11: mount flag noexec still broken for VFAT partition
In-Reply-To: <20011011003609.B18573@l-t.ee>
Message-ID: <Pine.LNX.4.21.0110110828290.29091-100000@gulbis.latnet.lv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




On Thu, 11 Oct 2001, Marko Kreen wrote:

> On Wed, Oct 10, 2001 at 03:13:33PM -0600, Andreas Dilger wrote:
> > On Oct 10, 2001  23:01 +0300, Andris Pavenis wrote:
> > > Similary as with 2.4.10 mount flag noexec does not work for VFAT
> > > partition. I have following in fstab
> > > 
> > > /dev/hda1      /c       vfat     noexec,gid=201,umask=002,quiet  1    0
> > > /dev/hda5      /d       vfat     noexec,gid=201,umask=002,quiet  1    0
> > > 
> > > but I see that all files in corresponding filesystems are still 
> > > exectuable
> > 
> > Probably because your uid or gid match the above, so your access permission
> > is done by checking "user" or "group" and not "other".  Try "umask=113"
> > instead.
> 
> Um.  'noexec' does not touch flags, it only disallows exec'ing
> on particular mountpoint.  So Andris, have you tried executing
> anything on those partitions?
> 
> umask also sets directory permissions, so with umask=113 you
> cant acces any dirs there...
> 

Yes I cannot really execute them (or some Linux executable if I copy it
there). I didn't verify it earlier. Anyway I better liked behaviour of 2.2
kernels and also 2.4 kernels up to rather recent time when 
'ls -l' listed files as not executable (the same with mc)

Andris


