Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268008AbUJCRBw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268008AbUJCRBw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 13:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268019AbUJCRBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 13:01:52 -0400
Received: from pimout6-ext.prodigy.net ([207.115.63.78]:59388 "EHLO
	pimout6-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S268011AbUJCRBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 13:01:08 -0400
Date: Sun, 3 Oct 2004 12:59:38 -0400 (EDT)
From: Vladimir Dergachev <volodya@mindspring.com>
X-X-Sender: volodya@node2.an-vo.com
Reply-To: Vladimir Dergachev <volodya@mindspring.com>
To: Jon Smirl <jonsmirl@gmail.com>
cc: Dave Airlie <airlied@linux.ie>, dri-devel@lists.sourceforge.net,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Merging DRM and fbdev
In-Reply-To: <9e4733910410030924214dd3e3@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0410031254280.17448@node2.an-vo.com>
References: <9e47339104100220553c57624a@mail.gmail.com> 
 <Pine.LNX.4.58.0410030824280.2325@skynet>  <9e4733910410030833e8a6683@mail.gmail.com>
  <Pine.LNX.4.61.0410031145560.17248@node2.an-vo.com>
 <9e4733910410030924214dd3e3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   km - library
>
> Libraries are kernel modules that don't attach to any specific
> hardware, they just supply routines for other drivers to call. We
> might want to change the name of these to libdrm, libfb, libkm.
>
> I haven't looked into Gatos yet but I'd like to see the radeon
> converted to follow the model of all of the other vl4 cards instead of
> having it's own system. In the X on GL world the 2D XAA radeon driver
> is gone. Gatos support will need to live somewhere else.

Jon, this is a common misconception - GATOS km module *does* provide a v4l 
interface.

What is different is that the device configuration (like setting the tuner 
or encoding) is done by Xserver.

All km does is check whether the card can supply a v4l stream and, if so, 
it provides it. This is little different from a webcam driver, especially
if a webcam has its own on/off switch.

The misconception arises from the fact that many v4l programs were only 
made to work with bt848 cards - they would *not* work with webcams any
more than they would work with km.

                               best

                                 Vladimir Dergachev

>
> -- 
> Jon Smirl
> jonsmirl@gmail.com
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
> Use IT products in your business? Tell us what you think of them. Give us
> Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
> http://productguide.itmanagersjournal.com/guidepromo.tmpl
> --
> _______________________________________________
> Dri-devel mailing list
> Dri-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/dri-devel
>
