Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266460AbUHPXdj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266460AbUHPXdj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 19:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266461AbUHPXdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 19:33:39 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:40853 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S266460AbUHPXdg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 19:33:36 -0400
Date: Tue, 17 Aug 2004 00:33:35 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Christoph Hellwig <hch@infradead.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: your mail
In-Reply-To: <20040816133728.A10686@infradead.org>
Message-ID: <Pine.LNX.4.58.0408170024570.26072@skynet>
References: <Pine.LNX.4.58.0408151311340.27003@skynet> <20040815133432.A1750@infradead.org>
 <Pine.LNX.4.58.0408160038320.9944@skynet> <20040816101732.A9150@infradead.org>
 <Pine.LNX.4.58.0408161019040.21177@skynet> <20040816105014.A9367@infradead.org>
 <1092654719.20523.18.camel@localhost.localdomain> <20040816132022.A10567@infradead.org>
 <Pine.LNX.4.58.0408161323300.32584@skynet> <20040816133728.A10686@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> All the fbdev handling code in X is also an accident?

I've no idea I've nothing to do with X... but the fact that graphics work
at all with fb/drm/X is by no fault of any design it is pure hack ...

> Really, why do you even push for this change if the better fix isn't that
> far away.  Send the i915 driver and the other misc cleanups to Linus now
> and get a proper graphics stub driver done, it's not that much work.  I'll
> hack up the fbdev side once I'll get a little time, but the drm code is
> far to disgusting to touch, sorry.

It means writing 6 or 7 stub drivers, for cards we don't have, it means
making PCI probing different for some fbdev drivers and some DRM drivers
(e.g. the i915 doesn't have a framebuffer driver in 2.6 so do I write a
stub on the chance that someone writes an fb driver for it? -  why do this
when the DRM will start encompassing the fb soon..) it is a lot of work
that we intend throwing away, the final solution is not to merge DRM/fb
via a stub, it is to create a single driver for each card, what happens
when the DRM starts doing memory management and 2d stuff.. we won't want
fb to be able to load anymore as it will break the DRM...I see Jon Smirl
has found the thread, please discuss with him as he was the one doing all
the legwork at the kernel summit...

again this doesn't break any real setups, it is the path of least
resistance as it doesn't affect fb drivers, why should DRM be a second
class citizen, when it is clearly going to have to be a first class 2.6
driver to do its job... if you can find someone with a real world setup
that this breaks I'll consider it a really bad idea... but I think Jon has
made his point far better than I...

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person

