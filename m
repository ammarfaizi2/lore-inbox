Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161140AbWI2HIT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161140AbWI2HIT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 03:08:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161460AbWI2HIT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 03:08:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:65411 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161140AbWI2HIS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 03:08:18 -0400
Date: Fri, 29 Sep 2006 00:07:56 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       Chase Venters <chase.venters@clientec.com>,
       Sergey Panov <sipan@sipan.org>, Patrick McFarland <diablod3@gmail.com>,
       Theodore Tso <tytso@mit.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       James Bottomley <James.Bottomley@steeleye.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: GPLv3 Position Statement
In-Reply-To: <Pine.LNX.4.61.0609290757400.30682@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.64.0609282342380.3952@g5.osdl.org>
References: <1158941750.3445.31.camel@mulgrave.il.steeleye.com>
 <Pine.LNX.4.64.0609271945450.3952@g5.osdl.org> <1159415242.13562.12.camel@sipan.sipan.org>
 <200609272339.28337.chase.venters@clientec.com> <20060928135510.GR13641@csclub.uwaterloo.ca>
 <20060928141932.GA707@DervishD> <20060928144028.GA21814@wohnheim.fh-wedel.de>
 <Pine.LNX.4.64.0609280748500.3952@g5.osdl.org> <Pine.LNX.4.61.0609290757400.30682@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 29 Sep 2006, Jan Engelhardt wrote:
> 
> So what would happen if I add an essential GPL2-only file to a "GPL2
> or later" project? Let's recall, a proprietary program that
> combines/derives with GPL code makes the final binary GPL (and hence
> the source, etc. and whatnot, don't stretch it). Question: The Linux
> kernel does have GPL2 and GPL2+later combined, what does this make
> the final binary?

The final is always the most restricted license (or put another way: it's 
the "biggest possible license that can be used for everything", but in 
practice it means that non-restrictive licenses always lose out to their 
more restrictive brethren).

This is, btw, why BSD code combined with GPL code is always GPL, and never 
the other way. It's not a "vote" depending on which one has more code. And 
it's not a mixture.

The GPLv2 is very much designed to always be the most restricted license 
in any combination - because the license says that you cannot add any 
restrictions (so if there _was_ a more restricted license, it would no 
longer be compatible with the GPLv2, and you couldn't mix them at all in 
the first place).

So any time you have a valid combination of licenses, if anything is 
"GPLv2 only", the final end result is inevitably "GPLv2 only".

[ Btw, the same is true of the GPLv3 - very much by design in both cases. 
  This is why you can _never_ combine a "GPLv2" work with a "GPLv3" work. 

  They simply aren't compatible. One or both must accept the others 
  license restrictions, and since neither does, and the restrictions 
  aren't identical, there is no way to turn one into the other, or turn 
  them both into a wholly new "mixed" license. 

  So this is why the _only_ way you can mix GPLv2 and GPLv3 code is if the 
  code was dual-licensed, ie we have the "v2 or later" kind of situation. ]

Basic rule: licenses are compatible only if they are strict subsets of 
each other, and you can only ever take rights _away_ when you relicense 
something. You can never add rights - if you didn't get those rights in 
the first place with the original license, they're simply not yours to 
add.

Otherwise, we could all buy the latest CD albums, and then relicense them 
with more rights than you got (or we could take GPLv3 code and remove the 
restrictions, and relicense it as BSD).

So the reason you can't re-license the CD albums is that you don't even 
have any license to re-distribute them at all, and as such there is 
nothing for you to sublicense further. And the reason you cannot relicense 
the GPLv2 is that it tells you that you can't add any new restrictions 
when you re-distribute anything, and you obviously can't add any rights 
that you didn't have.

And, as usual: IANAL. But none of this is really even remotely 
controversial.

			Linus
