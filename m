Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751260AbWD0Has@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbWD0Has (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 03:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbWD0Has
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 03:30:48 -0400
Received: from TYO206.gate.nec.co.jp ([202.32.8.206]:52942 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S1751260AbWD0Har (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 03:30:47 -0400
To: adilger@clusterfs.com
Cc: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] [UPDATE][14/21]e2fsprogs modify variables to exceed 2G
Message-Id: <20060427163038sho@rifu.tnes.nec.co.jp>
Mime-Version: 1.0
X-Mailer: WeMail32[2.51] ID:1K0086
From: sho@tnes.nec.co.jp
Date: Thu, 27 Apr 2006 16:30:38 +0900
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your comment, Andreas

On Apr 26, 2006, Andreas wrote:
> > +	blk64_t	end, save_blocks_count, i;
> > +		(EXT2_BLOCKS_PER_GROUP(fs->super) *
> (__u64)fs->group_desc_count) - 1;
> > +	blk64_t         start_blk, last_blk;
> > +	last_blk = (__u64) group_blk +
> fs->super->s_blocks_per_group - 1;
> >  
> > +		start_blk = (__u64) group_blk +
> fs->inode_blocks_per_group;
> 
> If a variable is declared as blk64_t it should be cast to
> (blk64_t) instead of (__u64) I think.

I see your point.  I checked the whole patches, and found other places.
And now I resend 4 update-patches.

Cheers, sho
