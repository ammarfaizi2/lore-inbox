Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267409AbUHVPOq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267409AbUHVPOq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 11:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267413AbUHVPOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 11:14:46 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:18428 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S267409AbUHVPO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 11:14:27 -0400
Subject: Re: [PATCH] ppc32 use simplified mmenonics
From: Albert Cahalan <albert@users.sf.net>
To: Vincent Hanquez <tab@snarc.org>
Cc: benh@kernel.crashing.org,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040822144501.GA10017@snarc.org>
References: <1093135526.5759.2513.camel@cube>
	 <20040822094317.GA2589@snarc.org> <1093171291.5759.2544.camel@cube>
	 <20040822144501.GA10017@snarc.org>
Content-Type: text/plain
Organization: 
Message-Id: <1093178422.2301.2674.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 22 Aug 2004 08:40:22 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-08-22 at 10:45, Vincent Hanquez wrote:
> On Sun, Aug 22, 2004 at 06:41:32AM -0400, Albert Cahalan wrote:

> > This is a slightly better example, but still, it's
> > lots easier to look up "bc" to see the selection of
> > options that are available.
> > 
> > Plus, yeah, "what the hell is 4,2", but those numbers
> > replace a _lot_ of other things you'd need to remember.
> > There are 456 of these "simplified" branch instructions.
> > If you use those, you'll tend to restrict your code to
> > those few common ones you remember. There's bdnzltrl,
> > bdnzfla, bunla...  That's madness.
> 
> So you writing assembly ppc code with your book on your side ?
> because I don't see any reason to associate easily '4,2' with 'not equal'

As I said, it's a slightly better example.
(it's also NOT what the patch was changing)

> bdnzltrl kinds of mmenonics are actually not fair, they are not really used :).
> But even that I would prefer bdnztlrl which I would have to lookup,
> than bclr with cryptics numbers which I would had to lookup too.

See, that's a problem. You're limiting yourself to
just 96 of the 456 listed operations, which are only
1/5 of the 2304 available operations.

I do admit to using bne at times. The bit manipulation
stuff is different though. It's not so cryptic in the
raw form. The same goes for using "or" to copy a register.

If you don't use the full bit manipulation notation
all the time, you might forget what it can do. Then
you'll end up using 2 instructions where one would do.

> > That's 114 opcodes to 1.
> 
> There's not 1 opcode for conditional branching. There are more on ppc basis:
> 	
> 	bc, bca, bclr, bcctr, bcl, bcla, bclrl, bcctrl

OK, that's 8. Dividing 456 by that, I still see a 57:1 ratio.

There's also that matter of the 1848 operations you can't
access via the "simplified" instruction names.


