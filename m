Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264443AbUJEUnD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264443AbUJEUnD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 16:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266009AbUJEUnC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 16:43:02 -0400
Received: from gprs214-120.eurotel.cz ([160.218.214.120]:34438 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S264443AbUJEUmB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 16:42:01 -0400
Date: Tue, 5 Oct 2004 22:15:31 +0200
From: Pavel Machek <pavel@ucw.cz>
To: David Brownell <david-b@pacbell.net>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: PATCH/RFC: driver model/pmcore wakeup hooks (1/4)
Message-ID: <20041005201531.GA5763@elf.ucw.cz>
References: <200410041400.04385.david-b@pacbell.net> <20041005193737.GD4723@openzaurus.ucw.cz> <200410051309.02105.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410051309.02105.david-b@pacbell.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > This lets drivers standardize how they present their ability to issue
> > > wakeups, and how they manage whether that ability should be used.
> > 
> > Why do you assign "enabled" to variable instead of using it directly?
> 
> So there's exactly one copy of that string in use, agreeing with itself.
> Also, so strncmp() can be used.  It won't matter if the sysadmin goes
> 
>    echo -n enabled > wakeup
>    echo enabled > wakeup

Well, you could make that 0,1. That would be more sysfs-style...

> I'd personally rather use "on" and "off", but there seems to be
> a convention in /proc/acpi/wakeup in favor of polysyllabicism.
> 
> 
> > And perhaps you should print "not supported" instead of empty string...
> 
> Except that's two words, not one, which will make shell script
> bugs happen more readily.  I thought about "(none)" which
> has the same issue, and "-".  But I figured that if it were very
> important, a good solution would appear ... ;)

On the second thought, perhaps file simply should not be there if
wakeup is not supported.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
