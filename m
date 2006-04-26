Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932367AbWDZFMM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367AbWDZFMM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 01:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbWDZFMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 01:12:12 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:45032 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S932367AbWDZFMM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 01:12:12 -0400
Date: Tue, 25 Apr 2006 23:12:05 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: sho@tnes.nec.co.jp
Cc: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] [UPDATE][14/21]e2fsprogs modify variables to exceed 2G
Message-ID: <20060426051205.GL6075@schatzie.adilger.int>
Mail-Followup-To: sho@tnes.nec.co.jp,
	ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20060426104935sho@rifu.tnes.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060426104935sho@rifu.tnes.nec.co.jp>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 26, 2006  10:49 +0900, sho@tnes.nec.co.jp wrote:
> +	blk64_t	end, save_blocks_count, i;
> +		(EXT2_BLOCKS_PER_GROUP(fs->super) * (__u64)fs->group_desc_count) - 1;
> +	blk64_t         start_blk, last_blk;
> +	last_blk = (__u64) group_blk + fs->super->s_blocks_per_group - 1;
>  
> +		start_blk = (__u64) group_blk + fs->inode_blocks_per_group;

If a variable is declared as blk64_t it should be cast to (blk64_t) instead
of (__u64) I think.

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

