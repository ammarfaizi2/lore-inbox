Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267994AbUJCQYf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267994AbUJCQYf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 12:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268000AbUJCQYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 12:24:35 -0400
Received: from rproxy.gmail.com ([64.233.170.203]:34103 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267994AbUJCQYd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 12:24:33 -0400
Message-ID: <9e4733910410030924214dd3e3@mail.gmail.com>
Date: Sun, 3 Oct 2004 12:24:32 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Vladimir Dergachev <volodya@mindspring.com>
Subject: Re: Merging DRM and fbdev
Cc: Dave Airlie <airlied@linux.ie>, dri-devel@lists.sourceforge.net,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0410031145560.17248@node2.an-vo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9e47339104100220553c57624a@mail.gmail.com>
	 <Pine.LNX.4.58.0410030824280.2325@skynet>
	 <9e4733910410030833e8a6683@mail.gmail.com>
	 <Pine.LNX.4.61.0410031145560.17248@node2.an-vo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Oct 2004 11:50:50 -0400 (EDT), Vladimir Dergachev
<volodya@mindspring.com> wrote:
> On Sun, 3 Oct 2004, Jon Smirl wrote:
> 
> > If we could all just concentrate on fixing the radeondrm driver we
> > could build a complete driver for the radeon cards instead of the ten
> > half finished ones we have today. Once we get a complete driver the
> > incentive for people to write new ones will be gone.
> 
> > My model....
> >
> > radeon - attached to hardware
> >   drm - library
> >   fb - library
> >      fbcon - library
> 
> Can we add to this "km" library ? (That's the GATOS v4l module)
> 
> In particular, I can contribute the code that does Framebuffer->System Ram
> transfers over PCI/AGP. It is currently GPL licensed, but there is no
> problem if BSD folks want it too.
> 
> This is also potentially useful for any Mesa functions that want to
> transfer data back from video RAM - using plain reads for this is really slow.

Drivers are free to call as many libraries as they want....

radeon - attached to hardware
   drm - library
   fb - library
      fbcon - library
   km - library

Libraries are kernel modules that don't attach to any specific
hardware, they just supply routines for other drivers to call. We
might want to change the name of these to libdrm, libfb, libkm.

I haven't looked into Gatos yet but I'd like to see the radeon
converted to follow the model of all of the other vl4 cards instead of
having it's own system. In the X on GL world the 2D XAA radeon driver
is gone. Gatos support will need to live somewhere else.

-- 
Jon Smirl
jonsmirl@gmail.com
