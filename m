Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135654AbREBRWO>; Wed, 2 May 2001 13:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135659AbREBRWF>; Wed, 2 May 2001 13:22:05 -0400
Received: from [208.204.44.103] ([208.204.44.103]:37384 "EHLO
	warpcore.provalue.net") by vger.kernel.org with ESMTP
	id <S135654AbREBRVq> convert rfc822-to-8bit; Wed, 2 May 2001 13:21:46 -0400
Date: Wed, 2 May 2001 11:22:40 -0500 (CDT)
From: Collectively Unconscious <swarm@warpcore.provalue.net>
To: =?iso-8859-1?Q?Samuli_K=E4rkk=E4inen?= <skarkkai@woods.iki.fi>
cc: linux-kernel@vger.kernel.org
Subject: Re: Wrong free inodes count in kernels 2.0 and 2.2
In-Reply-To: <20010502194621.D22433@woods.iki.fi>
Message-ID: <Pine.LNX.4.10.10105021115350.12683-100000@warpcore.provalue.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 2 May 2001, [iso-8859-1] Samuli Kärkkäinen wrote:

> I get repeatably both in 2.0 and 2.2 serieses of kernels the following kind
> of errors:
> 
> 2.2 kernels (several, including 2.2.18):
>   EXT2-fs error (device ide1(22,6)): ext2_check_inodes_bitmap: Wrong free inodes count in group 768, stored = 984, counted = 717
>   EXT2-fs error (device ide1(22,6)): ext2_check_inodes_bitmap: Wrong free inodes count in group 769, stored = 1005, counted = 717
>   EXT2-fs error (device ide1(22,6)): ext2_check_inodes_bitmap: Wrong free inodes count in group 777, stored = 998, counted = 901
>   [ many similar lines deleted ]
> 
> and sometimes with 2.2 kernel, soon after the errors above:
>   EXT2-fs error (device ide1(22,1)): ext2_new_inode: Free inodes count corrupted in group 414 
>   last message repeated 795 times

We were getting this error on 4 of our arrays. We weren't able to track
down the original error, but the continuing problem turned out to be that
in "correcting" the errors fsck did not restore the drive to a stable
state and it would eventually corrupt itself again. 

If this is the same problem, force fsck until it no longer finds any
errors on the drive.

Jay

