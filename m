Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751317AbWEAHfR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbWEAHfR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 03:35:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbWEAHfR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 03:35:17 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:57105 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751317AbWEAHfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 03:35:16 -0400
Date: Mon, 1 May 2006 09:35:14 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] kernel/sys.c: possible cleanups
Message-ID: <20060501073514.GQ3570@stusta.de>
References: <20060501071134.GH3570@stusta.de> <20060501001803.48ac34df.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060501001803.48ac34df.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 01, 2006 at 12:18:03AM -0700, Andrew Morton wrote:
> Adrian Bunk <bunk@stusta.de> wrote:
> >
> > This patch contains the following possible cleanups:
> 
> Please avoid mixing together cleanups
> 
> >  - proper prototypes for the following functions:
> >    - ctrl_alt_del()  (in include/linux/reboot.h)
> >    - getrusage()     (in include/linux/resource.h)
> >  - make the following needlessly global functions static:
> >    - kernel_restart_prepare()
> >    - kernel_kexec()
> 
> which I will apply, together with API changes

Are you splitting the patch yourself or should I send a splitted patch?

> >  - remove the following unused EXPORT_SYMBOL:
> >    - in_egroup_p
> >  - remove the following unused EXPORT_SYMBOL_GPL's:
> >    - kernel_restart
> >    - kernel_halt
> 
> which I will not.
> 
> We have a process for the latter.  And even if we ignore that process, the
> patch ends up sitting in -mm for ages because of the API change, along with
> the cleanups, which could be merged up promptly.

The problem is that we have a lack of a process at the other end:

There is no process to review added exports.

And there are so many exports added with "we will soon use them".

If removing exports requires a process, adding exports requires a 
similar process.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

