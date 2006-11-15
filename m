Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030984AbWKOUtt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030984AbWKOUtt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 15:49:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030985AbWKOUtt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 15:49:49 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:51437 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030984AbWKOUts (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 15:49:48 -0500
Date: Wed, 15 Nov 2006 21:49:33 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] floppy: suspend/resume fix
Message-ID: <20061115204933.GD3875@elf.ucw.cz>
References: <200611122047.kACKl8KP004895@harpo.it.uu.se> <20061112212941.GA31624@flint.arm.linux.org.uk> <20061112220318.GA3387@elte.hu> <20061112235410.GB31624@flint.arm.linux.org.uk> <20061114110958.GB2242@elf.ucw.cz> <1163522062.14674.3.camel@mindpipe> <20061115202418.GC3875@elf.ucw.cz> <20061115204915.1d0717db@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061115204915.1d0717db@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > Suspending with mounted floppy is a user error.
> > > 
> > > Huh?  How so?
> > 
> > Floppy is removable, and you are expected to umount removable devices
> > before suspend.
> 
> That seems pretty crude. There are lots of cases where an apparently
> removable device is/should be preserved properly and left mounted (eg
> builtin CF).
> 
> We really want to be smarter than that - which means the drivers ought to
> be doing stuff in their suspend/resume paths to figure out if the media
> changed when really possible (eg IDE removable)
> 
> Floppy is probably not too fixable, but calling it a "user error" is
> insulting - user expectation is reasonable that suspend/resume should
> just work. The implementation is just rather trickier/nonsensical in this
> case.

Yep, it would be nice to do something about that; but I'm not sure how
this "was media changed" should be implemented, and if it should be
done in kernel or in userland.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
