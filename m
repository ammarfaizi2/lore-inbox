Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267291AbUHVOpb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267291AbUHVOpb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 10:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267294AbUHVOpb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 10:45:31 -0400
Received: from darwin.snarc.org ([81.56.210.228]:48319 "EHLO darwin.snarc.org")
	by vger.kernel.org with ESMTP id S267291AbUHVOpK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 10:45:10 -0400
Date: Sun, 22 Aug 2004 16:45:01 +0200
To: Albert Cahalan <albert@users.sf.net>
Cc: benh@kernel.crashing.org,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ppc32 use simplified mmenonics
Message-ID: <20040822144501.GA10017@snarc.org>
References: <1093135526.5759.2513.camel@cube> <20040822094317.GA2589@snarc.org> <1093171291.5759.2544.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093171291.5759.2544.camel@cube>
X-Warning: Email may contain unsmilyfied humor and/or satire.
User-Agent: Mutt/1.5.6+20040803i
From: Vincent Hanquez <tab@snarc.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 22, 2004 at 06:41:32AM -0400, Albert Cahalan wrote:
> The "or" is much easier, because it follows the
> standard 3-register pattern. With "mr", which way
> does it go? That's one more thing to remember.
> In fact I don't know, but the "or" is obvious.
> 
> The 0 is your hint that the "or" isn't a plain "or".

Sure, but this is about mmenonic. When I see 'or', my mind doesn't make
any link with 'move register' but only with 'or'. I have to process
another term of the line (the 0) to see that the program want to move a
register.

> > bne target = bc 4,2,target
> > 
> > When I see first form, I know exactly what the program do, whereas on
> > the second form : What the hell is 4,2 ?
> 
> This is a slightly better example, but still, it's
> lots easier to look up "bc" to see the selection of
> options that are available.
> 
> Plus, yeah, "what the hell is 4,2", but those numbers
> replace a _lot_ of other things you'd need to remember.
> There are 456 of these "simplified" branch instructions.
> If you use those, you'll tend to restrict your code to
> those few common ones you remember. There's bdnzltrl,
> bdnzfla, bunla...  That's madness.

So you writing assembly ppc code with your book on your side ?
because I don't see any reason to associate easily '4,2' with 'not equal'

mmenonics is about associating instruction with what they do.
'bc 4,2' doesn't make me associate that with 'branch not equal' but with
'branch conditional something'. Without knowing the something, that won't
help me figure what the program want to do.

if you're able to decode '4,2' in real time you're very strong, but
you're probably a computer ;)

bdnzltrl kinds of mmenonics are actually not fair, they are not really used :).
But even that I would prefer bdnztlrl which I would have to lookup,
than bclr with cryptics numbers which I would had to lookup too.

> That's 114 opcodes to 1.

There's not 1 opcode for conditional branching. There are more on ppc basis:
	
	bc, bca, bclr, bcctr, bcl, bcla, bclrl, bcctrl

Thus if you count bnea, bnelr, bnectl, bnel, as new different instructions
compared to bne, then maybe you need to understand why thoses are called
mmenomics.

So as soon as you know those 8 basis opcodes, thoses are actually very easy to
understand. You just need to append the following (which all bourne
script peoples use)

	ne = not equal
	eq = equal
	lt = less than
	le = less equal
	ge = greater equal
	gt = greater than
	....

ex :
bc = Branch Conditional
bca = Branch Conditional Absolute
bne = Branch Not Equal
bnea = Branch Not Equal Absolute

thus from (8 basis mmenonics) + (12 kind of modifiers) I'm able to decode
in real time those 8 * 12 = 96 simplified instructions.

> > So I'ld rather go with simplified instruction, even if that index
> > doesn't contain them (which I agree with you, is very bad).
> > There are still in Appendix F of my pdf and you can search with the find
> > utility include in your reader (xpdf does)
> 
> I have the physical book. Other than being unsearchable,
> it's much nicer than the pdf. It's easy on the eyes,
> doesn't occupy screen space, and I can read it on the can.

You would better learn few of them and decode them the way it meant to
be, than lookup them all in your book.

That would save your time, your eyes and your desk space ;)

-- 
Tab
