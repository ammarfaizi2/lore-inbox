Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286246AbRLJMOV>; Mon, 10 Dec 2001 07:14:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286247AbRLJMOL>; Mon, 10 Dec 2001 07:14:11 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:46864 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S286246AbRLJMOA>; Mon, 10 Dec 2001 07:14:00 -0500
Date: Mon, 10 Dec 2001 13:13:53 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: Quinn Harris <quinn@nmt.edu>, linux-kernel@vger.kernel.org
Subject: Re: File copy system call proposal
Message-ID: <20011210131353.C19142@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20011209153522.A138@toy.ucw.cz> <200112101150.fBABosS271828@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200112101150.fBABosS271828@saturn.cs.uml.edu>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> I would like to propose implementing a file copy system call.
> >> I expect the initial reaction to such a proposal would be "feature
> >> bloat" but I believe some substantial benefits can be seen possibly
> >> making it worthwhile, primarily the following:
> >>
> >> Copy on write:
> >
> > You want cowlink() syscall, not copy() syscall. If they are on different
> > partitions, let userspace do the job.
> 
> That looks like a knee-jerk reaction to stuff going in the kernel.
> I want maximum survival of non-UNIX metadata and maximum performance
> for this common operation. Let's say you are telecommuting, and...

It would be very ugly if cp -a started behaving differently after you
upgrade it to use copyfile(). Better preserve only metadata you
"know".
								Pavel
-- 
Casualities in World Trade Center: 6453 dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
