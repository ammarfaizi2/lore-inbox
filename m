Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132125AbRDPVRj>; Mon, 16 Apr 2001 17:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132130AbRDPVR3>; Mon, 16 Apr 2001 17:17:29 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:772 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S131408AbRDPVRT>;
	Mon, 16 Apr 2001 17:17:19 -0400
Date: Mon, 16 Apr 2001 15:29:29 +0000
From: Pavel Machek <pavel@suse.cz>
To: SodaPop <soda@xirr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oscillations in disk write compaction, poor interactive performance
Message-ID: <20010416152928.B40@(none)>
In-Reply-To: <200104122134.QAA24106@xirr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <200104122134.QAA24106@xirr.com>; from soda@xirr.com on Thu, Apr 12, 2001 at 04:34:32PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> It also seems that in the 2.4 kernels, we can get into a sort of
> oscillation mode, where we can have long periods of disk activity
> where nothing can get done - the low points, where only 2-3 writes
> per second can occur, so completely screw up the interactive
> performance that you simply have to take your hands off the
> keyboard and go get coffee until the disk writes complete.  I know
> we get better performance overall this way, but it can be
> frustrating when this occurs in the middle of video capture.

I see oscilation even in 2.2.X case....

Can you try running while true; do sync; sleep 1; done? It should help.

If it helps, try playing with bdflush/kupdate or how is it called/ parameters.

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

