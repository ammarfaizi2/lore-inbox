Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262165AbUBXBWn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 20:22:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262170AbUBXBWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 20:22:42 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:29203 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262169AbUBXBTu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 20:19:50 -0500
Date: Tue, 24 Feb 2004 01:19:46 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: fbdv/fbcon pending problems
In-Reply-To: <1077576644.5960.77.camel@gaston>
Message-ID: <Pine.LNX.4.44.0402240116090.17027-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I would appreciate if you did so ;) Please let me know what you find.

Okay. 

> I have this problem since the very beginning. The very first
> shift-pageup to display things properly from the back buffer, but to not
> _erase_ properly, until you do a bit of ping pong (down up down up) so
> that your screen end up properly refreshed.

:-( 
 
> I never use modules for fbdevs

Its a handy way to track down bugs :-)

> It does. Radeonfb did one step in this direction, but that's not
> enough. _BUT_ we still need to differenciate between a full mode 
> passed from userland from a mode where we _KNOW_ everything is
> bogus but width/height... In the later case, we really want to
> find a mode that is just large enough for the passed in width/height
> (but not smaller, or just fail if not found) and with the same
> hfreq if possible as the current mode. That's really a different
> request than a full blown mode coming from userland (like a 'tuning'
> tool or whatever...)
> 
> The FB_ACTIVATE_FIND is just that. It justs tells the driver to
> pick up a mode based on width/height only. We know the rest of
> the var is bogus.

Its still possible that the user sends in bogus data using 
FB_ACTIVATE_FIND. 
 
> Yes, but that's less urgent than the other ones. 

I agree.


> We really need to fix
> those basic behaviour problems before multihead. Multihead will come
> later as I will implement dual head support in radeonfb. That leads to
> a while bunch of problems with the userland API that need to be improed
> too, 

That is what sysfs is for :-) 

> and that leads to the problem of properly soft booting additional
> cards. I have various ideas to address those problems, but that's
> definitely less urgent than the list I wrote down.

We will talk about this later.


