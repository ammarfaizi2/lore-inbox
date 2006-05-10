Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751446AbWEJOoX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446AbWEJOoX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 10:44:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751461AbWEJOoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 10:44:23 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:58382 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751446AbWEJOoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 10:44:23 -0400
Date: Wed, 10 May 2006 16:44:25 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Christoph Hellwig <hch@infradead.org>, Daniel Walker <dwalker@mvista.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] xfs gcc 4.1 warning fixes
Message-ID: <20060510144424.GP3570@stusta.de>
References: <200605100256.k4A2u8ho031797@dwalker1.mvista.com> <20060510082746.GC18947@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060510082746.GC18947@infradead.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2006 at 09:27:46AM +0100, Christoph Hellwig wrote:
> On Tue, May 09, 2006 at 07:56:08PM -0700, Daniel Walker wrote:
> > Fixes the following warnings,
> > 
> > fs/xfs/xfs_dir.c: In function 'xfs_dir_removename':
> > fs/xfs/xfs_dir.c:363: warning: 'totallen' may be used uninitialized in this function
> > fs/xfs/xfs_dir.c:363: warning: 'count' may be used uninitialized in this function
> > 
> 
> and so on.  that's all false positives.  gcc should be fixed here, not xfs.

gcc would need to know that xfs_dir_leaf_lookup_int() in xfs_dir_leaf.c 
does never return 0.

This is something gcc can't ever figure out automatically since it's in 
a different source file.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

