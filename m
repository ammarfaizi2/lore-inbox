Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130744AbRALKP6>; Fri, 12 Jan 2001 05:15:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129511AbRALKPs>; Fri, 12 Jan 2001 05:15:48 -0500
Received: from as3-3-4.ml.g.bonet.se ([194.236.33.69]:36871 "EHLO
	tellus.mine.nu") by vger.kernel.org with ESMTP id <S129718AbRALKPb>;
	Fri, 12 Jan 2001 05:15:31 -0500
Date: Fri, 12 Jan 2001 10:15:45 +0100 (CET)
From: Tobias Ringstrom <tori@tellus.mine.nu>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.4 ate my filesystem on rw-mount
Message-ID: <Pine.LNX.4.30.0101120951270.7175-100000@svea.tellus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've never seen anything like it before, which I'm happy for.  The system
had been running a standard RedHat 7 kernel for days without any problems,
but who wants to run a 2.2 kernel?  I compiled 2.4.0 for it, rebooted, and
blam!  The RedHat init stripts got to the "remounting root read-write"
point, and just froze solid.

Rebooting into RH7 failed, becauce inittab could not be found.  In fact
the filesystem was completely messed up, with /dev empty, lots of device
nodes in /etc, and files missing all over the place.  I had to reinstall
RH7 from scratch.

I do not understand how this could happen during a remounting root rw.
Is the filesystem really that unstable?

Am I right in suspecting DMA, which was enabled at the time?  Any other
ideas?  Is it a known problem?

This is on a 450 MHz AMD-K6 with the following IDE controller:

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06)

[I know this is not a very good trouble report, but it will have to do for
the time beeing.  I hope to do more testing at a later time.]

/Tobias

PS. This is _not_ the same system that I reported IDE busy errors for.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
