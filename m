Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932114AbWAWBB3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114AbWAWBB3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 20:01:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932417AbWAWBB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 20:01:28 -0500
Received: from rwcrmhc13.comcast.net ([216.148.227.153]:42486 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932114AbWAWBB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 20:01:28 -0500
Message-ID: <43D42AA2.6040106@comcast.net>
Date: Sun, 22 Jan 2006 20:00:18 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Diego Calleja <diegocg@gmail.com>
CC: "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org
Subject: Re: soft update vs journaling?
References: <43D3295E.8040702@comcast.net>	<20060122093144.GA7127@thunk.org> <20060122205039.e8842bae.diegocg@gmail.com>
In-Reply-To: <20060122205039.e8842bae.diegocg@gmail.com>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Diego Calleja wrote:
> El Sun, 22 Jan 2006 04:31:44 -0500,
> Theodore Ts'o <tytso@mit.edu> escribió:
> 
> 
> 
>>One major downside with Soft Updates that you haven't mentioned in
>>your note, is that the amount of complexity it adds to the filesystem
>>is tremendous; the filesystem has to keep track of a very complex
>>state machinery, with knowledge of about the ordering constraints of
>>each change to the filesystem and how to "back out" parts of the
>>change when that becomes necessary.
> 
> 
> 
> And FreeBSD is implementing journaling for UFS and getting rid of 
> softupdates [1]. While this not proves that softupdates is "a bad idea",
> i think this proves why the added sofupdates complexity doesn't seem
> to pay off in the real world. 
> 

Yeah, the huge TB fsck thing became a problem.  I wonder still if it'd
be useful for small vfat file systems (floppies, usb drives); nobody has
led me to believe it's definitely feasible to not corrupt meta-data in
this way.

I guess journaling is looking a lot better. :)

> [1]: http://lists.freebsd.org/pipermail/freebsd-hackers/2004-December/009261.html
> 
> "4.  Journaled filesystem.  While we can debate the merits of speed and
> data integrety of journalling vs. softupdates, the simple fact remains
> that softupdates still requires a fsck run on recovery, and the
> multi-terabyte filesystems that are possible these days make fsck a very
> long and unpleasant experience, even with bg-fsck.  There was work at
> some point at RPI to add journaling to UFS, but there hasn't been much
> status on that in a long time.  There have also been proposals and
> works-in-progress to port JFS, ReiserFS, and XFS.  Some of these efforts
> are still alive, but they need to be seen through to completion"
> 

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFD1CqhhDd4aOud5P8RAjvDAJ0W9pcNQ31v0RWSSIGVitnSpfvReQCdHBah
usgY72whnDcCwgshpVFW02o=
=Px/i
-----END PGP SIGNATURE-----
