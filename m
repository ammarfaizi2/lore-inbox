Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262195AbULQAWL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262195AbULQAWL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 19:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262210AbULQAWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 19:22:11 -0500
Received: from mail.kroah.org ([69.55.234.183]:13801 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262195AbULQAWF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 19:22:05 -0500
Date: Thu, 16 Dec 2004 16:21:24 -0800
From: Greg KH <greg@kroah.com>
To: Grzegorz Kulewski <kangur@polcom.net>
Cc: Pete Zaitcev <zaitcev@redhat.com>,
       Mike Waychison <Michael.Waychison@Sun.COM>,
       linux-kernel@vger.kernel.org
Subject: Re: debugfs in the namespace
Message-ID: <20041217002124.GA11898@kroah.com>
References: <20041216110002.3e0ddf52@lembas.zaitcev.lan> <20041216190835.GE5654@kroah.com> <41C20356.4010900@sun.com> <20041216221843.GA10172@kroah.com> <20041216144531.3a8d988c@lembas.zaitcev.lan> <20041216225323.GA10616@kroah.com> <Pine.LNX.4.60.0412170033160.25628@alpha.polcom.net> <20041216235147.GC11330@kroah.com> <Pine.LNX.4.60.0412170101530.25628@alpha.polcom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0412170101530.25628@alpha.polcom.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2004 at 01:08:05AM +0100, Grzegorz Kulewski wrote:
> On Thu, 16 Dec 2004, Greg KH wrote:
> >Disadvantage:
> >- it puts a non-process type thing into /proc which is what I am
> >  specifically trying to get away from doing.
> >
> >Only process related things _should_ be in /proc.  Now if I can ever
> >fully achieve that goal in my lifetime is something that is left to be
> >seen...
> 
> Ok, probably - but who said this?

Well, if you can't find it written down anymore, here, I'll give you a
quote:
	"/proc should only be for process related things."
			- Greg Kroah-Hartman, December 16, 2004

> IIRC there is no standard describing what should be in proc and what
> should not.

We have one now, see above :)

> I do not think that after so many years of storing everyting in /proc
> there is any chance that you will remove all not [0-9]* dirs and files
> from /proc before the sun will stop lighting... :-)

Hey, everyone needs a windmill to chase after to define their life's
purpose...

> Many, really _many_, binary only apps are using proc for 999999
> different (often stupid) things

Yes, I'm well aware of the /proc/cpu abusing that is done by many binary
programs (oracle, jvm, etc.)  But it's the other things that definitely
don't belong in there (like the /proc/drivers/ tree stuff) that should
get moved out over time.  What do you think I've been doing over the
past 3 years with sysfs...

> - how you will change that? There is way too late for such change, in
> my opinion.

Slowly, over time, with creating good, standardised things like sysfs
(which has order to it), and fun, anarchistic things like debugfs.
Between the combination of the two, we'll get closer to an ideal, which
is better than what we have today.

> And polluting / with proc, sys, dev, selinux, debug and who knows what 
> else is at least equally bad.

Why?  Each location is defined to have one, specific, well defined thing
there that people can count on (or not count on in the case of /debug.)

thanks,

greg k-h
