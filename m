Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: (majordomo@vger.rutgers.edu) by vger.rutgers.edu via listexpand id <S160142AbQGaWOD>; Mon, 31 Jul 2000 18:14:03 -0400
Received: by vger.rutgers.edu id <S160133AbQGaWNo>; Mon, 31 Jul 2000 18:13:44 -0400
Received: from enterprise.cistron.net ([195.64.68.33]:1471 "EHLO enterprise.cistron.net") by vger.rutgers.edu with ESMTP id <S160160AbQGaWNC>; Mon, 31 Jul 2000 18:13:02 -0400
From: miquels@cistron.nl (Miquel van Smoorenburg)
Subject: Re: RLIM_INFINITY inconsistency between archs
Date: 31 Jul 2000 22:33:22 GMT
Organization: Cistron Internet Services B.V.
Message-ID: <8m4uri$d9e$1@enterprise.cistron.net>
References: <7iw6kYsXw-B@khms.westfalen.de> <Pine.LNX.3.95.1000731132321.529A-100000@chaos.analogic.com> <8m4q9v$871$1@enterprise.cistron.net> <8m4tn3$cri$1@cesium.transmeta.com>
X-Trace: enterprise.cistron.net 965082802 13614 195.64.65.200 (31 Jul 2000 22:33:22 GMT)
X-Complaints-To: abuse@cistron.nl
To: linux-kernel@vger.rutgers.edu
Sender: owner-linux-kernel@vger.rutgers.edu

In article >8m4tn3$cri$1@cesium.transmeta.com>,
H. Peter Anvin <hpa@zytor.com> wrote:
>Followup to:  <8m4q9v$871$1@enterprise.cistron.net>
>By author:    miquels@cistron.nl (Miquel van Smoorenburg)
>In newsgroup: linux.dev.kernel
>> 
>> No. Even Linus himself has been saying for years (and recently even
>> in this thread) that /usr/include/linux and /usr/include/asm should
>> NOT EVER be symlinks to /usr/src/linux
>> 
>> Everything in /usr/include belongs to and depends on glibc, not
>> the currently running kernel.
>
>Unfortunately that doesn't work very well.  For user-space daemons
>which talk to Linux-specific kernel interfaces, such as automount, you
>need both the glibc and the Linux kernel headers.

Yes, but you can't mix&match anyway. For stuff like that you're
probably best off by using a talktokernel.c file that is
compiled with -I/path/to/kernel/include while the rest of the
daemon doesn't know about kernel internals.

That could and perhaps should be fixed, but I think that is
a different issue entirely.

Mike.
-- 
Cistron Certified Internetwork Expert #1. Think free speech; drink free beer.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
