Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289511AbSAWWzl>; Wed, 23 Jan 2002 17:55:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289970AbSAWWza>; Wed, 23 Jan 2002 17:55:30 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:17559 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S289925AbSAWWzU>;
	Wed, 23 Jan 2002 17:55:20 -0500
Date: Wed, 23 Jan 2002 17:55:17 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Pavel Machek <pavel@suse.cz>
cc: Jakob ?stergaard <jakob@unthought.net>,
        Ville Herva <vherva@twilight.cs.hut.fi>, linux-kernel@vger.kernel.org
Subject: Re: [STATUS 2.5]  January 18, 2002
In-Reply-To: <20020123113122.GC965@elf.ucw.cz>
Message-ID: <Pine.GSO.4.21.0201231751470.19120-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 23 Jan 2002, Pavel Machek wrote:

> > It's not a forced umount - it detaches the subtree from mountpoint and
> > filesystem(s) go away when they stop being busy.  But for remote
> > filesystems that's precisely what you want.
> 
> Can I umount filesystems below them?

Entire subtree gets umounted.  Stuff that isn't busy gets shut down
immediately, the rest - when it stops being busy.

> Can I reboot with
> busy-but-detached filesystems?

You can, but if they are local you'll get dirty shutdown (if they are still
busy at the time of reboot).

> Can I kill the processes accessing busy
> filesystems? [That was big point of force umount, I believe.]

Huh?  If process is killable - it's killable.  What does it have to
--force?

