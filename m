Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310190AbSCEUZv>; Tue, 5 Mar 2002 15:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310201AbSCEUZn>; Tue, 5 Mar 2002 15:25:43 -0500
Received: from smtp4.vol.cz ([195.250.128.43]:13071 "EHLO majordomo.vol.cz")
	by vger.kernel.org with ESMTP id <S310190AbSCEUYT>;
	Tue, 5 Mar 2002 15:24:19 -0500
Date: Mon, 4 Mar 2002 16:26:15 +0000
From: Pavel Machek <pavel@suse.cz>
To: Andreas Ferber <aferber@techfak.uni-bielefeld.de>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
        linux-kernel@vger.kernel.org
Subject: Re: ext3 and undeletion
Message-ID: <20020304162614.C96@toy.ucw.cz>
In-Reply-To: <20020226171634.GL4393@matchmail.com> <Pine.LNX.3.95.1020226130051.4315A-100000@chaos.analogic.com> <20020228160552.C23019@devcon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20020228160552.C23019@devcon.net>; from aferber@techfak.uni-bielefeld.de on Thu, Feb 28, 2002 at 04:05:52PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
> > All the deleted files, with the correct path(s), are now in the
> > top directory file the file-system ../lost+found directory. They
> > are still owned by the original user, still subject to the same
> > quota.
> 
> And what about:
> 
> - Luser rm's "foo.c"
> - Luser starts working on new version of "foo.c"
> - Luser recognizes, that the old version was better
> - Luser rm's new "foo.c"
> - Luser tries to unrm the old "foo.c" -> *bang*
> 
> Trust me, there /will/ be a luser who tries to do it this way. If
> teaching lusers were enough, you'd have no need for an unrm at all.

You don't consider me a luser, right?

Okay, and I *did* need unrm few times. Few examples:

/dev# rm sbpcd *     (simple typo, recovered by immediate powerdown + fsck)
/big$ mp1enc > samotari.mpg (oops, I did it twice, second time by mistake, and
		powerswitch was too far away to make it in time)

So yes, unrm is usefull. And it would be even more usefull if it recovered
truncated files, too. How many times did you do > instead of >>? I did that
mistake many times, its just easy..
									Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

