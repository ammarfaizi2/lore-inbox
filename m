Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261507AbVG1Vhx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261507AbVG1Vhx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 17:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261497AbVG1Vhu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 17:37:50 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:4788 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261507AbVG1Vgx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 17:36:53 -0400
Date: Thu, 28 Jul 2005 23:36:50 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3: swsusp works (TP 600X)
Message-ID: <20050728213650.GA1872@elf.ucw.cz>
References: <20050723003544.GC1988@elf.ucw.cz> <E1DyEok-0000pa-SX@approximate.corpus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DyEok-0000pa-SX@approximate.corpus.cam.ac.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>If I don't eject the pcmcia card (usually a prism54 wireless card),
> >>swsusp begins the process of hibernation, but never gets to the
> >>writing pages part.
> 
> > Well, it really may be the firmware loading. Add some printks to
> > confirm it, then fix it.
> 
> I did more tests, this time with 2.6.13-rc3-mm2 (machine is a TP 600X),
> and I don't think the problem is related to firmware loading.  If I
> first physically eject the card (an Intersil wireless card), swsusp
> prints
> 
...
> 
> then it writes pages to swap and all is well.  Well, almost 100%; the
> one glitch is that sometimes X comes back blank and I have to
> ctrl-alt-F7 to bring back the display; or X comes back with the keyboard
> acting strange (<ENTER> shifts the display left by a few hundred
> pixels), and again ctrl-alt-F7 fixes it.  This is with XFree86
> 4.3.0.dfsg.1-14, and maybe after I upgrade (?) to the xorg server, that
> glitch will go away.  Anyway, it's easy to work around.

So, in short, problem is that if you leave prism54 card in, even with
module removed, swsusp hangs, right?

Okay then, start looking into pcmcia layer ;-).
								Pavel

-- 
teflon -- maybe it is a trademark, but it should not be.
