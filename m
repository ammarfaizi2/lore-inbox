Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263540AbUILWmx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263540AbUILWmx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 18:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263743AbUILWmw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 18:42:52 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:23985 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S263540AbUILWmu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 18:42:50 -0400
Date: Sun, 12 Sep 2004 23:42:45 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jon Smirl <jonsmirl@gmail.com>,
       Felix =?ISO-8859-1?Q?K=FChling?= <fxkuehl@gmx.de>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: radeon-pre-2
In-Reply-To: <1094912726.21157.52.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0409122319550.20080@skynet>
References: <E3389AF2-0272-11D9-A8D1-000A95F07A7A@fs.ei.tum.de> 
 <Pine.LNX.4.58.0409100209100.32064@skynet>  <9e47339104090919015b5b5a4d@mail.gmail.com>
  <20040910153135.4310c13a.felix@trabant>  <9e47339104091008115b821912@mail.gmail.com>
  <1094829278.17801.18.camel@localhost.localdomain>  <9e4733910409100937126dc0e7@mail.gmail.com>
  <1094832031.17883.1.camel@localhost.localdomain>  <9e47339104091010221f03ec06@mail.gmail.com>
  <1094835846.17932.11.camel@localhost.localdomain>  <9e47339104091011402e8341d0@mail.gmail.com>
  <Pine.LNX.4.58.0409102254250.13921@skynet>  <1094853588.18235.12.camel@localhost.localdomain>
  <Pine.LNX.4.58.0409110137590.26651@skynet> <1094912726.21157.52.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> > Alan, I agree with how you want to proceed with this, and keep things
> > stable, but anything short of a single card-specific driver looking after
> > the registers and DMA queueing and locking is going to have deficiencies
> > and the DRM has a better basis than the fb drivers,
>
> "I want to own it, mine mine". Pathetic really isn't it. The FB writers
> I've no doubt think they should own it and their code is better too.
> They also support a lot more hardware than you do of course, and on
> platforms that DRI doesn't support.

I actually don't give a rats arse who owns it, this isn't a them and us
despite these rather obvious attempts to make it so.. this is a who writes
the code and does the design and at the moment I'm seeing you and Jon with
differing view points, and I'm trying to get both sides to figure out what
needs to be done, I'll gladly review any changes for the drm but saying
it's a DRI vs kernel is a very small minded view that I don't really care
for..

The worst things that will happen for all concerened is this:
Jon does all this work on a merged solution outside the kernel, and it
works well, and the X team decide to do a decent X on mesa-solo on Jons
super-DRM, now the super-DRM gets pushed via the X tree and distributions
start relasing kernels with it merged into it and it never goes into the
main tree... it won't matter, RH/SuSE/whomever will want to pick up the
new features for the *enhanced user experience* and people will give out
about not being able to use Linus's kernels and it'll be a bit of a big
mess sort of like when the DRM came out first... now I think X is
probably the only project that can push this sort of change without
kernel developer consent, I personally would rather this didn't happen,

I think yourself and Linus's ideas for a locking scheme look good, I also
know they won't please Jon too much as he can see where the potential
ineffecienes with saving/restore card state on driver swap are, especailly
on running fbcon and X on a dual-head card with different users.

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person

