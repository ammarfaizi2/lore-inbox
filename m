Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261610AbUKWXJu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbUKWXJu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 18:09:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261517AbUKWXHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 18:07:48 -0500
Received: from mail.dif.dk ([193.138.115.101]:30430 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261620AbUKWXGh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 18:06:37 -0500
Date: Wed, 24 Nov 2004 00:16:10 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Matthew Wilcox <matthew@wil.cx>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove pointless <0 comparison for unsigned variable in
 fs/fcntl.c
In-Reply-To: <Pine.LNX.4.58.0411231035500.20993@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.61.0411240011310.3389@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.61.0411212351210.3423@dragon.hygekrogen.localhost>
 <20041122010253.GE25636@parcelfarce.linux.theplanet.co.uk> <41A30612.2040700@dif.dk>
 <Pine.LNX.4.58.0411230958260.20993@ppc970.osdl.org>
 <Pine.LNX.4.61.0411231916410.3389@dragon.hygekrogen.localhost>
 <Pine.LNX.4.58.0411231035500.20993@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Nov 2004, Linus Torvalds wrote:
> 
> 
> On Tue, 23 Nov 2004, Jesper Juhl wrote:
> >
> > Shutting up gcc is not the primary goal here, the goal is/was to  
> > a) review the code and make sure that it is safe and correct, and fix it 
> > when it is not.
> > b) remove comparisons that are just a waste of CPU cycles when the result 
> > is always true or false (in *all* cases on *all* archs).
> 
> Well, I'm convinced that (b) is unnecessary, as any compiler that notices 
> the range thing enough to warn will also be smart enough to just remove 
> the test internally.
> 
That makes sense. I'll try and ignore (b).

> But yes, as long as the thing is a "review and fix bugs" and not a quest 
> to remove warnings which may well be compiler figments, that's obviously 
> ok.

That was the main thing, yes. Of course I may make mistakes and end up 
posting patches that are less than perfect, but review and fix bugs is 
my intent, building with -W is merely a way for me to find relevant bits 
to review.

But enough of this, I understand your views on the issue and thank you for 
your examples, now I'll focus on the code and see if it results in a few 
patches :)


--
Jesper Juhl



