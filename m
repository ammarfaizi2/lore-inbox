Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266223AbSKFXtF>; Wed, 6 Nov 2002 18:49:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266227AbSKFXtE>; Wed, 6 Nov 2002 18:49:04 -0500
Received: from n1x6.imsa.edu ([143.195.1.6]:45771 "EHLO mail.imsa.edu")
	by vger.kernel.org with ESMTP id <S266223AbSKFXtD>;
	Wed, 6 Nov 2002 18:49:03 -0500
Date: Wed, 6 Nov 2002 17:55:42 -0600
From: Maciej Babinski <maciej@imsa.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.46 ext3 errors
Message-ID: <20021106175542.A8364@imsa.edu>
References: <20021106075406.GC1137@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021106075406.GC1137@suse.de>; from axboe@suse.de on Wed, Nov 06, 2002 at 08:54:06AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got this same error while running "seq 1000000|xargs touch"
in an otherwise empty directory. It got as far as about 20,000
files before the filesystem was remounted ro.

On Wed, Nov 06, 2002 at 08:54:06AM +0100, Jens Axboe wrote:
> Hi,
> 
> Doing a kernel compile, the file system suddenly turned read-only.
> Following messages appeared in log:
> 
> EXT3-fs error (device ide1(22,1)): ext3_new_inode: Free inodes count corrupted in group 688 Aborting journal on device ide1(22,1).
> ext3_new_inode: aborting transaction: Journal has aborted in __ext3_journal_get_write_access<2>EXT3-fs error (device ide1(22,1)) in ext3_new_inode: Journal has aborted
> EXT3-fs error (device ide1(22,1)) in ext3_create: Journal has aborted ext3_abort called.
> EXT3-fs abort (device ide1(22,1)): ext3_journal_start: Detected aborted journal
> Remounting filesystem read-only
> 
> -- 
> Jens Axboe
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
