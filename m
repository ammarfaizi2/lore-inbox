Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967007AbWK2K5q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967007AbWK2K5q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 05:57:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967119AbWK2K5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 05:57:46 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:47369 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S967007AbWK2K5p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 05:57:45 -0500
Date: Wed, 29 Nov 2006 11:57:50 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] fs/sysv/: proper prototypes for 2 functions
Message-ID: <20061129105750.GV11084@stusta.de>
References: <20061129100405.GI11084@stusta.de> <20061129100600.GA28151@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061129100600.GA28151@infradead.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2006 at 10:06:00AM +0000, Christoph Hellwig wrote:
> On Wed, Nov 29, 2006 at 11:04:05AM +0100, Adrian Bunk wrote:
> > This patch adds proper prototypes for sysv_{init,destroy}_icache()
> > in sysv.h
> > 
> > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> > 
> > ---
> > 
> >  fs/sysv/super.c |    3 ---
> >  fs/sysv/sysv.h  |    3 +++
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> > 
> > --- linux-2.6.19-rc6-mm2/fs/sysv/sysv.h.old	2006-11-29 09:21:02.000000000 +0100
> > +++ linux-2.6.19-rc6-mm2/fs/sysv/sysv.h	2006-11-29 09:21:52.000000000 +0100
> > @@ -143,6 +143,9 @@
> >  extern int sysv_sync_file(struct file *, struct dentry *, int);
> >  extern void sysv_set_inode(struct inode *, dev_t);
> >  extern int sysv_getattr(struct vfsmount *, struct dentry *, struct kstat *);
> > +int sysv_init_icache(void);
> > +void sysv_destroy_icache(void);
> 
> Please follow the style used in the rest of the file and add the
> extern keyword.

Is it acceptable to remove all the extern's instead?

> > +
> 
> And don't add a superflous blank line.
> 
> Except for that the patch is fine.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

