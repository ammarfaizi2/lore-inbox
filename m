Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932327AbWDUQxy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932327AbWDUQxy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 12:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932417AbWDUQxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 12:53:54 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:60426 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932407AbWDUQxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 12:53:52 -0400
Date: Fri, 21 Apr 2006 18:53:51 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Steven Whitehouse <swhiteho@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/16] GFS2: Makefiles and Kconfig
Message-ID: <20060421165351.GG19754@stusta.de>
References: <1145636558.3856.118.camel@quoit.chygwyn.com> <20060421164309.GE19754@stusta.de> <20060421164910.GV24104@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060421164910.GV24104@parisc-linux.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2006 at 10:49:10AM -0600, Matthew Wilcox wrote:
> On Fri, Apr 21, 2006 at 06:43:09PM +0200, Adrian Bunk wrote:
> > > --- /dev/null
> > > +++ b/fs/gfs2/Kconfig
> > > @@ -0,0 +1,46 @@
> > > +config GFS2_FS
> > > +        tristate "GFS2 file system support"
> > > +	default m
> > > +	depends on EXPERIMENTAL
> > > +        select FS_POSIX_ACL
> > > +        select SYSFS
> > >...
> > 
> > - "depends on SYSFS" instead of the select
> 
> Why?  It's more natural to select it rather than depend on it.

The rule of thumb is that an option is either user visible and should be 
depended on or not user visible and should be select'ed.

Exceptions are possible, but there should be a good reason for them.

It doesn't matter much in this case unless you are really expecting 
people to use EMBEDDED=y (IOW: _very_ space limited system) and 
GFS2_FS=y/m.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

