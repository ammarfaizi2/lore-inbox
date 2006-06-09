Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030213AbWFIPkl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030213AbWFIPkl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 11:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030215AbWFIPkl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 11:40:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:47812 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030213AbWFIPkk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 11:40:40 -0400
Date: Fri, 9 Jun 2006 08:40:14 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jeff@garzik.org>
cc: linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org, Andreas Dilger <adilger@clusterfs.com>,
       cmm@us.ibm.com, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC 0/13] extents and 48bit ext3
In-Reply-To: <448992EB.5070405@garzik.org>
Message-ID: <Pine.LNX.4.64.0606090836160.5498@g5.osdl.org>
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
 <4488E1A4.20305@garzik.org> <20060609083523.GQ5964@schatzie.adilger.int>
 <44898EE3.6080903@garzik.org> <448992EB.5070405@garzik.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 9 Jun 2006, Jeff Garzik wrote:
>
> Overall, I'm surprised that ext3 developers don't see any of the problems
> related to progressive, stealth filesystem upgrades.

Hey, they're used to it - they've been doing it for a long time.

In fact, ext3 wouldn't be ext3 unless I (and perhaps a few others) had 
insisted on it. People wanted to try to upgrade ext2 in place.

And they've been upgrading it in-place for a long time.

Now, there are unquestionably advantages to that approach too, but as you 
say, there are absolutely tons of disadvantages too. Bugs get much much 
subtler, and more disastrous for old users that don't even want the new 
features.

Quite frankly, at this point, there's no way in hell I believe we can do 
major surgery on ext3. It's the main filesystem for a lot of users, and 
it's just not worth the instability worries unless it's something very 
obviously transparent.

I wouldn't mind an ext4 (that hopefully drops some of the features of 
ext3, and might not downgrade to ext2 on errors, for example).

			Linus
