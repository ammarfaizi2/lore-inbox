Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932679AbWF2VSv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932679AbWF2VSv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 17:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932680AbWF2VSv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 17:18:51 -0400
Received: from [141.84.69.5] ([141.84.69.5]:39697 "HELO mailout.stusta.mhn.de")
	by vger.kernel.org with SMTP id S932679AbWF2VSu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 17:18:50 -0400
Date: Thu, 29 Jun 2006 23:18:08 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] kernel/sys.c: remove unused exports
Message-ID: <20060629211807.GH19712@stusta.de>
References: <20060629191940.GL19712@stusta.de> <20060629123608.a2a5c5c0.akpm@osdl.org> <20060629124400.ee22dfbf.akpm@osdl.org> <20060629195828.GF19712@stusta.de> <20060629130633.3da327b6.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060629130633.3da327b6.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2006 at 01:06:33PM -0700, Andrew Morton wrote:
> On Thu, 29 Jun 2006 21:58:28 +0200
> Adrian Bunk <bunk@stusta.de> wrote:
> 
> > On Thu, Jun 29, 2006 at 12:44:00PM -0700, Andrew Morton wrote:
> > > On Thu, 29 Jun 2006 12:36:08 -0700
> > > Andrew Morton <akpm@osdl.org> wrote:
> > > 
> > > > On Thu, 29 Jun 2006 21:19:40 +0200
> > > > Adrian Bunk <bunk@stusta.de> wrote:
> > > > 
> > > > > This patch removes the following unused exports:
> > > > > - EXPORT_SYMBOL:
> > > > >   - in_egroup_p
> > > > > - EXPORT_SYMBOL_GPL's:
> > > > >   - kernel_restart
> > > > >   - kernel_halt
> > > > 
> > > > Switch 'em to EXPORT_UNUSED_SYMBOL and I'll stop dropping your patches ;)
> > > > 
> > > 
> > > If doing this, I'd suggest it be done thusly:
> > > 
> > > EXPORT_UNUSED_SYMBOL(in_egroup_p);	/* June 2006 */
> > > 
> > > to aid later decision-making.
> > 
> > I had some bad experiences with following processes you suggest the 
> > doesn't remove the symbol immediately:
> > 
> > As you wanted me to do, I scheduled the EXPORT_SYMBOL(insert_resource) 
> > for removal on 2 May 2005 with both __deprecated_for_modules and an 
> > entry in feature-removal-schedule.txt with the target date April 2006.
> > 
> > On 11 Apr 2006, I sent the patch to implement this scheduled removal.
> > 
> > As of today, the latter patch is still stuck in -mm (which isn't better 
> > than having it dropped) although it's long overdue.
> 
> Blame Greg ;)

Why?

> > Do you understand why I distrust your "to aid later decision-making"?
> 
> You'll cope.
> 
> > Can you state publically "If there's still no in-kernel user after six 
> > months, the removal is automatically ACK'ed."?
> 
> 6 or 12.  We haven't decided.  6 sounds OK.  If nobody complains.  If
> they do, we rethink a particular export.

OK, I hope I'll have more luck with this process.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

