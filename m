Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268551AbTCAOoO>; Sat, 1 Mar 2003 09:44:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268553AbTCAOoO>; Sat, 1 Mar 2003 09:44:14 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:19204 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id <S268551AbTCAOoM>; Sat, 1 Mar 2003 09:44:12 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200303011455.h21EtwhU000402@81-2-122-30.bradfords.org.uk>
Subject: Re: syslog full of kernel BUGS, frequent intermittent instability
To: coyote1@cytanet.com.cy (wyleus)
Date: Sat, 1 Mar 2003 14:55:58 +0000 (GMT)
Cc: redelm@ev1.net, linux-kernel@vger.kernel.org,
       vga@port.imtp.ilyichevsk.odessa.ua
In-Reply-To: <20030301082126.56c00418.coyote1@cytanet.com.cy> from "wyleus" at Mar 01, 2003 08:21:26 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It's the mandrake default AFAIK.  I don't know what all that stuff is, 
> so I don't mess with it.  My installation does "feel" bloated (very
> unscientific opinion): it "feels" much less responsive in the GUI

As your machine is quite old, you would probably get a noticable speed
increase from mounting your filesystems with noatime, which is very
straightforward and shouldn't cause any problems - just edit
/etc/fstab, and add the option noatime after each disk partition, for
example, you might have something like:

/dev/hda2	/	ext3	defaults		1  1

which you can change to

/dev/hda2	/	ext3	defaults, noatime	1  1

This is a bit off-topic, but in my experience is about the best way to
increase performance on old, (and not so old), hardware, apart from
compiling a custom kernel.  Without noatime, every time you read a
file, the current date and time is written to the disk.  With noatime,
it's only recorded for a write.  Almost no programs use the access
time data.

> Yesterday I ran burnMMX repeatedly and recorded the results in a
> text file.  Today, I took everything apart and cleaned up any dust
> and then moved the single RAM stick into the next slot over (I have
> 3 slots in total).

Are you sure there isn't a correct slot that it should be in?  Most
motherboard manuals specify that the slots should be used in a
specific order.

> Initially I was elated as I ran three tests for about 20 minutes
> each with no errors.  But my bubble popped on the 4th run.  Changing
> slots does look like it improved things judging from the results,
> but still not as it should be - at least that's the way it looks to
> me.

I seriously doubt that a single RAM module should be installed in the
middle slot of three.  One of the end slotf would seem more likely.

> I'm still running tests as I write this, but will copy the
> results so far below and let you judge;

> Where should I go from here?  Try another slot?  Buy new RAM?  More
> testing?

It might have been disconnecting and reconnecting the RAM that
improved things, not the change of slot.  Try both end slots.

John.
