Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266479AbUG0Rnv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266479AbUG0Rnv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 13:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266493AbUG0Rnv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 13:43:51 -0400
Received: from out011pub.verizon.net ([206.46.170.135]:45241 "EHLO
	out011.verizon.net") by vger.kernel.org with ESMTP id S266479AbUG0Rno
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 13:43:44 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Organization: Organization: undetectable
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc2 crashes
Date: Tue, 27 Jul 2004 13:43:43 -0400
User-Agent: KMail/1.6
References: <200407271233.04205.gene.heskett@verizon.net> <200407271302.41321.gene.heskett@verizon.net> <20040727095118.7620f801.rddunlap@osdl.org>
In-Reply-To: <20040727095118.7620f801.rddunlap@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200407271343.43583.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out011.verizon.net from [151.205.53.180] at Tue, 27 Jul 2004 12:43:44 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 27 July 2004 12:51, Randy.Dunlap wrote:
>On Tue, 27 Jul 2004 13:02:41 -0400 Gene Heskett wrote:
>| On Tuesday 27 July 2004 10:29,
>| viro@parcelfarce.linux.theplanet.co.uk
>|
>| wrote:
>| >On Tue, Jul 27, 2004 at 12:33:04PM -0400, Gene Heskett wrote:
>| >> Greetings everybody;
>| >>
>| >> I have now had 4 crashes while running 2.6.8-rc2, the last one
>| >> requiring a full powerdown before the intel-8x0 could
>| >> re-establish control over the sound.
>| >>
>| >> All have had an initial Opps located in prune_dcache, and were
>| >> logged as follows:
>| >> Jul 27 07:58:58 coyote kernel: Unable to handle kernel NULL
>| >> pointer dereference at virtual address 00000000
>| >
>| >... which means that dentry_unused list got corrupted, which
>| > doesn't really help.  Could you try to narrow it down to
>| > 2.6.8-rc1-bk<day>?
>|
>| I don't have bitkeeper installed.  I get my patches from
>| kernel.org, either from the main Linus tree, or Andrews akpm tree.
>| Is there someplace where I can dl a patchkit that leads up to rc1
>| by the "daily" snapshot?  Or should I just get the 'broken out'
>| patch after I verify that it also occurs with rc1 of course.  That
>| I haven't done, mainly because rc2 has a lot of usb bugfixes and
>| my mouse hasn't died all by itself on rc2 like it was for at least
>| 2 dozen patches before rc2.  IIRC it did a time or 2 on rc1.
>
>In case you need daily bk snapshots, they are here:
>  http://www.kernel.org/pub/linux/kernel/v2.6/snapshots/

Thanks Randy, got all 6 of them.

>| It takes a < 1 day for this to occur usually, but seems to occur
>| after a long session of doing something else that fails. (or maybe
>| causes the fail, of a make install in konstruct/meta/kde)  Thats
>| running now, someplace in kdegraphics-3.2.92 from the looks of it.

I take it that I should apply these to a 2.6.7 tarballs tree in this 
order:
1. 2.6.8-rc1
2. each of these 'rc2-bk' patches by the day and then run each for a 
couple days, or should I start in the middle, say the 3rd one and 
work forward or backwards from there depending on the results?

Your (and Viro's) call.  I'd imagine you would want to run this to 
earth as quick as we can.

Are these patches cumulative?  I presume they are as they grow by the 
day.

-- 
Cheers, Gene
There are 4 boxes to be used in defense of liberty. 
Soap, ballot, jury, and ammo.
Please use in that order, starting now.  -Ed Howdershelt, Author
Additions to this message made by Gene Heskett are Copyright 2004, 
Maurice E. Heskett, all rights reserved.
