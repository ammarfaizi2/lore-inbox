Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287645AbSALX6h>; Sat, 12 Jan 2002 18:58:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287656AbSALX60>; Sat, 12 Jan 2002 18:58:26 -0500
Received: from 12-234-33-29.client.attbi.com ([12.234.33.29]:1600 "HELO
	top.worldcontrol.com") by vger.kernel.org with SMTP
	id <S287645AbSALX6R>; Sat, 12 Jan 2002 18:58:17 -0500
From: brian@worldcontrol.com
Date: Sat, 12 Jan 2002 15:56:38 -0800
To: linux-kernel@vger.kernel.org
Subject: Repeated slowdowns in 2.4.17
Message-ID: <20020112235638.GA1857@top.worldcontrol.com>
Mail-Followup-To: Brian Litzinger <brian@top.worldcontrol.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23.2i
X-No-Archive: yes
X-Noarchive: yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My laptop, Duron 900MHz, 384MB RAM, running linux 2.4.17 with
preempt and ide patches, occasionally gets into an odd state
where each process only gets a tiny bit of CPU time every 7
seconds.  My laptop had been running for 10 minutes, and I
had up to this point run nothing unusual.

In an rxvt for example, type a few characters, and they show up
about 7 seconds later.  The delay isn't always 7 seconds.
The rxvt seems to be getting a bit of CPU every 7 seconds.
So if you type your characters just as the "slice" of
time is coming up they show up right away.

I got top running, and nothing unusual was happening.  swap
empty. top updating the screen every 7 seconds, eventhrough
it was set to 1 second update.

updatedb was running, and may have been what started the problem.
[guessing] I waited patiently and even after updatedb finished the 
system was still in the odd state.

I started killing things: lvcool, mozilla.  Nothing helped.

The system seemed to work, just with each process getting a
tiny bit of CPU every 7 seconds.

This problem occured before I added the ide patch.

While updatedb was running disk io seemed to be running full speed.

The X cursor moved on the screen fine, and I could switch
desktops (WindowMaker) instantly, but the processes that were to
fill in the screen were running in the 7 second mode.

I started a new rxvt and it showed up about 2 minutes later.

I ran poweroff and about 3 minutes later the system powered down.

Mouse/Keyboard events seemed to be instant so far as X was concerned.
Everywhere else they experienced the 7 second delay.

The problem occurs maybe once a week.  If anyone wants to suggest
that I try something the next time this occurs let me know.

-- 
Brian Litzinger <brian@worldcontrol.com>

    Copyright (c) 2002 By Brian Litzinger, All Rights Reserved
