Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266484AbUG0Rwz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266484AbUG0Rwz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 13:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266494AbUG0Rwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 13:52:55 -0400
Received: from fw.osdl.org ([65.172.181.6]:674 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266484AbUG0Rww (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 13:52:52 -0400
Date: Tue, 27 Jul 2004 10:32:56 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc2 crashes
Message-Id: <20040727103256.2691d6f9.rddunlap@osdl.org>
In-Reply-To: <200407271343.43583.gene.heskett@verizon.net>
References: <200407271233.04205.gene.heskett@verizon.net>
	<200407271302.41321.gene.heskett@verizon.net>
	<20040727095118.7620f801.rddunlap@osdl.org>
	<200407271343.43583.gene.heskett@verizon.net>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jul 2004 13:43:43 -0400 Gene Heskett wrote:

| On Tuesday 27 July 2004 12:51, Randy.Dunlap wrote:
| >On Tue, 27 Jul 2004 13:02:41 -0400 Gene Heskett wrote:
| >| On Tuesday 27 July 2004 10:29,
| >| viro@parcelfarce.linux.theplanet.co.uk
| >|
| >| wrote:
| >| >On Tue, Jul 27, 2004 at 12:33:04PM -0400, Gene Heskett wrote:
| >| >> Greetings everybody;
| >| >>
| >| >> I have now had 4 crashes while running 2.6.8-rc2, the last one
| >| >> requiring a full powerdown before the intel-8x0 could
| >| >> re-establish control over the sound.
| >| >>
| >| >> All have had an initial Opps located in prune_dcache, and were
| >| >> logged as follows:
| >| >> Jul 27 07:58:58 coyote kernel: Unable to handle kernel NULL
| >| >> pointer dereference at virtual address 00000000
| >| >
| >| >... which means that dentry_unused list got corrupted, which
| >| > doesn't really help.  Could you try to narrow it down to
| >| > 2.6.8-rc1-bk<day>?
| >|
| >| I don't have bitkeeper installed.  I get my patches from
| >| kernel.org, either from the main Linus tree, or Andrews akpm tree.
| >| Is there someplace where I can dl a patchkit that leads up to rc1
| >| by the "daily" snapshot?  Or should I just get the 'broken out'
| >| patch after I verify that it also occurs with rc1 of course.  That
| >| I haven't done, mainly because rc2 has a lot of usb bugfixes and
| >| my mouse hasn't died all by itself on rc2 like it was for at least
| >| 2 dozen patches before rc2.  IIRC it did a time or 2 on rc1.
| >
| >In case you need daily bk snapshots, they are here:
| >  http://www.kernel.org/pub/linux/kernel/v2.6/snapshots/
| 
| Thanks Randy, got all 6 of them.
| 
| >| It takes a < 1 day for this to occur usually, but seems to occur
| >| after a long session of doing something else that fails. (or maybe
| >| causes the fail, of a make install in konstruct/meta/kde)  Thats
| >| running now, someplace in kdegraphics-3.2.92 from the looks of it.
| 
| I take it that I should apply these to a 2.6.7 tarballs tree in this 
| order:
| 1. 2.6.8-rc1
>>>> 2.6.8-rc2 <<<<<

| 2. each of these 'rc2-bk' patches by the day and then run each for a 
| couple days, or should I start in the middle, say the 3rd one and 
| work forward or backwards from there depending on the results?

I'd suggest beginning with -bk3 and doing a binary search.

| Your (and Viro's) call.  I'd imagine you would want to run this to 
| earth as quick as we can.
| 
| Are these patches cumulative?  I presume they are as they grow by the 
| day.

Sorry, I should have mentioned that.  Yes, they are cumulative.

--
~Randy
