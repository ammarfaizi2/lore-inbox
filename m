Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261722AbULUA6P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261722AbULUA6P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 19:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261504AbULUA5k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 19:57:40 -0500
Received: from fw.osdl.org ([65.172.181.6]:44937 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261498AbULUA4Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 19:56:16 -0500
Date: Mon, 20 Dec 2004 16:56:13 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jesper Juhl <juhl-lkml@dif.dk>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kill access_ok() call from copy_siginfo_to_user() that
 we might as well avoid.
In-Reply-To: <Pine.LNX.4.61.0412210145260.3581@dragon.hygekrogen.localhost>
Message-ID: <Pine.LNX.4.58.0412201646220.4112@ppc970.osdl.org>
References: <Pine.LNX.4.61.0412210025100.3581@dragon.hygekrogen.localhost>
 <Pine.LNX.4.58.0412201617050.4112@ppc970.osdl.org>
 <Pine.LNX.4.61.0412210139050.3581@dragon.hygekrogen.localhost>
 <Pine.LNX.4.61.0412210145260.3581@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ Linux-kernel added back into the cc, because I actually think this is 
  important. ]

On Tue, 21 Dec 2004, Jesper Juhl wrote:
> 
> Should I just stop attemting to make these trivial cleanups/fixes/whatever 
> patches? are they more noice than gain? am I being a pain to more skilled 
> people on lkml or can you all live with my, sometimes quite ignorant, 
> patches?
> I do try to learn from the feedback I get, and I like to think that my 
> patches are gradually getting a bit better, but if I'm more of a bother 
> than a help I might as well stop.

To me, the biggest thing with small patches is not necessarily the patch 
itself. I think that much more important than the patch is the fact that 
people get used to the notion that they can change the kernel - not just 
on an intellectual level ("I understand that the GPL means that I have the 
right to change my kernel"), but on a more practical level ("Hey, I did 
that small change").

And whether it ends up being the right thing or not, that's how everybody
starts out. It's simply not possible to "get into" the kernel without
starting out small, and making mistakes. So I very much encourage it, even
if I often don't have the time to actually worry about small patches, and 
I try to get suckers^H^H^H^H^H^H^Hother developers like Rusty to try to 
acts as quality control and a "gathering place".

Btw, this is why even "trivial patches" really do take time - they often 
have trivial mistakes in them, and it's not just because there are more 
inexperienced people doing them - most of _my_ mistakes tend to be at the 
truly idiotic level, just because it "looked obvious", and then there's 
something that I miss.

So at one level I absolutely _hate_ trivial patches: they take time and 
effort to merge, and individually the patch itself is often not really 
obviously "worth it". But at the same time, I think the trivial patches 
are among the most important ones - exactly because they are the "entry" 
patches for every new developer.

I just try really hard to find somebody else to worry about them ;)

(It's not a thankful job, btw, exactly because it _looks_ so trivial. It's
easy to point to 99 patches that are absolutely obvious, and complain
about the fact that they haven't been merged. But they take time to merge
exactly because of that one patch that _did_ look obvious, but wasn't.  
And actually, it's usually not 99:1, it's usually more like 10:1 or
something).

So please don't stop. Yes, those trivial patches _are_ a bother. Damn, 
they are _horrible_. But at the same time, the devil is in the detail, and 
they are needed in the long run. Both the patches themselves, and the 
people that grew up on them.

		Linus
