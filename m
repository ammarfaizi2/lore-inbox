Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263228AbSLOXSE>; Sun, 15 Dec 2002 18:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263246AbSLOXSE>; Sun, 15 Dec 2002 18:18:04 -0500
Received: from [81.2.122.30] ([81.2.122.30]:3083 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S263228AbSLOXSD>;
	Sun, 15 Dec 2002 18:18:03 -0500
From: John Bradford <john@bradfords.org.uk>
Message-Id: <200212152337.gBFNbZp9002196@darkstar.example.net>
Subject: Re: 2.4.19, don't "hdparm -I /dev/hde" if hde is on a Asus A7V133 Promise ctrlr, or...
To: marvin@synapse.net (D.A.M. Revok)
Date: Sun, 15 Dec 2002 23:37:35 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200212151725.57046.marvin@synapse.net> from "D.A.M. Revok" at Dec 15, 2002 05:25:57 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> man, the Magic SysReq key didn't work ( at all ):
> it were DEAD
> The drive-light stayed on for 10+ hours, nothing happening ( that I could 
> figure out ) the whole time.  It /stayed/ dead.
> 
> /dev/hde is part of a RAID-5 in my system ( because I no longer trust 
> anything else ), and this only happens on drives connected onto the 
> Promise controller.
> 
> Oh, yeah, I forgot to include this:
> trying to touch/activate/read the S.M.A.R.T. in any drive on the Promise 
> kills it, too.  Can't activate the reliability-system without killing 
> the kernel? /that's/ ironic, eh?
> 
> 
> As for having another terminal connected to my home machine...
> 1. if the kernel's dead, then how's that gonna work, and

Maybe just the console was not responding.

If I start X with /dev/null as the core pointer, the console locks
completely, but I can still log in on a serial terminal.

I have seen machines which will mostly stop responding when you issue
a sleep command to a disk, E.G.

hdparm -Y /dev/hda

you can't terminate the process with control-C, for example, but if
you are logged in on another virtual terminal, or have another
terminal window open in X, you can reset the interface, and the
machine will respond again.

> 2. why have 2 terminals on one machine when I'm a hermit?

Why not?  I read and write a lot of E-Mail on a serial terminal right
next to my main console, and what about debugging SVGALIB applications?

> I /do/ thank you for the interface-reset tip, though, I hope I never need 
> that info  : )

It can be useful for recovering from a spun-down disk that won't spin
up again :-)

John
