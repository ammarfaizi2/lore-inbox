Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932347AbWBGJYQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932347AbWBGJYQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 04:24:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932446AbWBGJYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 04:24:16 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:7850 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932347AbWBGJYP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 04:24:15 -0500
Date: Tue, 7 Feb 2006 10:23:56 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: Bojan Smojver <bojan@rexursive.com>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org,
       suspend2-devel@lists.suspend2.net
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060207092356.GA1742@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <20060207113159.nyjixl5eokookcsw@imp.rexursive.com> <20060207004448.GC1575@elf.ucw.cz> <200602071105.45688.nigel@suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602071105.45688.nigel@suspend2.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > *Users* would not be at disadvantage, but, surprise, there's one thing
> > more important than users. Thats developers, and I can guarantee you
> > that merging 14K lines of code just to delete them half a year later
> > would drive them crazy.
> 
> It would more be an ever-changing interface that would drive them crazy. So 
> why don't we come up with an agreed method of starting a suspend and 
> starting a resume that they can use, without worrying about whether 
> they're getting swsusp, uswsusp or Suspend2? /sys/power/state seems the 
> obvious choice for this. An additional /sys entry could perhaps be used to 
> modify which implementation is used when you echo disk > /sys/power/state 
> - something like
> 
> # cat /sys/power/disk_method
> swsusp uswsusp suspend2
> # echo uswsusp > /sys/power/disk_method
> # echo > /sys/power/state
> 
> Is there a big problem with that, which I've missed?

Well, for _users_ method seems to be clicking "suspend" in KDE. For
more experienced users it is powersave -U. And you are already
distributing script to do suspend... Just hook suspend2 to the same
gui stuff distributions already use.

Besides what you described can't work for uswsusp.
								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
