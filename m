Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264388AbUG2Lmo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264388AbUG2Lmo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 07:42:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264085AbUG2Lmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 07:42:44 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:54724 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264388AbUG2Lmc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 07:42:32 -0400
Date: Thu, 29 Jul 2004 13:42:19 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Nathan Scott <nathans@sgi.com>
Cc: "Jeffrey E. Hundstad" <jeffrey.hundstad@mnsu.edu>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Steve Lord <lord@xfs.org>, linux-xfs@oss.sgi.com,
       xfs-masters@oss.sgi.com,
       Cahya Wirawan <cwirawan@email.archlab.tuwien.ac.at>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] let 4KSTACKS depend on EXPERIMENTAL and XFS on 4KSTACKS=n
Message-ID: <20040729114219.GN2349@fs.tum.de>
References: <20040720114418.GH21918@email.archlab.tuwien.ac.at> <40FD0A61.1040503@xfs.org> <40FD2E99.20707@mnsu.edu> <20040720195012.GN14733@fs.tum.de> <20040729060900.GA1946@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040729060900.GA1946@frodo>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2004 at 04:09:00PM +1000, Nathan Scott wrote:
> On Tue, Jul 20, 2004 at 09:50:12PM +0200, Adrian Bunk wrote:
> > 
> > The patch below does:
> > 
> > 1. let 4KSTACKS depend on EXPERIMENTAL
> > Rationale:
> > 4Kb stacks on i386 are the future. But currently this option might still 
> > cause problems in some areas of the kernel. OTOH, 4Kb stacks isn't a big 
> > gain for most people.
> > 2.6 is a stable kernel series, and 4KSTACKS=n is the safe choice.
> > Once all issues with 4KSTACKS=y are resolved this can be reverted.
> 
> Seems fine.
> 
> > 2. let XFS depend on (4KSTACKS=n || BROKEN)
> > Rationale:
> > Mark Loy said:
> >   Don't use 4K stacks and XFS.
> 
> Who is Mark Loy?  (and what does he know about XFS?)

I don't know where I got this name from.

I wanted to write "Steve Lord".

(Sorry for the confusion.)

> > Mark this combination as BROKEN until XFS is fixed.
> 
> This part is not useful.  We want to hear about problems
> that people hit with 4K stacks so we can try to address
> them, and it mostly works as is.

2.6 is a stable kernel series used in production environments.

Regarding Linus' tree, it's IMHO the best solution to work around it 
this way until all issues are sorted out.

Feel free to revert it in -mm later, since there are many brave souls  
running -mm you'll still get to hear about problems.

> cheers.
> Nathan

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

