Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131481AbRDYUFH>; Wed, 25 Apr 2001 16:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131498AbRDYUE6>; Wed, 25 Apr 2001 16:04:58 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:6148 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S131481AbRDYUEw>;
	Wed, 25 Apr 2001 16:04:52 -0400
Message-ID: <20010425220120.A1540@bug.ucw.cz>
Date: Wed, 25 Apr 2001 22:01:20 +0200
From: Pavel Machek <pavel@suse.cz>
To: Chris Mason <mason@suse.com>, viro@math.psu.edu,
        kernel list <linux-kernel@vger.kernel.org>,
        jack@atrey.karlin.mff.cuni.cz
Cc: torvalds@transmeta.com
Subject: Re: [patch] linux likes to kill bad inodes
In-Reply-To: <20010422141042.A1354@bug.ucw.cz> <302200000.988205393@tiny>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <302200000.988205393@tiny>; from Chris Mason on Wed, Apr 25, 2001 at 09:29:53AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Hi!
> > 
> > I had a temporary disk failure (played with acpi too much). What
> > happened was that disk was not able to do anything for five minutes
> > or so. When disk recovered, linux happily overwrote all inodes it
> > could not read while disk was down with zeros -> massive disk
> > corruption.
> > 
> > Solution is not to write bad inodes back to disk.
> > 
> 
> Wouldn't we rather make it so bad inodes don't get marked dirty at all?

I guess this is cheaper: we can mark inode dirty at 1000 points, but
you only write it at one point.

But I'm no FS expert.
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
