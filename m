Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751653AbWBQUMk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751653AbWBQUMk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 15:12:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751660AbWBQUMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 15:12:40 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:45577 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751644AbWBQUMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 15:12:40 -0500
Date: Fri, 17 Feb 2006 21:12:38 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Christoph Hellwig <hch@lst.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] deprecate the tasklist_lock export
Message-ID: <20060217201238.GK4422@stusta.de>
References: <20060215130734.GA5590@lst.de> <20060215214833.GA5066@stusta.de> <20060217112355.GE28448@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060217112355.GE28448@lst.de>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2006 at 12:23:55PM +0100, Christoph Hellwig wrote:
> On Wed, Feb 15, 2006 at 10:48:33PM +0100, Adrian Bunk wrote:
> > On Wed, Feb 15, 2006 at 02:07:34PM +0100, Christoph Hellwig wrote:
> > > Drivers have no business looking at the task list and thus using this
> > > lock.  The only possibly modular users left are:
> > > 
> > >  arch/ia64/kernel/mca.c
> > >...
> > >  fs/binfmt_elf.c
> > > 
> > > which I'll send out fixes for soon.
> > >...
> > 
> > These two can't be built modular.
> 
> s390 and sparc64 allows a modular BINFMT_ELF32, which #includes
> fs/binfmt_elf.c after redefining various things.  But I suspect the
> right fix for this is to disallow building it modular..
>...

Argh, I hate code #include'ing .c files.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

