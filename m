Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264256AbUILXxq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264256AbUILXxq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 19:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264299AbUILXxq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 19:53:46 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:59831 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S264256AbUILXxn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 19:53:43 -0400
Date: Mon, 13 Sep 2004 00:53:41 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jon Smirl <jonsmirl@gmail.com>, Christoph Hellwig <hch@infradead.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       =?ISO-8859-1?Q?Felix_K=FChling?= <fxkuehl@gmx.de>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: radeon-pre-2
In-Reply-To: <Pine.LNX.4.58.0409111723470.2341@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0409130046150.5648@skynet>
References: <9e47339104090919015b5b5a4d@mail.gmail.com> 
 <9e47339104091010221f03ec06@mail.gmail.com>  <1094835846.17932.11.camel@localhost.localdomain>
  <9e47339104091011402e8341d0@mail.gmail.com>  <Pine.LNX.4.58.0409102254250.13921@skynet>
  <20040911132727.A1783@infradead.org>  <9e47339104091109111c46db54@mail.gmail.com>
  <Pine.LNX.4.58.0409110939200.2341@ppc970.osdl.org> 
 <9e473391040911105448c3f089@mail.gmail.com>  <Pine.LNX.4.58.0409111058320.2341@ppc970.osdl.org>
 <9e4733910409111721534b2e6d@mail.gmail.com> <Pine.LNX.4.58.0409111723470.2341@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > We already have a mechanism for this: suspend/resume.
>
> Jon, you're not making sense any more.

> This discussion is just ridiculous, and I don't think it's worth cc'ing me
> if people can't try to work together, since I'm sadly not going to have
> time to actually implement any of this myself.
>
> If you are claiming that we should suspend/resume the whole chip just
> because two different programs want to access it, you're just crazy.
>
> We clearly _do_ have different subsystems already working together
> accessign the same chip, and they are _not_ doing stupid things like you
> are suggesting. They _work_. Today. No suspend/resume involved.

I think you are missing Jon's point here, we do complete suspend/resume
nowdays, just look at the radeon DDX Enter/Leave VT code, now I don't
particularly want that code in the kernel, it assumes nothing about the
chip after you switch back to X and restores the whole lot.. so we are
doing this today, they work because of that code, the DRM doesn't do
anything unless X is running in most scenarios today, so the DRM and fb
never do anything that simulatenous that you might notice as when you
switch away from X the drm is locked against working, and the fb can take
over, in the future this isn't going to be true, the mesa-solo work being
one case where fb and drm are going to be accessed from the one
process....

So his statement didn't seem that idiotic to me... he might have explained
himself better, and may have assumed everyone understands the internals of
the X DDXes,

Dave.


-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person

