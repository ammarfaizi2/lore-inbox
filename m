Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbRAEQVj>; Fri, 5 Jan 2001 11:21:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129406AbRAEQV3>; Fri, 5 Jan 2001 11:21:29 -0500
Received: from thick.mail.pipex.net ([158.43.192.95]:30115 "HELO
	thick.mail.pipex.net") by vger.kernel.org with SMTP
	id <S129267AbRAEQVJ>; Fri, 5 Jan 2001 11:21:09 -0500
From: Chris Rankin <rankinc@zip.com.au>
Message-Id: <200101051413.f05EDu405677@wittsend.ukgateway.net>
Subject: Looking for maintainer of ENSONIQ SoundScape driver
To: linux-kernel@vger.kernel.org
Date: Fri, 5 Jan 2001 14:13:55 +0000 (GMT)
Cc: linux-sound@vger.kernel.org
Reply-To: rankinc@zip.com.au
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have an ENSONIQ SoundScape PNP sound card, and I am noticing
problems with it under linux-2.4.0-prerelease and linux-2.4.0. I have
created 2 diffs which solve the most pressing problem (and sort a few
messages out), but the driver seems to have deeper issues which I
would like to discuss with its maintainer, please. For instance,
although /dev/mixer does not use sscape.o (the mixer driver is in the
ad1848.o module), unloading sscape.o while a mixer application is
running causes a kernel oops when the application exits. The way that
sscape.o allocates IO ports is also suspicious, and causes these
messages to be logged every time the sound modules are loaded:

Jan 5 14:08:31 wittsend kernel: Trying to free nonexistent resource <00000338-00000339>
Jan 5 14:08:31 wittsend kernel: Trying to free nonexistent resource <00000330-00000337>

There is no specific person mentioned in the MAINTAINERS file for this
ISA PNP card, and I have received no response from the linux-sound
mailing list.

Is there anybody out there? 
Cheers,
Chris
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
