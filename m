Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161002AbWFJT1p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161002AbWFJT1p (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 15:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161005AbWFJT1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 15:27:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27076 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161002AbWFJT1n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 15:27:43 -0400
Date: Sat, 10 Jun 2006 12:27:30 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Kyle Moffett <mrmacman_g4@mac.com>
cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org, Andreas Dilger <adilger@clusterfs.com>,
       cmm@us.ibm.com, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC 0/13] extents and 48bit ext3
In-Reply-To: <2DFFC56C-2516-449F-990E-71DDE2601531@mac.com>
Message-ID: <Pine.LNX.4.64.0606101222210.5498@g5.osdl.org>
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
 <4488E1A4.20305@garzik.org> <20060609083523.GQ5964@schatzie.adilger.int>
 <44898EE3.6080903@garzik.org> <448992EB.5070405@garzik.org>
 <2DFFC56C-2516-449F-990E-71DDE2601531@mac.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 10 Jun 2006, Kyle Moffett wrote:
> 
> One possible solution to the version-confusion that would avoid duplicating
> features would be to merge the fs/ext{2,3} to fs/ext, then make fs/ext
> register itself as a filesystem under "ext2", "ext3", and "ext4".

But the thing is, technical people don't actually care about the version 
confusion.

The real issue is that ext3 is a stable filesystem, and the ext4 stuff 
buys fundamentally and absolutely _nothing_ for the vast majority of uses. 
Except pain.

So the real reason for the split would be the _user_ split. There are 
people who want big filesystems, and there are people who don't care. 

It's that simple.

> I've heard quite some griping about the amount of duplicated code 
> between ext2 and ext3;

That's a total piece of bullshit. Nobody seriously gripes about the 
duplication, and the ones that do have absolutely no idea what that split 
bought us. Ignore them.

			Linus
