Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261537AbUCOLCl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 06:02:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261554AbUCOLCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 06:02:41 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:59578 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261537AbUCOLCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 06:02:40 -0500
Date: Mon, 15 Mar 2004 12:02:38 +0100
From: Jan Kara <jack@suse.cz>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Adrian Bunk <bunk@fs.tum.de>, ext3-users@redhat.com
Subject: Re: 2.6.4-mm1: modular quota needs unknown symbol
Message-ID: <20040315110238.GB5465@atrey.karlin.mff.cuni.cz>
References: <20040310233140.3ce99610.akpm@osdl.org> <20040311202352.GD14833@fs.tum.de> <200403120951.57637@WOLK>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403120951.57637@WOLK>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thursday 11 March 2004 21:23, Adrian Bunk wrote:
> 
> Hi Adrian,
> 
> > On Wed, Mar 10, 2004 at 11:31:40PM -0800, Andrew Morton wrote:
> > >...
> > > ext3-journalled-quotas-2.patch
> > >   ext3: journalled quota
> > >...
> 
> > This patch broke modular quota:
> >   WARNING: /lib/modules/2.6.4-mm1/kernel/fs/quota_v2.ko needs unknown
> >   symbol mark_info_dirty
> 
> Patch attached (again) ;)
  Yes, the patch is right... I tested modular filesystem but forgot
about modular quota formats ;(.

								Honza

> --- old/fs/dquot.c	2004-03-08 23:49:35.000000000 +0100
> +++ new/fs/dquot.c	2004-03-08 23:51:02.000000000 +0100
> @@ -1733,3 +1733,4 @@ EXPORT_SYMBOL(dquot_alloc_inode);
>  EXPORT_SYMBOL(dquot_free_space);
>  EXPORT_SYMBOL(dquot_free_inode);
>  EXPORT_SYMBOL(dquot_transfer);
> +EXPORT_SYMBOL(mark_info_dirty);

-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
