Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932189AbWGaMnE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbWGaMnE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 08:43:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964776AbWGaMnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 08:43:04 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:54480 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932189AbWGaMnC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 08:43:02 -0400
Date: Mon, 31 Jul 2006 14:42:48 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Dave Airlie <airlied@linux.ie>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org,
       vojtech@suse.cz
Subject: Re: [RFC] GPU device layer patchset (00/07)
Message-ID: <20060731124248.GA3257@elf.ucw.cz>
References: <11535827134076-git-send-email-airlied@linux.ie> <44C253BB.10704@garzik.org> <Pine.LNX.4.64.0607221753390.5320@skynet.skynet.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607221753390.5320@skynet.skynet.ie>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >Where can I find more info on why this might be nice?
> >Or simply more info on what this actually does for me?
> 
> It does nothing for you yet, it is just step one for getting the DRM and 
> framebuffer drivers to co-exist in the driver model world, with the next 
> step being allowing a channel of communication between the two layers with 
> a view that later I can ask the DRM to disable fbdev or pass info to it..
> 
> Why do we not want fbdev and DRM in one driver? as it would break way too 
> many existing systems..
> 
> It also allows DRM to get called at suspend/resume time.

Looks good to me. I guess I should get DRM working...

I actually tried a bit, and got some reasonably-recent Xserver here,
but now I get

root@amd:/home/pavel# glxinfo
name of display: :0.0

ERROR!  sizeof(I830DRIRec) does not match passed size from device
driver
libGL warning: 3D driver returned no fbconfigs.
libGL error: InitDriver failed
libGL error: reverting to (slow) indirect rendering
display: :0  screen: 0
direct rendering: No
server glx vendor string: SGI
server glx version string: 1.2
server glx extensions:

:-(
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
