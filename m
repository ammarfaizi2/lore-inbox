Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751286AbWIUPye@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbWIUPye (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 11:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbWIUPye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 11:54:34 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:34755 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751286AbWIUPyd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 11:54:33 -0400
Date: Thu, 21 Sep 2006 17:50:40 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linus Torvalds <torvalds@osdl.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19 -mm merge plans
In-Reply-To: <Pine.LNX.4.64.0609210819170.4388@g5.osdl.org>
Message-ID: <Pine.LNX.4.61.0609211732250.32186@yvahk01.tjqt.qr>
References: <20060920135438.d7dd362b.akpm@osdl.org>  <45121382.1090403@garzik.org>
  <20060920220744.0427539d.akpm@osdl.org> <1158830206.11109.84.camel@localhost.localdomain>
 <Pine.LNX.4.64.0609210819170.4388@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sep 21 2006 08:25, Linus Torvalds wrote:
>
> - 2.6.<odd> is "the big initial merges with all the obvious fixes to make 
>   it all work" (ie roughly the current -rc2 or perhaps -rc3).
>
> - 2.6.<even> is "no big merges, just careful fixes" (ie the current "real 
>   release")

That sounds interesting. To me this looks like a careful approach at 
more or less marking a release "this contains new stuff" and "this does 
not", like 2.<odd>.x and 2.<even>.x, respectively, but of course without 
the code divergence that happened between 2.4 and 2.5.

Will there be a -stable branch for 2.6.<odd>s, or will they be limited 
to 2.6.<even>, just like there is no -stable for -rcs?

>Each would be ~3 weeks, leaving us with effectively the same real release 
>schedule, just a naming change.

More or less, yes. Let's assume a "good release" (one with a fair number 
of -rcs), and compare both approches (hope your MUA does tabs=8):

Week/Current	Current style	Week/Proposal	Your proposal
+0		2.6.18		+0		2.6.18
+2		2.6.19-rc1	-		none
+3		2.6.19-rc2	+3		2.6.19
+4		2.6.19-rc3	-		none
+5		2.6.19		+6		2.6.20
+7		2.6.20-rc1	-		none
+8		2.6.20-rc2	+9		2.6.21
+9		2.6.20-rc3	-		none
+10		2.6.21		+12		2.6.22
(+1 between each -rc is purely assumptional)

Though this is a purely dry mathematical table. We did not always stick 
to a "-rc3 at most" rule, but gone up to like -rc7 recently. With the 
new versioning scheme, no such thing seems likely to be happening 
(excluding of course external influences like people travelling).
IOW, the schedule gets more organized. I like that idea.

(Based upon the assumption that 1 week passes between each -rc 
release, there would, with the new proposal, 'only' be 243 weeks to hit 
2.6.99 instead of 405. That is, version numbers go up faster :)



Jan Engelhardt
-- 
