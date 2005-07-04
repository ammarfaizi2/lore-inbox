Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261515AbVGDIyg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261515AbVGDIyg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 04:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261536AbVGDIyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 04:54:36 -0400
Received: from unused.mind.net ([69.9.134.98]:27361 "EHLO echo.lysdexia.org")
	by vger.kernel.org with ESMTP id S261515AbVGDIy2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 04:54:28 -0400
Date: Mon, 4 Jul 2005 01:53:20 -0700 (PDT)
From: William Weston <weston@sysex.net>
X-X-Sender: weston@echo.lysdexia.org
To: Lee Revell <rlrevell@joe-job.com>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.50-24
In-Reply-To: <1120269723.12256.11.camel@mindpipe>
Message-ID: <Pine.LNX.4.58.0507040042220.31967@echo.lysdexia.org>
References: <200506281927.43959.annabellesgarden@yahoo.de> 
 <200506301952.22022.annabellesgarden@yahoo.de>  <20050630205029.GB1824@elte.hu>
  <200507010027.33079.annabellesgarden@yahoo.de>  <20050701071850.GA18926@elte.hu>
  <Pine.LNX.4.58.0507011739550.27619@echo.lysdexia.org> <1120269723.12256.11.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Jul 2005, Lee Revell wrote:

> On Fri, 2005-07-01 at 18:46 -0700, William Weston wrote:
> > FWIW, I'm still seeing the SMT scheduling? meltdown issues with
> > -50-42.  
> > Running two instances of 'dd if=/dev/zero of=/dev/null bs=65536'
> > instead 
> > of 'burnP6' results in the same behavior.  Here's a quick recap:
> > 
> > - Start (or login to ) X.
> > - Start an X app that constantly updates the screen, like wmcube, or
> > vlc. 
> 
> Which video driver is X using?  What nice value is the X server running
> at?

Hardware is Intel 82865G (integrated) with DRM i915 1.1.0 20040405 and 
xorg-3.8.2 i810 driver, running at nice 0, priority 15.  Should I bump the 
priority up?  To realtime?

> Does adding:
> 
> Option "NoAccel"
> 
> to the Device section of your X config file make any difference?

Disabling the dri and drm modules didn't help.  I'll turn on NoAccel when 
I'm back in the office on Tuesday.

> (on most systems X is the only thing besides the kernel that can access
> hardware directly, which can cause problems)

So would running X through the framebuffer device be the way to go for 
stability under realtime?  It's been a couple years since I've used fb.

--ww
