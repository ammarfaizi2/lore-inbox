Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932377AbWIQTgB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932377AbWIQTgB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 15:36:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932375AbWIQTgB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 15:36:01 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:57216 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932374AbWIQTgA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 15:36:00 -0400
Date: Sun, 17 Sep 2006 20:14:22 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Joshua Brindle <method@gentoo.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, David Madore <david.madore@ens.fr>,
       Linux Kernel mailing-list <linux-kernel@vger.kernel.org>,
       LSM mailing-list <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH 3/4] security: capabilities patch (version 0.4.4), part 3/4: introduce new capabilities
Message-ID: <20060917181422.GC2225@elf.ucw.cz>
References: <20060910133759.GA12086@clipper.ens.fr> <20060910134257.GC12086@clipper.ens.fr> <1157905393.23085.5.camel@localhost.localdomain> <450451DB.5040104@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <450451DB.5040104@gentoo.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>Introduce six new "regular" (=on-by-default) capabilities:
> >>
> >> * CAP_REG_FORK, CAP_REG_OPEN, CAP_REG_EXEC allow access to the
> >>   fork(), open() and exec() syscalls,
> >>    
> >
> >CAP_REG_EXEC seems meaningless, I can do the same with mmap by hand for
> >most types of binary execution except setuid (which is separate it
> >seems)
> >
> >Given the capability model is accepted as inferior to things like
> >SELinux policies why do we actually want to fix this anyway. It's
> >unfortunate we can't discard the existing capabilities model (which has
> >flaws) as well really.

> To expand on this a little, some of the capabilities you are looking to 
> add are of very little if any use without being able to specify objects. 
> For example, CAP_REG_OPEN is whether the process can open any file 
> instead of specific ones. How many applications open no files whatsoever 
> in practice? 

Filters, for example. gzip -9 - and such stuff does not need to open
any files. These should be easy to lock down, and still very useful.

More applications could be made lock-down-aware, and for example ask
master daemon to open files for them over a (already opened) socket.

								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
