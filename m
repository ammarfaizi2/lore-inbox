Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261504AbULUBPc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261504AbULUBPc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 20:15:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261610AbULUBPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 20:15:32 -0500
Received: from mail.dif.dk ([193.138.115.101]:58765 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261504AbULUBPP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 20:15:15 -0500
Date: Tue, 21 Dec 2004 02:25:54 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kill access_ok() call from copy_siginfo_to_user() that
 we might as well avoid.
In-Reply-To: <Pine.LNX.4.58.0412201646220.4112@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.61.0412210216490.3581@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.61.0412210025100.3581@dragon.hygekrogen.localhost>
 <Pine.LNX.4.58.0412201617050.4112@ppc970.osdl.org>
 <Pine.LNX.4.61.0412210139050.3581@dragon.hygekrogen.localhost>
 <Pine.LNX.4.61.0412210145260.3581@dragon.hygekrogen.localhost>
 <Pine.LNX.4.58.0412201646220.4112@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Dec 2004, Linus Torvalds wrote:

> 
> [ Linux-kernel added back into the cc, because I actually think this is 
>   important. ]
> 
> On Tue, 21 Dec 2004, Jesper Juhl wrote:
> > 
> > Should I just stop attemting to make these trivial cleanups/fixes/whatever 
> > patches? are they more noice than gain? am I being a pain to more skilled 
> > people on lkml or can you all live with my, sometimes quite ignorant, 
> > patches?
> > I do try to learn from the feedback I get, and I like to think that my 
> > patches are gradually getting a bit better, but if I'm more of a bother 
> > than a help I might as well stop.
> 
> To me, the biggest thing with small patches is not necessarily the patch 
> itself. I think that much more important than the patch is the fact that 
> people get used to the notion that they can change the kernel - not just 
> on an intellectual level ("I understand that the GPL means that I have the 
> right to change my kernel"), but on a more practical level ("Hey, I did 
> that small change").
>
Right, that actually does give one a warm fuzzy feeling inside once in a 
while and encourages you to carry on.
 

> And whether it ends up being the right thing or not, that's how everybody
> starts out. It's simply not possible to "get into" the kernel without
> starting out small, and making mistakes. So I very much encourage it, even
> if I often don't have the time to actually worry about small patches, and 
> I try to get suckers^H^H^H^H^H^H^Hother developers like Rusty to try to 
> acts as quality control and a "gathering place".
> 
> Btw, this is why even "trivial patches" really do take time - they often 
> have trivial mistakes in them, and it's not just because there are more 
> inexperienced people doing them - most of _my_ mistakes tend to be at the 
> truly idiotic level, just because it "looked obvious", and then there's 
> something that I miss.
> 
> So at one level I absolutely _hate_ trivial patches: they take time and 
> effort to merge, and individually the patch itself is often not really 
> obviously "worth it". But at the same time, I think the trivial patches 
> are among the most important ones - exactly because they are the "entry" 
> patches for every new developer.
> 
> I just try really hard to find somebody else to worry about them ;)
> 
Heh, quite understandable - I wouldn't want to be at the other end of your 
mailbox.

> (It's not a thankful job, btw, exactly because it _looks_ so trivial. It's
> easy to point to 99 patches that are absolutely obvious, and complain
> about the fact that they haven't been merged. But they take time to merge
> exactly because of that one patch that _did_ look obvious, but wasn't.  
> And actually, it's usually not 99:1, it's usually more like 10:1 or
> something).
> 
> So please don't stop. Yes, those trivial patches _are_ a bother. Damn, 
> they are _horrible_. But at the same time, the devil is in the detail, and 
> they are needed in the long run. Both the patches themselves, and the 
> people that grew up on them.
> 
Ok, thank you so much for that reply. I'll try to keep the pain to a 
minimum, but I'll keep on doing the trivial (and hopefully in the 
long run the not-so trivial) patches :)
You just brought some courage/spirit/enthusiasm back to a disheartened 
kernel-hacker-wannabe ;-)  Thank you!


-- 
Jesper


