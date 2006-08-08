Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030345AbWHHXyM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030345AbWHHXyM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 19:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030346AbWHHXyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 19:54:12 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:27345 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030345AbWHHXyK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 19:54:10 -0400
Date: Wed, 9 Aug 2006 01:53:52 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Suspend2-devel@lists.suspend2.net,
       linux-pm@osdl.org, ncunningham@linuxmail.org
Subject: Re: swsusp and suspend2 like to overheat my laptop
Message-ID: <20060808235352.GA4751@elf.ucw.cz>
References: <Pine.LNX.4.58.0608081612380.17442@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0608081612380.17442@gandalf.stny.rr.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> A few months ago, I installed suspend2 on my laptop.  It worked great for
> a few days, when suddenly my laptop started to get very hot and the fan
> costantly went off, and then I started getting these:

I take it as "if I keep it for a week powered off, it will not do
this".

> ---
> Message from syslogd@localhost at Tue Aug  8 16:08:53 2006 ...
> localhost kernel: CPU0: Temperature above threshold
> 
> Message from syslogd@localhost at Tue Aug  8 16:08:53 2006 ...
> localhost kernel: CPU1: Temperature above threshold
> 
> 
> Message from syslogd@localhost at Tue Aug  8 16:08:53 2006 ...
> localhost kernel: CPU0: Running in modulated clock mode
> 
> Message from syslogd@localhost at Tue Aug  8 16:08:53 2006 ...
> localhost kernel: CPU1: Running in modulated clock mode
> ---

P4 has thermal protection, so you are actually safe.

Nigel is right, this is acpi problem, but I guess we can help it.  Do
you have /proc/acpi/fan? Do you have /proc/acpi/ibm/fan? Can you try
playing with them?

And yes, this should go into bugzilla.kernel.org.

> Recently, I've decided to try out swsusp.  Well, it has been working fine
> for almost a week now.  But unfortunately, I just started to have my fan
> go off constantly, and I'm getting the above messages again (hence why
> the date on the messages is today). Checking out the temp, it's going into
> the high 70C. That's not too bad, but it only happens when suspending
> every night instead of shutting down.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
