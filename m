Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261668AbREUUTR>; Mon, 21 May 2001 16:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261664AbREUUTG>; Mon, 21 May 2001 16:19:06 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:50436 "EHLO
	bug.ucw.cz") by vger.kernel.org with ESMTP id <S261653AbREUUSx>;
	Mon, 21 May 2001 16:18:53 -0400
Message-ID: <20010520225234.C2647@bug.ucw.cz>
Date: Sun, 20 May 2001 22:52:34 +0200
From: Pavel Machek <pavel@suse.cz>
To: Willem Konynenberg <wfk@xos.nl>, Abramo Bagnara <abramo@alsa-project.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: Why side-effects on open(2) are evil. (was Re: [RFD w/info-PATCH]device arguments from lookup)
In-Reply-To: <3B068D00.95338099@alsa-project.org> <200105191601.SAA04009@rabbit.xos.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <200105191601.SAA04009@rabbit.xos.nl>; from Willem Konynenberg on Sat, May 19, 2001 at 06:01:06PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Yes, and that is exactly the difference between having a side effect
> on the open(2), versus having the effect as a result of a write(2).
> 
> Unfortunately, there are already some cases where an open
> on a device can have unexpected results.  If you don't want
> to get blocked waiting for the carrier-detect signal from the
> modem when opening a tty device, you had better specify the
> O_NONBLOCK option on the open.  If you don't want this flag
> to be active during the actual I/O operations, then you would
> have to do an fcntl to clear the O_NONBLOCK again after the open.
> 
> So I guess things have already been a bit messy in this
> area for many years, even before linux even existed, and
> in some cases you can't really do anything about it because
> the behaviour is mandated by the applicable standards, like
> POSIX, SUS, or whatever.
> (The blocking of the open on a tty device is explicitly
>  documented in my copy of the X/Open specification.)
> 
> Fortunately, blocking the nightly backup program by making it
> accidentally open a tty is not quite as catastrophic as having
> it start a nuclear war, or format the disks, or something,
> just because a user was playing games with symlinks.

Maybe not *as* catastrophic, but security hole, anyway. User should
not be able to block system backups.

Small demonstration for bugtraq, anyone?
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
