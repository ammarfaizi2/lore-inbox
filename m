Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262256AbVGWAi6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262256AbVGWAi6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 20:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262255AbVGWAgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 20:36:04 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:61143 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262256AbVGWAfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 20:35:48 -0400
Date: Sat, 23 Jul 2005 02:35:44 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3: swsusp works (TP 600X)
Message-ID: <20050723003544.GC1988@elf.ucw.cz>
References: <E1Dw7ja-0002Ge-EF@approximate.corpus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1Dw7ja-0002Ge-EF@approximate.corpus.cam.ac.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> swsusp now mostly works on my TP 600X.  If I don't eject the pcmcia card
> (usually a prism54 wireless card), swsusp begins the process of
> hibernation, but never gets to the writing pages part.  The eth0 somehow
> tries to reload the firmware (as if it's been woken up), and then
> everything hangs.  If I eject the card and (for safety) stop
> /etc/init.d/pcmcia, then swsusp writes out the memory to swap, and
> waking up works fine.  Thanks for all the improvements!
> 
> Is there debugging I can do in order to help get the pcmcia system
> hibernating automagically?

Well, it really may be the firmware loading. Add some printks to
confirm it, then fix it.

> One other glitch is that pdnsd (a nameserver caching daemon) has crashed
> when the system wakes up from swsusp.  It also happens when waking up
> from S3, which was working with 2.6.11.4 although not with 2.6.13-rc3.
> Many people have said mysql also does not suspend well.  Is their use of
> a named pipe or socket causing the problem?

No idea, strace?
									Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
