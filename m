Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751214AbWBVMXV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbWBVMXV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 07:23:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbWBVMXV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 07:23:21 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:62478 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751214AbWBVMXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 07:23:20 -0500
Date: Wed, 22 Feb 2006 13:23:17 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "Yu, Luming" <luming.yu@intel.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>,
       "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org
Subject: Re: 2.6.16-rc4: known regressions
Message-ID: <20060222122317.GF4661@stusta.de>
References: <3ACA40606221794F80A5670F0AF15F840B020D85@pdsmsx403>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ACA40606221794F80A5670F0AF15F840B020D85@pdsmsx403>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2006 at 02:55:10PM +0800, Yu, Luming wrote:
> > >Subject    : S3 sleep hangs the second time - 600X
> >> >References : http://bugzilla.kernel.org/show_bug.cgi?id=5989
> >> >Submitter  : Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
> >> >Status     : problematic commit identified,
> >> >             further discussion is in the bug
> >> 
> >> The real problem is there are some bugs hidden by ec_intr=0.
> >> ec_intr=1 just get these bug  just exposed, and we need to fix them. 
> >
> >From a users' point of view, these are regressions from 
> >2.6.15, and not 
> >all of them might be fixed in time for 2.6.16.
> >
> >What is a possible short term solution/workaround for 2.6.16?
> 
> ec_intr=0 is a reasonable workaround for this box,
> if we couldn't root-cause and fix the real problem on time.
> 
> >Can we go back to default to polling mode in 2.6.16?
> 
> No, don't do this.  There are other laptops need this. And I didn't
> get regression report that is root-caused to enabling ec_intr=1 by
> default. If you argue bug 5989, 6075 could be,  I think
> the truth is, for 5989, we need to fix thermal and processor driver
> issue.

We do both agree that defaulting to polling mode is not a long term 
solution.

The question is what to do until it's resolved - assuming that issues 
like 5989 might not be fixed in time for 2.6.16.

Breaking setups working with the defaults under 2.6.15 in 2.6.16 doesn't 
sound that good.

> for 6075, we need to fix interrupt issue.

As far as I understand 6075, the submitter already tried ec_intr=0 
without success.

> So far, I don't think we need o fall back.
> 
> Thanks,
> Luming

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

