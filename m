Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131017AbRCJPZY>; Sat, 10 Mar 2001 10:25:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131018AbRCJPZN>; Sat, 10 Mar 2001 10:25:13 -0500
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:1796 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S131017AbRCJPZJ>;
	Sat, 10 Mar 2001 10:25:09 -0500
Message-ID: <20010309124609.B449@bug.ucw.cz>
Date: Fri, 9 Mar 2001 12:46:09 +0100
From: Pavel Machek <pavel@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Brian Dushaw <dushaw@munk.apl.washington.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux kernel - and regular sync'ing?
In-Reply-To: <Pine.LNX.4.30.0103071959050.17257-100000@munk.apl.washington.edu> <E14azEv-0002qR-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <E14azEv-0002qR-00@the-village.bc.nu>; from Alan Cox on Thu, Mar 08, 2001 at 12:09:51PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > at irregular intervals of 10-30 seconds, most likely calls to sync, so
> > that the disk never gets to sleep for long.  I've followed advice in the
> > various HOWTO's, e.g. modifying the line "ud::once:/sbin/update" in
> > /etc/inittab to only sync once an hour, to no avail.  Watching "top", it
> 
> Thats actually I think poor advice - it wont help and its asking to
> lose data

Get noflushd. (It is _also_ asking for data loose, if you write and
disk is spinned down, it will *not* bother spinning it up; you can
leave atimes on.)
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
