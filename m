Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273099AbRIOVmX>; Sat, 15 Sep 2001 17:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273096AbRIOVmN>; Sat, 15 Sep 2001 17:42:13 -0400
Received: from [194.213.32.137] ([194.213.32.137]:45572 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S273085AbRIOVl5>;
	Sat, 15 Sep 2001 17:41:57 -0400
Message-ID: <20010915125716.A499@bug.ucw.cz>
Date: Sat, 15 Sep 2001 12:57:16 +0200
From: Pavel Machek <pavel@suse.cz>
To: Ignacio Vazquez-Abrams <ignacio@openservices.net>,
        linux-kernel@vger.kernel.org
Subject: Re: Strange /dev/loop behavior
In-Reply-To: <Pine.LNX.4.33.0109141505530.29038-100000@winds.org> <Pine.LNX.4.33.0109141519490.5549-100000@terbidium.openservices.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <Pine.LNX.4.33.0109141519490.5549-100000@terbidium.openservices.net>; from Ignacio Vazquez-Abrams on Fri, Sep 14, 2001 at 03:21:05PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Is there any known method of copying/compressing the loopback-mounted file-
> > system that always guarantees consistency after a sync, without requiring the
> > fs to be unmounted first?
> 
> Try mounting the loop device synchronously (mount ... -o sync).

That should not be needed. All data should be on disk by time umount
succeeds. That's not currently the case, and that's a bug.
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
