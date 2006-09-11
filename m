Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964848AbWIKXHX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964848AbWIKXHX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 19:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964897AbWIKXHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 19:07:23 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:3304 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S964848AbWIKXHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 19:07:23 -0400
Date: Tue, 12 Sep 2006 01:07:20 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Cc: eugeny.mints@gmail.com
Subject: cpufreq user<->kernel interface removal [was Re: community PM requirements/issues and PowerOP] (fwd)
Message-ID: <20060911230720.GA13728@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(I typoed in lkml address, sorry, and please include correct address
in Cc).

----- Forwarded message from Pavel Machek <pavel@ucw.cz> -----

To: "Eugeny S. Mints" <eugeny.mints@gmail.com>, lkml@elf.ucw.cz
Cc: Preece Scott-PREECE <scott.preece@motorola.com>,
	Matthew Locke <matt@nomadgs.com>, Greg KH <greg@kroah.com>,
	Amit Kucheria <amit.kucheria@nokia.com>,
	pm list <linux-pm@lists.osdl.org>,
	Mark Gross <mgross@linux.intel.com>,
	Igor Stoppa <igor.stoppa@nokia.com>
Subject: cpufreq user<->kernel interface removal [was Re: community PM requirements/issues and PowerOP]
X-Warning: Reading this can be dangerous to your mental health.

Hi!

(cc-ed to lkml).

> >>Just as a data point, "keeping the cpufreq interface" is
> >>irrelevant to a number of us, because we configure it out
> >>of the system.  I'm not really arguing that we should get
> >>rid of an existing kernel interface, but I don't see any
> >>reason why we shouldn't be able to have a separately
> >>configurable interface if cpufreq doesn't meet our needs.
> >
> >Configurable interfaces are evil,
> Are you saying that not having sysfs attribute nodes for entities which 
> don't exist in a certain configuration is evil?

I'm saying that

#ifdef CONFIG_FOO
	provide user<->kernel interface
#endif

is evil.

> >patch. You have developed your own little interface that suits your
> >needs -- and that's fine -- but now you are trying to push it into
> >mainline... and that is not, because those interfaces were not really
> >designed to work together.

> once cpufreq userland interface functionality which does not belong to the 
> kernel is moved out of the kernel cpufreq interface becomes a subset of 
> PowerOP sysfs interface. In other words this means that improvements of PM 
>  stack layers/interfaces design will allow to design/develop an universal 
> userspace interface. We'd prefer to move gracefully in this direction 
> though.

<tongue-in-cheek warning>

Yes, once cpufreq userland interface is removed from kernel, merging
powerop is reasonable thing to do. But please get at least
Documentation/feature-removal-schedule.txt patch merged to mainline
before attempting next powerop submission :-P.

<I'm trying to explain that removing cpufreq userland interface is
about as probable as MS Linux, and only a bit less likely than hell
freezing over.>
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

----- End forwarded message -----

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
