Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262799AbTJWIMs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 04:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261705AbTJWIMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 04:12:42 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:35226 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261687AbTJWIMi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 04:12:38 -0400
Date: Sun, 19 Oct 2003 11:25:20 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Jakob Oestergaard <jakob@unthought.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Software RAID5 with 2.6.0-test
Message-ID: <20031019092519.GO1659@openzaurus.ucw.cz>
References: <1065690658.10389.19.camel@slurv> <Pine.LNX.3.96.1031017125544.24004C-100000@gatekeeper.tmr.com> <yw1xu167kbcw.fsf@users.sourceforge.net> <20031017192419.GG8711@unthought.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031017192419.GG8711@unthought.net>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Now that I'm posting anyway - I thought of a plus for the HW RAID
> controllers (hey, they're way behind on the scoreboard so far, so I
> might as well be a gentleman and give them a point or two):
> *) Battery backed write cache
> 
> This will allow the controller to say 'ok I'm done with your sync()',
> way before the data actually reaches the disk platters.  For some

Well, this would mean not only battery-backed controller,
but battery-backed drives, too. (Unless you want to assume that
memory-backup-battery never goes empty).

> While on that topic: SDRAM PCI cards with battery backup can be had
> relatively cheap up to at least a few gigabytes.  It'd be pretty cool to
> have the kernel recognize that for buffer storage. I could see the fun
> in doing half a million random writes and a sync(), and having the
> system tell me it's done the microsecond I issue the sync().

Sync would still take some time as it still makes sense to
do writeback... Main memory is still faster than PCI.
				Pavel 
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

