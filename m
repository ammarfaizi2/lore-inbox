Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273930AbRIRVMB>; Tue, 18 Sep 2001 17:12:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273931AbRIRVLr>; Tue, 18 Sep 2001 17:11:47 -0400
Received: from [194.213.32.137] ([194.213.32.137]:52228 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S273930AbRIRVLW>;
	Tue, 18 Sep 2001 17:11:22 -0400
Message-ID: <20010918221933.A12226@bug.ucw.cz>
Date: Tue, 18 Sep 2001 22:19:33 +0200
From: Pavel Machek <pavel@suse.cz>
To: Alex Stewart <alex@foogod.com>, Xavier Bestel <xbestel@aplio.fr>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Forced umount (was lazy umount)
In-Reply-To: <Pine.LNX.4.21.0109171144210.1357-100000@penguin.homenet> <3BA68562.6030806@foogod.com> <1000768993.20059.5.camel@nomade> <3BA69D84.3020909@foogod.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <3BA69D84.3020909@foogod.com>; from Alex Stewart on Mon, Sep 17, 2001 at 06:04:04PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>I see no reason why a properly functioning system should ever need to 
> >>truly force a umount.  Under normal conditions, if one really needs to 
> >>do an emergency umount, it should be possible to use fuser/kill/etc to 
> >>clean up any processes using the filesystem from userland and then 
> >>perform a normal umount to cleanly unmount the filesystem in question 
> [...]
> 
> > 
> > Imagine you have a cdrom mounted with process reading it. You may want
> > to eject this cdrom without killing all processes, but just make them
> > know that there's an error somewhere, go read something else.
> > So it won't kill your shells, Nautilus/Konqueror, etc.
> 
> 
> Ok, I should have made my terms more clear.  I see no reason why a 
> properly functioning system should *need* to force a umount.  There's a 
> difference between "need" and "want".  What you're talking about is a 
> convenience (and I admitted that the patch would make some things more 
> convenient), but not a necessity.  With decently written software you 
> should be able to simply go to the relevant programs and tell them to 
> stop using the filesystem before you unmount it.  All this does is make 
> that process a little less tedious.

...so... it means that my kwintv (tv-in window) application should
have menu option to chdir somewhere else?

Imagine (common error for me):

cd /cdrom
kwintv &
[work]

I now want to umount cdrom. How do I do it? Do you suggest each app
to have "cd /" menu entry?
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
