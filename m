Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261684AbVA3MAT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261684AbVA3MAT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 07:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261685AbVA3MAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 07:00:19 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:2058 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261684AbVA3MAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 07:00:12 -0500
Date: Sun, 30 Jan 2005 13:00:09 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Paul Blazejowski <diffie@gmail.com>, linux-kernel@vger.kernel.org,
       Nathan Scott <nathans@sgi.com>
Subject: Re: 2.6.11-rc2-mm2
Message-ID: <20050130120009.GG3185@stusta.de>
References: <9dda349205012923347bc6a456@mail.gmail.com> <20050129235653.1d9ba5a9.akpm@osdl.org> <20050130105429.GA28300@infradead.org> <20050130105738.GA28387@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050130105738.GA28387@infradead.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 30, 2005 at 10:57:38AM +0000, Christoph Hellwig wrote:
> On Sun, Jan 30, 2005 at 10:54:29AM +0000, Christoph Hellwig wrote:
> > We want to avoid building xfs_export.o when CONFIG_EXPORTFS
> > isn't set.  CONFIG_XFS_EXPORT=y and CONFIG_EXPORTFS=m worked for
> > me in my testing.  Do you have XFS builtin or modular?
> > 
> > I suspect we need to add another weird depency to force XFS builtin
> > when NFSD is modular.
> 
> s/modular/builtin/ in the last sentence

His problem is:
- CONFIG_NFSD=m
- CONFIG_EXPORTFS=m
- CONFIG_XFS=y
- CONFIG_XFS_EXPORT=y

The builtin fs/xfs/linux-2.6/xfs_export.c can't call the function 
find_exported_dentry in the modular fs/exportfs/expfs.c .



cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

