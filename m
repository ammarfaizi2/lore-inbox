Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271681AbRICPXv>; Mon, 3 Sep 2001 11:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271694AbRICPXl>; Mon, 3 Sep 2001 11:23:41 -0400
Received: from adsl-64-109-202-77.milwaukee.wi.ameritech.net ([64.109.202.77]:59891
	"HELO alphaflight.0xd6.org") by vger.kernel.org with SMTP
	id <S271681AbRICPXe>; Mon, 3 Sep 2001 11:23:34 -0400
Date: Mon, 3 Sep 2001 10:15:39 -0500
From: "M. R. Brown" <mrbrown@0xd6.org>
To: Ricky Beam <jfbeam@bluetopia.net>
Cc: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: pvr2fb.c
Message-ID: <20010903101539.B16796@0xd6.org>
In-Reply-To: <Pine.GSO.4.33.0109021930580.23852-100000@sweetums.bluetronic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.33.0109021930580.23852-100000@sweetums.bluetronic.net>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ricky Beam <jfbeam@bluetopia.net> on Sun, Sep 02, 2001:

> What the ^*!#^% is this:
> 
> driver/video/pvr2fb.c:
> int __init pvr2fb_init(void)
> {
>         struct fb_var_screeninfo var;
>         u_long modememused;
> 
>         if (!MACH_DREAMCAST)
>                 return -ENXIO;
> ...
> 
> That's the first time I've seen such, well, badness.
> 
> It looks like someone forgot what platform is *required* for the PowerVR 2...
> 

The pvr2fb driver is named as such because eventually we want to be able to
support all CLX boards, not just the chip found in the Dreamcast.  Right
now it only supports the Dreamcast and only builds under LinuxSH - vanilla
kernels can't be targetted to the DC.

The main problem with writing this driver is that not only are the specs
from VideoLogic impossible to obtain w/out signing an NDA, the only
commodity pvr2 board that you can find (others have looked) is the
Dreamcast.  I have Win32 pvr2 drivers to play with, but it's kinda useless
if I don't have a board to test.

M. R.
