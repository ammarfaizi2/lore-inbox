Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131602AbRCSTsD>; Mon, 19 Mar 2001 14:48:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131603AbRCSTry>; Mon, 19 Mar 2001 14:47:54 -0500
Received: from relay02.cablecom.net ([62.2.33.102]:20239 "EHLO
	relay02.cablecom.net") by vger.kernel.org with ESMTP
	id <S131602AbRCSTrp>; Mon, 19 Mar 2001 14:47:45 -0500
Message-ID: <3AB66233.B85881C7@bluewin.ch>
Date: Mon, 19 Mar 2001 20:46:59 +0100
From: Otto Wyss <otto.wyss@bluewin.ch>
Reply-To: otto.wyss@bluewin.ch
X-Mailer: Mozilla 4.76 (Macintosh; U; PPC)
X-Accept-Language: de,en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Linux should better cope with power failure
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lately I had an USB failure, leaving me without any access to my system
since I only use an USB-keyboard/-mouse. All I could do in that
situation was switching power off and on after a few minutes of
inactivity. From the impression I got during the following startup, I
assume Linux (2.4.2, EXT2-filesystem) is not very suited to any power
failiure or manually switching it off. Not even if there wasn't any
activity going on. 

Shouldn't a good system allways try to be on the save side? Shouldn't
Linux try to be more fail save? There is currently much work done in
getting high performance during high activity but it seems there is no
work done at all in getting a save system during low/no activity. I
think this is a major drawback and should be addressed as fast as
possible. Bringing a system to save state should allway have a high priority.

How could this be accomplished:
1. Flush any dirty cache pages as soon as possible. There may not be any
dirty cache after a certain amount of idle time.
2. Keep open files in a state where it doesn't matter if they where
improperly closed (if possible).
3. Swap may not contain anything which can't be discarded. Otherwise
swap has to be treated as ordinary disk space.

These actions are not filesystem dependant. It might be that certain
filesystem cope better with power failiure than others but still it's
much better not to have errors instead to fix them. 

Don't we tell children never go close to any abyss or doesn't have
alpinist a saying "never go to the limits"? So why is this simple rule
always broken with computers?

O. Wyss
