Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261366AbTCOIdU>; Sat, 15 Mar 2003 03:33:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261364AbTCOIdU>; Sat, 15 Mar 2003 03:33:20 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:22277 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id <S261366AbTCOIdT>; Sat, 15 Mar 2003 03:33:19 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200303150846.h2F8k6IX000895@81-2-122-30.bradfords.org.uk>
Subject: Crash dumping
To: linux-kernel@vger.kernel.org
Date: Sat, 15 Mar 2003 08:46:06 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just wondering, we've had a lot of discussions in the past about
various serial port/network/disk crash dumping ideas, and always had
the problem of how do we know that the code we're about the execute
hasn't been corrupted, etc, which is especially important in the case
of the disk dumper.

Well, with the Linux BIOS project, couldn't we include some code in
the BIOS that we can jump to after a kernel crash, I.E. just switch to
real mode and start executing the BIOS-contained code to put the
system in to a sane state, and accept commands over the network[1] via
either UDP, or a custom protocol, to dump memory to disk, network, or
whatever?

Internet IMPs had loader/dumpers to do this kind of thing 30 years
ago, and I don't see why we can't ressurect the idea today.

[1] Obviously the code in the BIOS will be hard coded to work with
whatever network card you have, I.E. you would need to program the
right driver in to the BIOS for your particular card, and store the
machine's I.P. there as well, (and a password, or a list of local
I.P.s that were trusted - the idea being that you connect to the
machine via another machine on the LAN, not directly the internet
directly).

John.
