Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932896AbWKLNkU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932896AbWKLNkU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 08:40:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932897AbWKLNkT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 08:40:19 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:55185 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932896AbWKLNkS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 08:40:18 -0500
Date: Sun, 12 Nov 2006 14:39:43 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Eric Sandeen <sandeen@sandeen.net>
Cc: Steve Grubb <sgrubb@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] handle ext3 directory corruption better
Message-ID: <20061112133943.GB11484@elf.ucw.cz>
References: <200610211129.23216.sgrubb@redhat.com> <20061031095742.GA4241@ucw.cz> <200611011029.39295.sgrubb@redhat.com> <4554E7C1.1070705@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4554E7C1.1070705@sandeen.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> Nice... can you run the same tool against fsck, too?
> > 
> > I'll see if I can make that work, too. The fuzzer tries to preserve the bad 
> > image so that you can replay the problem for debugging. I think its just a 
> > matter of making another copy and using that one instead.
> 
> I played with this on xfs a little bit in my spare time, found some
> xfs_repair problems.  :)  I'm sure other fs's would have issues as well.

Yes... I played with similar tool few years ago on ext2, and it lead
to fixing couple of bugs in e2fsck, too. vfat/reiser were too buggy
for this test to be useful.

> Ideally it would probably be good for the tool to have a "use" mode (try
> to use the corrupted fs) and a "check" mode (try to fsck the corrupted fs).
> 
> In use   mode, it'd be:  mkfs, fuzz, mount, populate (etc), unmount.
> In check mode, it'd be:  mkfs, mount, populate, unmount, fuzz, fsck.

Yes, that's what I did back then.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
