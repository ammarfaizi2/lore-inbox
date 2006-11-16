Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424306AbWKPW1u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424306AbWKPW1u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 17:27:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754874AbWKPW1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 17:27:50 -0500
Received: from mail.clusterfs.com ([206.168.112.78]:61622 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S1754857AbWKPW1t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 17:27:49 -0500
Date: Thu, 16 Nov 2006 15:27:47 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Jeff Mahoney <jeffm@jeffreymahoney.com>
Cc: linux-fsdevel@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ext4@vger.kernel.org, Eric Sandeen <esandeen@redhat.com>
Subject: Re: [PATCH] ext3: htree entry integrity checking
Message-ID: <20061116222747.GT6012@schatzie.adilger.int>
Mail-Followup-To: Jeff Mahoney <jeffm@jeffreymahoney.com>,
	linux-fsdevel@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-ext4@vger.kernel.org, Eric Sandeen <esandeen@redhat.com>
References: <455C96DC.4060907@jeffreymahoney.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <455C96DC.4060907@jeffreymahoney.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 16, 2006  11:50 -0500, Jeff Mahoney wrote:
>  Currently, if a corrupted directory entry with rec_len=0 is encountered,
>  we still trust that the data is valid. This can cause an infinite loop
>  in htree_dirblock_to_tree() since the iteration loop will never make any
>  progress.

Actually, I think Eric Sandeen was working on similar fixes already, and
instead of doing a per-item check each time we look at the entry it does
a full-block check the first time it is read (as ext2 does).

>  This fixes the problem described at:
>  http://projects.info-pull.com/mokb/MOKB-10-11-2006.html

Would also be good to CC linux-ext4, where the ext3 maintainers live.
Hmm, maybe we need to update MAINTAINERS with the new list address?

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

