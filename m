Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129381AbRC0FM7>; Tue, 27 Mar 2001 00:12:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130516AbRC0FMt>; Tue, 27 Mar 2001 00:12:49 -0500
Received: from [209.250.53.66] ([209.250.53.66]:11268 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S129381AbRC0FMp>; Tue, 27 Mar 2001 00:12:45 -0500
Date: Mon, 26 Mar 2001 23:16:27 -0600
From: Steven Walter <srwalter@yahoo.com>
To: linux-kernel@vger.kernel.org
Subject: Strange lockups on 2.4.2
Message-ID: <20010326231627.A468@hapablap.dyn.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Uptime: 11:05pm  up 1 min,  1 user,  load average: 1.67, 0.57, 0.20
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This has happened twice, now, though I don't believe its completely
reproduceable.  What happens is an Oops, which drops me into kdb.  I've
been in X both times, however, which makes kdb rather useless.  I
blindly type "go", and interrupts get reenabled, at least (I know
because my mp3 stops looping and begins playing again).  This almost
must mean at least part of userspace survives.  Probably only X dies,
since VT switching and numlock-toggling doesn't work.  I can Ctrl+SysRq
S-U-B, though.

The thing I find most interesting about this is that only 4 lines of the
oops gets into the log.  4 lines, both times.  This time, those lines
were:

 printing eip:
c0112e1f
Oops: 0002
CPU:    0

This corresponds to schedule according to System.map (that's the nearest
symbol without going over).  Before I believe it was path_walk.  If
anyone's got an idea, it'd be helpful.  Btw, this machine consistently
passes memtest, most recently ran 2 passes of all tests with no errors
found.
-- 
-Steven
Freedom is the freedom to say that two plus two equals four.
