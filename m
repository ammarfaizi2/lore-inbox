Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266917AbUHVNRH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266917AbUHVNRH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 09:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266894AbUHVNRG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 09:17:06 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:49819 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S266887AbUHVNPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 09:15:35 -0400
Subject: Re: [PATCH] ppc32 use simplified mmenonics
From: Albert Cahalan <albert@users.sf.net>
To: Vincent Hanquez <tab@snarc.org>
Cc: benh@kernel.crashing.org,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040822094317.GA2589@snarc.org>
References: <1093135526.5759.2513.camel@cube>
	 <20040822094317.GA2589@snarc.org>
Content-Type: text/plain
Organization: 
Message-Id: <1093171291.5759.2544.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 22 Aug 2004 06:41:32 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-08-22 at 05:43, Vincent Hanquez wrote:
> On Sat, Aug 21, 2004 at 08:45:26PM -0400, Albert Cahalan wrote:
> > I'd rather you went the other way, replacing these
> > barely-documented instructions with ones that are
> > easy to look up. Motorola has about a zillion of
> > these "simplified" instructions. I guess Motorola
> > and IBM were jealous of Intel's CISC instructions.
> > 
> > The big problem is this:
> >         THESE ARE NOT IN THE INDEX!!!!!!
> > 
> > So, if I forget what one of these many instructions
> > does, I'll have quite the time paging through the
> > manual trying to find it.
> > 
> > If it's not in the index, please avoid it.
> 
> Well,
> 
> let's analyse 'mr R1,R2'. Which is simplified instruction for moving register,
> which represent the following instruction 'or R2,0,R1'

The "or" is much easier, because it follows the
standard 3-register pattern. With "mr", which way
does it go? That's one more thing to remember.
In fact I don't know, but the "or" is obvious.

The 0 is your hint that the "or" isn't a plain "or".

> bne target = bc 4,2,target
> 
> When I see first form, I know exactly what the program do, whereas on
> the second form : What the hell is 4,2 ?

This is a slightly better example, but still, it's
lots easier to look up "bc" to see the selection of
options that are available.

Plus, yeah, "what the hell is 4,2", but those numbers
replace a _lot_ of other things you'd need to remember.
There are 456 of these "simplified" branch instructions.
If you use those, you'll tend to restrict your code to
those few common ones you remember. There's bdnzltrl,
bdnzfla, bunla...  That's madness.

That's 114 opcodes to 1.

> So I'ld rather go with simplified instruction, even if that index
> doesn't contain them (which I agree with you, is very bad).
> There are still in Appendix F of my pdf and you can search with the find
> utility include in your reader (xpdf does)

I have the physical book. Other than being unsearchable,
it's much nicer than the pdf. It's easy on the eyes,
doesn't occupy screen space, and I can read it on the can.


