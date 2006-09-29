Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161366AbWI2SSc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161366AbWI2SSc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 14:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161369AbWI2SSc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 14:18:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29165 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161366AbWI2SSb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 14:18:31 -0400
Date: Fri, 29 Sep 2006 11:17:16 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Helge Hafting <helge.hafting@aitel.hist.no>, tglx@linutronix.de,
       Neil Brown <neilb@suse.de>, Michiel de Boer <x@rebelhomicide.demon.nl>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: GPLv3 Position Statement
In-Reply-To: <Pine.LNX.4.64.0609291030050.3952@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0609291054120.3952@g5.osdl.org>
References: <1158941750.3445.31.camel@mulgrave.il.steeleye.com> 
 <451798FA.8000004@rebelhomicide.demon.nl>  <17687.46268.156413.352299@cse.unsw.edu.au>
  <1159183895.11049.56.camel@localhost.localdomain> 
 <1159200620.9326.447.camel@localhost.localdomain>  <451CF22D.4030405@aitel.hist.no>
  <Pine.LNX.4.64.0609290940480.3952@g5.osdl.org> <1159552021.13029.58.camel@localhost.localdomain>
 <Pine.LNX.4.64.0609291030050.3952@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 29 Sep 2006, Linus Torvalds wrote:
>
>  - the GPLv2 allows usage in any circumstances except the geographical 
>    limitation that can be forced on it by other laws. No serious lawyer I 
>    have ever met is even ambiguous about this. There's just no question - 
>    people may not be happy about it, and iirc the FSF at some point tried 
>    to claim somethign else, but this really isn't all that controversial.

Btw, clearly the GPLv2 requirements do say that the use may have to be 
done certain ways. For example, if you actually embed keys in the binary 
itself, that almost certainly means that they keys are part of the source, 
and as such you need to make the keys available through other means and 
rely on the "mere aggregation" clause.

The same thing goes for things like signed images. It you sign an 
individual binary, it can be argued that the private key was part of the 
build process. It's really a pretty weak argument, but the whole point is 
made moot by the fact that you don't actually _need_ any keys: you can 
just control the bootloader instead.

That one not a derived work, and is quite often even on a totally 
different media: flash vs disk or similar. And once you have it do a 
consistency check by just verifying the SHA1 of the aggregate media 
separately, you don't actually have any keys to release, because there 
simply _is_ no key that actually covers any GPLv2'd code.

You can try to take it to some (il)logical extreme, and ask yourself 
whether just even holding a 128-bit hash is a "derived work"?

But I not only think you'd be laughed out of court on that one if you 
claimed it was, I _really_ don't think you want to go there anyway. 
Because if you think it is, then you're violating copyright law every time 
you look up a CD in CDDB/fredb/whatever-it's-called-now, or any number of 
other things. You don't want to try to strengthen copyrights to insane 
levels (you'd also be getting rid of "fair use" if you do).

In other words, if you _really_ care about "freedom" (just about any kind) 
you should be _damn_ careful not to try to extend those copyright claims 
of "derived work" too far. Because quite frankly, YOU are going to lose on 
that one, and the RIAA is going to laugh at your sorry ass for helping 
them prove their nonexistent point, and you would end up losing a lot 
more "freedoms" than the ones you thought you were fighting for.

So the point is, there's no reasonable disagreement what-so-ever that you 
can use GPLv2 code for anything you damn well want, including secure 
lock-down. I think the FSF has even said so in public. You have to release 
_source_code_, but the GPLv2 never controlled the environment it was used 
in.

Of course, a lot of people who have played games with these kinds of 
issues also did other things very wrong. So a number of vendors that did 
something fishy have gotten nailed for real copyright infringement due to 
the _other_ things they did.

[ I'd also not be surprised if companies would decide to settle just to 
  avoid a lawsuit - especially one that made it clear that they were 
  sleazy even if they weren't perhaps actually doing anything actively 
  illegal. So there's a damn good reason why companies often don't want to 
  even toe _close_ to the line, and we should be happy about that. But we 
  shouldn't try to claim rules that simply never existed. ]

			Linus
