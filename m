Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S144180AbRA1VBo>; Sun, 28 Jan 2001 16:01:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S144181AbRA1VBe>; Sun, 28 Jan 2001 16:01:34 -0500
Received: from cx425802-a.blvue1.ne.home.com ([24.0.54.216]:2564 "EHLO
	wr5z.localdomain") by vger.kernel.org with ESMTP id <S144180AbRA1VBW>;
	Sun, 28 Jan 2001 16:01:22 -0500
Date: Sun, 28 Jan 2001 15:00:05 -0600 (CST)
From: Thomas Molina <tmolina@home.com>
To: <phil@Stimpy.netroedge.com>
cc: Mikael Pettersson <mikpe@csd.uu.se>, <linux-kernel@vger.kernel.org>,
        <sensors@Stimpy.netroedge.com>
Subject: Re: time in the future during make for 2.4.0
In-Reply-To: <20010128115655.C4234@Stimpy.netroedge.com>
Message-ID: <Pine.LNX.4.30.0101281439050.666-100000@wr5z.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Jan 2001 phil@Stimpy.netroedge.com wrote:

>
> I had this problem when I was upgrading my kernel, and happened to do
> it during the daylight savings time roll-back.  Confused the heck out
> of me for a while.  Anyways, you can try 'touching' all your files,
> and do a 'make clean' then try again.  If it doesn't complain about a
> long arg list, you can try 'touch `find . -type f`'.

Several people emailed me with similar comments.  It seems I
occasionally have this habit of making myself look foolish.  The
explanation is this:  Yesterday I put a new processor and motherboard
into the system.  When I set up the BIOS I put in a date one day into
the future.  This morning's cron job called a remote time server which
corrected the date.  When I compiled the kernel this morning, confusion
reigned.  Sorry for bothering everyone.  Touching the files did fix the
problem.  I'll probably find a few more floating around causing problems
until 0302 tomorrow morning when I'm past all the future dates.

The motherboard change was instructive as was going from a K6-2 to an
Athlon.  Linux booted up without a problem while Windows crashed and
burned.  The best part was that I knew what was going to happen and I
had an audience.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
