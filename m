Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261156AbVBLQdj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbVBLQdj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Feb 2005 11:33:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261157AbVBLQdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Feb 2005 11:33:38 -0500
Received: from mx2out.umbc.edu ([130.85.25.11]:11239 "EHLO mx2out.umbc.edu")
	by vger.kernel.org with ESMTP id S261156AbVBLQdd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Feb 2005 11:33:33 -0500
From: "Gregory Davis" <gregdavis@ieee.org>
To: <linux-kernel@vger.kernel.org>
Subject: 2.6.10 thru 2.6.11-rc3 hang
Date: Sat, 12 Feb 2005 11:33:29 -0500
Message-ID: <000601c51120$98b8ca00$04000100@JUPITER15>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-AvMilter-Key: 1108226313:95ea1f44bbb5a8058f8347cc2b1fcaad
X-Avmilter: Message Skipped, too small
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is probably an isolated incident, but I am having kernel hangs using
2.6.10 thru 2.6.11-rc3.  I have tried all different patchsets (mm, ck, cko),
and all produce the same behavior.  2.6.8.1 does not produce the behavior.
Basically, after a few minutes, the kernel hangs, and interrupts are
apparently not working as the keyboard leds don't respond anymore.  I
recently swapped out a cdrom for a dvdrom drive, and was able to use it fine
for a while with ck4 patched to 2.6.10.  Then I got gutsy and tried the mm
patch for 2.6.10, to start using reiser4.  That was when the kernel started
doing this hanging.  One surefire way to trigger a hang is to start a dvd
with mplayer:  the dvd reads the first few frames of any dvd, then hang;
however, hangs happen randomly otherwise.  I am running KDM as a login
manager, and X obviously when this happens, but without DRI.  I also have
tried going back to vanilla kernel, reformatting my drive to reiserfs3, and
an otherwise previous state, but the kernel still hangs.  I even unplugged
lots of stuff inside the PC to see if it was a current draw issue, but that
had no effect; besides 2.6.8.1 works (although X got really really really
slow and jerky for some reason).  I made sure all the CFLAGS were unset
before compiling, and this is with gcc-3.4.1, as have been the past umpteen
kernel builds for me.  I think I screwed up my system, or triggered some
obscure bug, but please send any ideas my way, and CC gregdavis@ieee.org as
I am not subscribed to the list.

Thanks,
Greg Davis


