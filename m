Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261249AbVCFAKb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbVCFAKb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 19:10:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261274AbVCFAGa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 19:06:30 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:34701 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261273AbVCFAFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 19:05:30 -0500
Date: Sun, 6 Mar 2005 00:05:28 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Jeffrey Mahoney <jeffm@suse.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] blockdev: fixes race between mount/umount
Message-ID: <20050306000528.GE31261@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jeffrey Mahoney <jeffm@suse.com>, Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20050304200445.GA21908@locomotive.unixthugs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050304200445.GA21908@locomotive.unixthugs.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2005 at 03:04:45PM -0500, Jeffrey Mahoney wrote:
> This patch fixes a race between mount and umount in set_blocksize. The results
> can vary between buffer errors and infinite loops in __getblk_slow, and
> possibly others.
> 
> The patch makes set_blocksize run under the bdev_lock if it is the sole holder
> of the block device.
> 
> Changes:
>     - Added missing sync_blockdev in kill_block_super, lost in the shuffle.

Please follow proper kernel codingstyle, thanks.

