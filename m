Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262710AbULQBXq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262710AbULQBXq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 20:23:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262711AbULQBXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 20:23:46 -0500
Received: from mail.kroah.org ([69.55.234.183]:6294 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262710AbULQBXm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 20:23:42 -0500
Date: Thu, 16 Dec 2004 17:23:01 -0800
From: Greg KH <greg@kroah.com>
To: Grzegorz Kulewski <kangur@polcom.net>
Cc: Pete Zaitcev <zaitcev@redhat.com>,
       Mike Waychison <Michael.Waychison@Sun.COM>,
       linux-kernel@vger.kernel.org
Subject: Re: debugfs in the namespace
Message-ID: <20041217012301.GA12553@kroah.com>
References: <20041216190835.GE5654@kroah.com> <41C20356.4010900@sun.com> <20041216221843.GA10172@kroah.com> <20041216144531.3a8d988c@lembas.zaitcev.lan> <20041216225323.GA10616@kroah.com> <Pine.LNX.4.60.0412170033160.25628@alpha.polcom.net> <20041216235147.GC11330@kroah.com> <Pine.LNX.4.60.0412170101530.25628@alpha.polcom.net> <20041217002124.GA11898@kroah.com> <Pine.LNX.4.60.0412170204480.25628@alpha.polcom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0412170204480.25628@alpha.polcom.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2004 at 02:15:22AM +0100, Grzegorz Kulewski wrote:
> >>And polluting / with proc, sys, dev, selinux, debug and who knows what
> >>else is at least equally bad.
> >
> >Why?  Each location is defined to have one, specific, well defined thing
> >there that people can count on (or not count on in the case of /debug.)
> 
> Because in short time we will end with / occupying >1 page of console - 
> and it will be bad in my opinion. Besides do we really need that many 
> fses - each for exporting kernel data to userspace?

Yes, we do.

> This is at least strange. Why can not /dev, /selinux be merged into
> /sys (ok, maybe there should be symlinks in /dev to devices in right
> device directory in /sys). 

Because all three of them are radically different things.

> And I have also other question: Where can I find some info about using 
> /sys (in kernel)

Documentation/driver-model/* is a good start.  It's a bit out of date,
but better than nothing.  The lwn.net series of articles is also good to
look at.

> and some small note about its implementation and overhead (cpu and
> memory)?

For that you will have to look at the code itself.

Good luck,

greg k-h
