Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262294AbVBTAOx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262294AbVBTAOx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 19:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262299AbVBTAOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 19:14:53 -0500
Received: from gprs214-185.eurotel.cz ([160.218.214.185]:32964 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262294AbVBTAOr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 19:14:47 -0500
Date: Sun, 20 Feb 2005 00:25:19 +0100
From: Pavel Machek <pavel@suse.cz>
To: Greg KH <greg@kroah.com>
Cc: Michal Januszewski <spock@gentoo.org>, linux-kernel@vger.kernel.org
Subject: Re: Bootsplash for 2.6.11-rc4
Message-ID: <20050219232519.GC1372@elf.ucw.cz>
References: <20050218165254.GA1359@elf.ucw.cz> <20050219011433.GA5954@spock.one.pl> <20050219230326.GB13135@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050219230326.GB13135@kroah.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Just in case someone is interested, this is bootsplash for 2.6.11-rc4,
> > > taken from suse kernel. I'll probably try to modify it to work with
> > > radeonfb.
> > > 
> > > Any ideas why bootsplash needs to hack into vesafb? It only uses
> > > vesafb_ops to test against them before some kind of free...
> > 
> > It doesn't really need vesafb for anything. Back in the days of 2.6.7 
> > I used to release a version of bootsplash that had the dep. on vesafb 
> > removed. It worked fine with at least some other fb drivers.
> > 
> > You might also want to save yourself some work and try out an
> > alternative solution called fbsplash [1], which I designed after I got 
> > tired of fixing bootsplash and which I actively maintain. Fbsplash 
> > provides virtually the same functionality, and it has as much code as 
> > possible moved into userspace (no more JPEG decoders in the kernel).
> > 
> > [1] http://dev.gentoo.org/~spock/projects/gensplash/current/
> 
> Pavel, I agree with Michal, take a look at this version of the code
> instead of the version that you posted.  It's a _whole_ lot more sane,
> and possibly even mergable.

Yes, I agree, almost anything is more sane than code I posted :-(. My
only requirement is that it works with radeonfb and similar low-level
drivers (so that I can get suspend-to-ram to work) and that it gets
past our branding people...   

> Michal, any thoughts on submitting it for inclusion?  It seems pretty
> stable now.

How many distros do use some variant of bootsplash? SuSE does, from
above url I guess gentoo does, too... Does RedHat do something
similar? [Or do they just set log-level to very high giving them clean
look?] What about Debian?

If most distros do some kind of splash screen, anyway, it would make
sense to merge one "good" version...
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
