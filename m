Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264984AbSKFLPN>; Wed, 6 Nov 2002 06:15:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264985AbSKFLPN>; Wed, 6 Nov 2002 06:15:13 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:31753 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id <S264984AbSKFLPM>;
	Wed, 6 Nov 2002 06:15:12 -0500
Date: Wed, 6 Nov 2002 12:21:27 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: Andreas Dilger <adilger@clusterfs.com>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-rc1 dirty ext2 mount error
Message-ID: <20021106112127.GD879@alpha.home.local>
References: <20021106084143.GN588@clusterfs.com> <24197.1036579429@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24197.1036579429@ocs3.intra.ocs.com.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2002 at 09:43:49PM +1100, Keith Owens wrote:
 
> VFS said that / was ext2, init ran fsck.ext2 against /, fstab says /
> whoudl be ext2 and mount claims that it is ext2.  Lies!  It is still
> ext3, the only indication is that lsmod shows a use count of 1 against
> ext3.  Crashing out of this kernel and into 2.4.20-rc1 which has no
> initrd gets the error.  And I thought I had got rid of ext3 ...

I think that /proc/mounts should have correctly reported ext3. I used to have
"mount" report misinformation to mtab, which is one of the reasons why I got
rid of it.

Cheers,
Willy
