Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280583AbRKYAZG>; Sat, 24 Nov 2001 19:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280585AbRKYAY4>; Sat, 24 Nov 2001 19:24:56 -0500
Received: from mauve.demon.co.uk ([158.152.209.66]:49300 "EHLO
	mauve.demon.co.uk") by vger.kernel.org with ESMTP
	id <S280583AbRKYAYk>; Sat, 24 Nov 2001 19:24:40 -0500
From: Ian Stirling <root@mauve.demon.co.uk>
Message-Id: <200111250024.AAA10086@mauve.demon.co.uk>
Subject: Re: Journaling pointless with today's hard disks?
To: phil-linux-kernel@ipal.net (Phil Howard)
Date: Sun, 25 Nov 2001 00:24:28 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011124174134.B4372@vega.ipal.net> from "Phil Howard" at Nov 24, 2001 05:41:34 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<snip>
> It could be that other drives have the capability to detect and write
> over sectors made bad by power off.  Or maybe they lock out the sector
> and map to a spare.  They might even have enough spin left to finish
> the sector correctly in more cases.
> 
> So I doubt the issue is present in other drives, unless the issue is
> not really as big of one as we might think and the problems with IBM
> drives are something else.
> 
> I do worry that the lighter the platters are, the faster they try to
> make the drives spin with smaller motors, and the quicker they slow
> down when power is lost.

Utterly unimportant.
Let's say for the sake of argument that the drives spins down to a stop
in 1 second.
Now, the datarate for this 40G IDE drive I've got in my box is about
25 megabytes per second, or about 50K sectors per second.
Slowing down isn't a problem.

Somewhere I've got a databook, ca 85 I think, for a motor driver chip, 
to drive spindle motors on hard disks, with integrated 
diodes that rectify the power coming from the disk when the power fails,
to give a little grace.

If written by people with a clue, the drive does not need to do much
seeking to write the data from a write-cache to dics, just one seek 
to a journal track, and a write.
This needs maybe 3 revs to complete, at most.
