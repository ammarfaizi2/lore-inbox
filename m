Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277530AbRJJXzQ>; Wed, 10 Oct 2001 19:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277546AbRJJXzF>; Wed, 10 Oct 2001 19:55:05 -0400
Received: from [216.151.155.121] ([216.151.155.121]:6930 "EHLO
	belphigor.mcnaught.org") by vger.kernel.org with ESMTP
	id <S277530AbRJJXyy>; Wed, 10 Oct 2001 19:54:54 -0400
To: Andreas Dilger <adilger@turbolabs.com>
Cc: Lew Wolfgang <wolfgang@sweet-haven.com>, linux-kernel@vger.kernel.org
Subject: Re: Dump corrupts ext2?
In-Reply-To: <Pine.LNX.4.33.0110101558210.7049-100000@train.sweet-haven.com>
	<m3elob3xao.fsf@belphigor.mcnaught.org>
	<20011010173449.Q10443@turbolinux.com>
From: Doug McNaught <doug@wireboard.com>
Date: 10 Oct 2001 19:55:16 -0400
In-Reply-To: Andreas Dilger's message of "Wed, 10 Oct 2001 17:34:49 -0600"
Message-ID: <m33d4r3va3.fsf@belphigor.mcnaught.org>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) XEmacs/21.1 (20 Minutes to Nikko)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger <adilger@turbolabs.com> writes:

> On Oct 10, 2001  19:11 -0400, Doug McNaught wrote:
> > I'm pretty sure this is because dump reads the block device directly
> > (which is cached in the buffer cache), while the file data for cached
> > files lives in the page cache, and the two caches are no longer
> > coherent (as of 2.4).
> 
> In Linus kernels 2.4.11+ the block devices and filesystems all use the
> page cache, so no more coherency issues.

You're right, of course.  But for most of the lifetime of 2.4 the
above was true...

> Also, I don't think this ever had the potential to corrupt the filesystem,
> but maybe make a slightly bad backup.

Right, might corrupt the dump, but shouldn't hurt the filesystem.  

-Doug
-- 
Let us cross over the river, and rest under the shade of the trees.
   --T. J. Jackson, 1863
