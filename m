Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161014AbWBTQbw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161014AbWBTQbw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 11:31:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161016AbWBTQbw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 11:31:52 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:63884 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1161014AbWBTQbw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 11:31:52 -0500
Date: Mon, 20 Feb 2006 13:53:05 +0100
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: Matthias Hensler <matthias@wspse.de>, Sebastian Kgler <sebas@kde.org>,
       kernel list <linux-kernel@vger.kernel.org>, rjw@sisk.pl
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060220125305.GC16165@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602201025.01823.nigel@suspend2.net> <20060220005333.GL15608@elf.ucw.cz> <200602201250.44443.nigel@suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602201250.44443.nigel@suspend2.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > > > > The only con I see is the complexity of the code, but then again,
> > > > > > > Nigel
> > > > > >
> > > > > > ..but thats a big con.
> > > > >
> > > > > It's fud. Hopefully as I post more suspend2 patches to LKML, people
> > > > > will see that Suspend2 is simpler than what you are planning.
> > > >
> > > > For what I'm planning, all the neccessary patches are already in -mm
> > > > tree. And they are *really* simple. If you can get suspend2 to 1000
> > > > lines of code (like Rafael did with uswsusp), we can have something to
> > > > talk about.
> > >
> > > Turn it round the right way. If you can get the functionality of Suspend2
> > > using userspace only, then we have something to talk about.
> >
> > Only feature I can't do is "save whole pagecache"... and 14000 lines
> > of code for _that_ is a bit too much. I could probably patch my kernel
> > to dump pagecache to userspace, but I do not think it is worth the
> > effort.
> 
> Yes, 14,000 lines for that alone would be a bit too much :)

Great we agree on that... because "save whole pagecache" is the only
feature that is not possible with current uswsusp code. 

> > > And you do need?...
> >
> > I do not need anything more than what is already in -mm tree.
> 
> You misunderstand me. Let me reprhase. What additional dependencies do you 
> have in userspace to support this? libabc, v >= x.y.z etc.

Currently it depends on libc, and optionaly at liblzf. We'll probably
add libssl dependency later.

BUT NONE OF THIS MATTERS. suspend.sf.net is only one implementation,
you are welcome to do different one. If we cared about userland
dependencies, we could simply include all the libraries into
suspend.sf.net's CVS.
								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
