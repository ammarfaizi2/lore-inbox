Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265024AbTF1Cak (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 22:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265031AbTF1Cak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 22:30:40 -0400
Received: from mta06bw.bigpond.com ([139.134.6.96]:21500 "EHLO
	mta06bw.bigpond.com") by vger.kernel.org with ESMTP id S265024AbTF1Caj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 22:30:39 -0400
Date: Sat, 28 Jun 2003 12:39:08 +1000
From: Michael Still <mikal@stillhq.com>
To: <linux-usb-devel@lists.sourceforge.net>
cc: <linux-kernel@vger.kernel.org>
Subject: [Announce] Linux command line Snoopy Pro logfile dumper
Message-ID: <Pine.LNX.4.30.0306280758030.9762-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I had two maths exams last week. This of course means that I had to find
something to distract me. That thing was whipping up a SnoopyPro logfile
dumper for the command line. This was motivated by generalised frustration
with the SnoopyPro user interface.

For those wondering, SnoopyPro is a Source Force hosted USB traffic dumper
for Windows. It's useful when reverse engineering USB device drivers.

This version of the dumper only implements the URB types which I
immediately needed. Adding additional URBs isn't hard, but I didn't have
any samples. Feel free to mail me usblogs, and I'll add them to the
decoder.

The only really cool feature in this version is that it implements
"repeated URB sequence suppression", so if the Windows driver says to the
USB device "hey, you still there" every second for 60 seconds, and there
is no other traffic between the machine and that device, then the output
will only show one of those interactions, and let you know it hid 59 more.
This feature can be turned on and off with the -r command line option.

You can get the GPL'ed CVS version of the source code from:
http://www.stillhq.com/extracted/usblogdump.tgz

There is sample output et cetera at:
http://www.stillhq.com/cgi-bin/getpage?area=usblogdump

The next step is to modify the display of the URBs so that they're closer
to the Linux data structures.

Cheers,
Mikal

-- 

Michael Still (mikal@stillhq.com) | Stage 1: Steal underpants
http://www.stillhq.com            | Stage 2: ????
UTC + 10                          | Stage 3: Profit



