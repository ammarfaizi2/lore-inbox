Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272743AbTHKP37 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 11:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272745AbTHKP36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 11:29:58 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:17039 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S272743AbTHKP3z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 11:29:55 -0400
Date: Mon, 11 Aug 2003 17:29:31 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Rob Landley <rob@landley.net>
Cc: M?ns Rullg?rd <mru@users.sourceforge.net>, linux-kernel@vger.kernel.org,
       Pavel Machek <pavel@ucw.cz>
Subject: Re: [Swsusp-devel] Re: [PATCH] Allow initrd_load() before software_resume() (version 2)
Message-ID: <20030811152931.GA2627@elf.ucw.cz>
References: <20030801002742.1033FE8003AE@mwinf0502.wanadoo.fr> <20030806125749.GA6875@openzaurus.ucw.cz> <yw1xsmofvsd8.fsf@users.sourceforge.net> <200308102208.10588.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308102208.10588.rob@landley.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > >> > > Okay. I hadn't tried it yet. I'll happily take up the barrow for you
> > >> > > and push it to Pavel and Linus with the rest, if you like.
> > >> >
> > >> > Don't even think about that.
> > >> >
> > >> > It is not safe to run userspace *before* doing resume. You don't want
> > >> > to see problems this would bring in. Forget it.
> > >>
> > >> so how do you resume from a partition on a device mapper volume?
> > >>
> > >> (and yes I basically agree with your sentiment though)
> > >
> > > I know very little about DM, its very well possible that resume from
> > > it is not supported.
> >
> > Since DM requires some userspace program to set up the mappings, it
> > seems to me that it wouldn't work to resume from a DM volume.  I'd
> > much appreciate if it would work, somehow.
> 
> Er, query:
> 
> At some point in the vague nebulous future, after initrd has become initramfs, 
> the partition detection code is scheduled to be ripped out, correct?  And 
> replaced with a userspace thing run out of initrd ala hotplug and udev and 
> all that?
> 
> So at that point, it's not just device mapper that's going to need something 
> else to run in userspace to attach block devices to partitions.  Everything 
> will.
> 
> So are you saying that swsusp is a short-term thing that will be dropped in 
> 2.8 because it can't be made to work?  Or that we WILL have to deal with this 
> at some point, just not yet?

At that point we'll have to carefully audit all userland code that can
run before software resume.
									Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
