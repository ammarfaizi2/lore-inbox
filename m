Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267431AbTBXU1Q>; Mon, 24 Feb 2003 15:27:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267432AbTBXU1P>; Mon, 24 Feb 2003 15:27:15 -0500
Received: from [195.39.17.254] ([195.39.17.254]:4100 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S267431AbTBXU1N>;
	Mon, 24 Feb 2003 15:27:13 -0500
Date: Tue, 25 Feb 2003 13:02:47 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@digeo.com>
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: iosched: impact of streaming read on read-many-files
Message-ID: <20030225120247.GA663@zaurus.ucw.cz>
References: <20030220212304.4712fee9.akpm@digeo.com> <20030220212758.5064927f.akpm@digeo.com> <20030221104028.GO31480@x30.school.suse.de> <20030221131158.180125d7.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030221131158.180125d7.akpm@digeo.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > mplayer or xmms will never skip frames, not for parallel cp reading
> > floods of data at max speed like a database with zillon of threads. For
> > multimedia not to skip frames 1M/sec is  more than enough bandwidth,
> > doesn't matter if the huge database in background runs much slower as
> > far as you never skip a frame.
> 
> These applications are broken.  The kernel shouldn't be bending over
> backwards trying to fix them up.  Because this will never ever work as well
> as fixing the applications.
> 
> The correct way to design such an application is to use an RT thread to
> perform the display/audio device I/O and a non-RT thread to perform the disk

I do not think this can be done easily.
For mplayer case you'd need to mlock
X server...

And emacs/vi/all interactive tasks
 are in similar situation (latency matters),
are you going to make them all realtime?

-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

