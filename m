Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261741AbTFHMjS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 08:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261743AbTFHMjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 08:39:18 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:36292 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261741AbTFHMjQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 08:39:16 -0400
Date: Sun, 8 Jun 2003 14:52:49 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Christoph Hellwig <hch@infradead.org>, lord@sgi.com, linux-xfs@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.70-mm5: XFS compile error if CONFIG_SYSCTL && !CONFIG_PROC_FS
Message-ID: <20030608125249.GE16164@fs.tum.de>
References: <20030607140844.GM15311@fs.tum.de> <20030608120159.A450@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030608120159.A450@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 08, 2003 at 12:01:59PM +0100, Christoph Hellwig wrote:
> On Sat, Jun 07, 2003 at 04:08:44PM +0200, Adrian Bunk wrote:
> > I'm getting the following compile error in 2.5.70-mm5 if CONFIG_SYSCTL 
> > && !CONFIG_PROC_FS:
> > 
> > <--  snip  -->
> > 
> > ...
> >   CC      fs/xfs/linux/xfs_sysctl.o
> > fs/xfs/linux/xfs_sysctl.c: In function `xfs_stats_clear_proc_handler':
> > fs/xfs/linux/xfs_sysctl.c:61: `xfsstats' undeclared (first use in this function)
> > fs/xfs/linux/xfs_sysctl.c:61: (Each undeclared identifier is reported only once
> > fs/xfs/linux/xfs_sysctl.c:61: for each function it appears in.)
> > make[2]: *** [fs/xfs/linux/xfs_sysctl.o] Error 1
> 
> This should fix it:
>...

Thanks, I can confirm your patch fixes the problem.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

