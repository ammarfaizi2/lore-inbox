Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130723AbQKCPz4>; Fri, 3 Nov 2000 10:55:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130776AbQKCPzq>; Fri, 3 Nov 2000 10:55:46 -0500
Received: from [62.172.234.2] ([62.172.234.2]:35466 "EHLO saturn.homenet")
	by vger.kernel.org with ESMTP id <S130723AbQKCPzc>;
	Fri, 3 Nov 2000 10:55:32 -0500
Date: Fri, 3 Nov 2000 15:56:36 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Hans Reiser <hans@reiser.to>
cc: linux-kernel@vger.kernel.org
Subject: Re: panic in reiserfs: _get_block_create_0 gets bh_result->b_data
 = NULL
In-Reply-To: <Pine.LNX.4.21.0011031549440.1019-100000@saturn.homenet>
Message-ID: <Pine.LNX.4.21.0011031556120.1019-100000@saturn.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Nov 2000, Tigran Aivazian wrote:

> Hi Hans,
> 
> Simply starting the validation phase of SPEC SFS with NFS mounted reiserfs
> filesystem panics as shown in the log below. A quick look at the source
> suggests that _get_block_create_0() (and therefore, more generally,
> reiserfs_get_block()) was passed a buffer head bh_result with ->b_data =
> NULL. So, we panic at line 256 of fs/reiserfs/inode.c when doing:
> 
> memset (bh_result->b_data, 0, inode->i_sb->s_blocksize)
> 

I meant line 356 of course - typo.

Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
