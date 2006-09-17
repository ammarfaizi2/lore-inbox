Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965114AbWIQVZA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965114AbWIQVZA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 17:25:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965113AbWIQVZA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 17:25:00 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:48256 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S965111AbWIQVY7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 17:24:59 -0400
Date: Sun, 17 Sep 2006 20:06:19 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Joshua Brindle <method@gentoo.org>
Cc: James Morris <jmorris@namei.org>, David Madore <david.madore@ens.fr>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel mailing-list <linux-kernel@vger.kernel.org>,
       LSM mailing-list <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH 3/4] security: capabilities patch (version 0.4.4), part 3/4: introduce new capabilities
Message-ID: <20060917180619.GB2225@elf.ucw.cz>
References: <20060910133759.GA12086@clipper.ens.fr> <20060910134257.GC12086@clipper.ens.fr> <1157905393.23085.5.camel@localhost.localdomain> <20060910160953.GA6430@clipper.ens.fr> <Pine.LNX.4.64.0609110402250.15565@d.namei> <4505508A.1060105@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4505508A.1060105@gentoo.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>Can a non-root user create limited-rights processes without assistance
> >>from the sysadmin, under SElinux?
> >
> >SELinux uses a restrictive model, where privileges can only be removed, 
> >not added.
> >
> >  
> I think he was asking if a non-admin user can create processes of less 
> privilege without becoming root. The answer is yes, however, it is 
> policy driven. Users will have numerous 'derived' types that are less 
> privilege than, for example, their interactive shell. For example, 
> user_irc_t or user_evolution_t. The transitions will happen when the 
> user runs irc or evolution and those apps will be limited to the rights 
> they require. These are fine grained though, and mandatory. These 
> capabilities are so course grained I just can't see anyone ever using them.

Andrea already has his "seccomp" thing in kernel.... which is
basically "running without _any_ rights". So yes, this is useful.

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
