Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131303AbRCHIr1>; Thu, 8 Mar 2001 03:47:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131302AbRCHIrI>; Thu, 8 Mar 2001 03:47:08 -0500
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:4612 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S131291AbRCHIrA>;
	Thu, 8 Mar 2001 03:47:00 -0500
Date: Wed, 7 Mar 2001 16:50:19 +0000
From: Pavel Machek <pavel@suse.cz>
To: Jonathan Morton <chromi@cyberspace.org>
Cc: Rik van Riel <riel@conectiva.com.br>, Andre Hedrick <andre@linux-ide.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Jeremy Hansen <jeremy@xxedgexx.com>, linux-kernel@vger.kernel.org
Subject: Re: scsi vs ide performance on fsync's
Message-ID: <20010307165019.A31@(none)>
In-Reply-To: <l0313030ab6ca4912a397@[192.168.239.101]> <Pine.LNX.4.21.0103060920320.5591-100000@imladris.rielhome.conectiva> <l0313030db6ca9bf216b9@[192.168.239.101]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <l0313030db6ca9bf216b9@[192.168.239.101]>; from chromi@cyberspace.org on Tue, Mar 06, 2001 at 02:08:27PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!
> If not, then the drive could by all means optimise the access pattern
> provided it acked the data or provided the results in the same order as the
> instructions were given.  This would probably shorten the time for a new
> pathological set (distributed evenly across the disk surface, but all on
> the worst-possible angular offset compared to the previous) to (8ms seek
> time + 5ms rotational delay) * 4000 writes ~= 52 seconds (compared with
> around 120 seconds for the previous set with rotational delay factored in).
> Great, so you only need half as big a power store to guarantee writing that
> much data, but it's still too much.  Even with a 15000rpm drive and 5ms
> seek times, it would still be too much.

Drive can trivially seek to reserved track, and flush data on it. All within 
25msec. Then, move data to proper location on next powerup.		Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

