Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262264AbVEMIpL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262264AbVEMIpL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 04:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262303AbVEMIpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 04:45:11 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:57820 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262264AbVEMIpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 04:45:06 -0400
Date: Fri, 13 May 2005 09:44:54 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, xfs-masters@oss.sgi.com, nathans@sgi.com,
       linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] fs/xfs/: possible cleanups
Message-ID: <20050513084454.GA918@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
	xfs-masters@oss.sgi.com, nathans@sgi.com, linux-xfs@oss.sgi.com,
	linux-kernel@vger.kernel.org
References: <20050513004721.GS3603@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050513004721.GS3603@stusta.de>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2005 at 02:47:21AM +0200, Adrian Bunk wrote:
> This patch contains the following possible cleanups:
> - make needlessly global code static
> - remove the obsolete support/qsort.c
> - debug.c: remove the read-only global variable doass
>            (replaced by a #define)
> - #if 0 the following unused global functions:
>   - quota/xfs_dquot.c: xfs_qm_dqwarn
>   - xfs_bmap_btree.c: xfs_bmbt_lookup_le
>   - xfs_fsops.c: xfs_fs_log_dummy
>   - xfs_inode.c: xfs_inobp_bwcheck
>   - xfs_trans.c: xfs_trans_callback
>   - xfs_trans_inode.c: xfs_trans_ihold_release
> 
> Please check which of these changes do make sense.

I'll take care of getting this patch into the XFS tree.  Hopefully
we can just remove the unused global functions, but I'll have to check
first whether they might be used by the userland tools.
