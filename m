Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266851AbTAZRaq>; Sun, 26 Jan 2003 12:30:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266852AbTAZRaq>; Sun, 26 Jan 2003 12:30:46 -0500
Received: from kunde0416.oslo-asen.alfanett.no ([62.249.189.163]:33034 "EHLO
	kunde0416.oslo-asen.alfanett.no") by vger.kernel.org with ESMTP
	id <S266851AbTAZRao>; Sun, 26 Jan 2003 12:30:44 -0500
Date: Sun, 26 Jan 2003 18:39:54 +0100 (CET)
From: Peter Karlsson <peter@softwolves.pp.se>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20 kernel crashes while scanning partition list
In-Reply-To: <m365sclylx.fsf@varsoon.wireboard.com>
Message-ID: <Pine.LNX.4.43.0301261833330.28040-100000@perkele>
Mail-Copies-To: Peter Karlsson <peter@softwolves.pp.se>
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
Organization: /universe/earth/europe/norway/oslo
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug McNaught:

> Have you tried 2.4.21pre?  It may have fixes to handle newer hardware.

Not yet, I did try 2.4.19, to see if that worked better, but got the
same crash. 2.4.18 seems to be different, however, since it does not
autodetect the drives (and does not crash when I pass the IDE addresses
manually).

> Does the machine pass memtest86?

No errors were reported.


Mark Hahn:

> well, posting an undecoded oops is one mistake.

Someone decoded it and posted a decoded trace. Did that not arrive to
the list properly?

> can you dispense with the silly hardware dumb-raid, and just use
> kernel software raid? (faster, more robust).

I'd prefer to use the on-board RAID to be compatible with other OSes.
And, according to people I have asked, the Linux software-RAID is not
very reliable either, so I don't feel especially inclined to switch.

> I decoded your oops, below.  it's not much use without someone also
> running objdump -D drivers/block/ll_rw_blk.o on your system and
> figuring out how the eip=0 happened.  it's obviously some callback.

If I run this (I can boot the machine using 2.4.18), what should I
look for? I haven't debugged the kernel before, it has just always
worked for me, on all the machines I've tried it. I've only ever had
the kernel crash once on me before since 1996.

> it's also somewhat odd that prink is in the backtrace.

That might be a typo on my part.

> there are no printk's before the oops?

The last thing that happens before the crash is that it tries to
enumerate the hard disk partitions. I lists a few but then crashes.

-- 
\\//
Peter - http://www.softwolves.pp.se/

  I do not read or respond to mail with HTML attachments.


