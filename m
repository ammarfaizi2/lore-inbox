Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318169AbSIJV7c>; Tue, 10 Sep 2002 17:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318170AbSIJV7b>; Tue, 10 Sep 2002 17:59:31 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:36873 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S318169AbSIJV73>; Tue, 10 Sep 2002 17:59:29 -0400
Date: Tue, 10 Sep 2002 17:52:56 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Oliver Xymoron <oxymoron@waste.org>
cc: Linus Torvalds <torvalds@transmeta.com>,
       "David S. Miller" <davem@redhat.com>, jgarzik@mandrakesoft.com,
       david-b@pacbell.net, mdharm-kernel@one-eyed-alien.net, greg@kroah.com,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB changes for 2.5.34
In-Reply-To: <20020910193228.GL31597@waste.org>
Message-ID: <Pine.LNX.3.96.1020910173301.8675A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Sep 2002, Oliver Xymoron wrote:

> Which still leaves the question, does it really make sense for
> FATAL/BUG to forcibly kill the machine? If the bug is truly fatal,
> presumably the machine kills itself in short order anyway, otherwise
> we might have a shot at recording the situation. A more useful
> distinction might be in terms of risk of damaging filesystems (or perhaps
> hardware) if we continue, something like BROKEN/DANGEROUSLY_BROKEN.

And that's the heart of the thing, if continuing is likely to trash
filesystem or (unlikely) damage hardware, then the system should go down
RIGHT NOW.

I've often wondered if it wouldn't be better to allow the user to provide
a partition for oops use, where the kernel could write kmen and a few
chosen other bit of information. Get all the oops output formatting code
out of the kernel. Then the user could run tools like ksymoops against the
oops after reboot, and a small utility could wrap and compress the oops,
symbols table, config, etc, for future use by the user or developer. 

I've sent a fair number of crash dumps of AIX to IBM, seems a good idea.
And developers could have personal tools, archetecture dependent tools,
ksysoops could be enhanced after the fact.

If it would help with a nasty bug I'd put all that and the kernel source I
used, the module tree, etc, on a CD and send it. Whatever helps solve the
problem. Too often the output is lost on the console and not written
anywhere recoverable.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

