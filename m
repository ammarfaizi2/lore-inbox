Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268132AbUIWBxd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268132AbUIWBxd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 21:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268137AbUIWBxd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 21:53:33 -0400
Received: from mproxy.gmail.com ([216.239.56.247]:31286 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268132AbUIWBxb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 21:53:31 -0400
Message-ID: <21d7e99704092218531ec19260@mail.gmail.com>
Date: Thu, 23 Sep 2004 11:53:23 +1000
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] mark inter_module_* deprecated
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20040919101337.GA5910@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20040919101337.GA5910@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Sep 2004 12:13:38 +0200, Christoph Hellwig <hch@lst.de> wrote:
> These had been officially deprecated since Rusty's module rewrite, but
> never got the __deprecated marker.  The only remaining users are drm and
> mtd, so we'll get some warnings for common builds.  But maybe that's the
> only way to get the drm people to fix the mess :)
> 

It'll piss a few people off but it won't create time, the only thing
stopping the drm from getting this stuff out of the way is time, there
are two uses in the DRM, one is the agp one, this is easy, Rusty
posted a patch for this and I'll probably merge it up after the next
kernel release.. the other use requries moving to some sort of DRM
in-kernel core, again I'd rather do this at the start of a kernel
release cycle as it'll require a bit of testing to make sure we don't
break anything....

Most of this stuff is easier if we weren't waiting on Alans vga class
support driver to turn up as without it the DRM CVS is blocked, and no
DRM developer really wants to start hacking on the vga class stuff as
we don't believe it is where our time is best spent until Alan gets
code merged into the kernel and gets the fb guys to convert all their
drivers... I've already got a patch for converting the DRM to a fixed
up version of his last patch...

Dave.
