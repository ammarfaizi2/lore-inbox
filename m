Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273703AbRI3SZ7>; Sun, 30 Sep 2001 14:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273920AbRI3SZt>; Sun, 30 Sep 2001 14:25:49 -0400
Received: from [194.213.32.137] ([194.213.32.137]:11012 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S273703AbRI3SZk>;
	Sun, 30 Sep 2001 14:25:40 -0400
Message-ID: <20010930002339.A715@bug.ucw.cz>
Date: Sun, 30 Sep 2001 00:23:39 +0200
From: Pavel Machek <pavel@suse.cz>
To: Tim Connors <tcon@Physics.usyd.edu.au>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: resume before mounting root [diff against vanilla 2.4.9]
In-Reply-To: <200109270302.f8R32pl12537@saturn.cs.uml.edu> <Pine.SOL.3.96.1010927143756.6329A-100000@suphys.physics.usyd.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <Pine.SOL.3.96.1010927143756.6329A-100000@suphys.physics.usyd.edu.au>; from Tim Connors on Thu, Sep 27, 2001 at 02:51:50PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > That is totally broken, because I may mount the disk in between
> > the suspend and resume. I might even:
> > 
> > 1. boot kernel X
> > 2. suspend kernel X
> > 3. boot kernel Y
> > 4. suspend kernel Y
> > 5. resume kernel X
> > 6. suspend kernel X
> > 7. resume kernel Y
> > 8. suspend kernel Y
> > 9. goto #5
> > 
> > You really have to close the logs and mark the disks clean
> > when you suspend. The problems here are similar the the ones
> > NFS faces. Between the suspend and resume, filesystems may be
> > modified in arbitrary ways.
> 
> I missed the rest of the thread, but if you are talking about what I think
> you are talking about, I'll go <AOL>Me too</AOL>
> 
> A horrible combination of accidents with scripts that set lilo to boot
> to the hibernated partition if last suspended, and an apparent BIOS bug
> that allowed me to boot out of a hibernated partition for a second
> time meant that my laptop came out of regular hibernation mode (as

swsusp code will not allow you to restore from one partition twice.

								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
