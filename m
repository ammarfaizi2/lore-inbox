Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262756AbUGXV4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262756AbUGXV4o (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 17:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262768AbUGXV4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 17:56:44 -0400
Received: from out006pub.verizon.net ([206.46.170.106]:11666 "EHLO
	out006.verizon.net") by vger.kernel.org with ESMTP id S262756AbUGXV4l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 17:56:41 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Organization: Organization: undetectable
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: 2.6.8-rc2 crash(s)?
Date: Sat, 24 Jul 2004 21:56:40 -0400
User-Agent: KMail/1.6
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200407242156.40726.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out006.verizon.net from [151.205.56.111] at Sat, 24 Jul 2004 16:56:40 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings;

Machine is a new Biostar M7NCD-Pro mobo, with an athlon
2800 XP that says its a 2800 in the bootup so it not
overclocked, nor is it too warm, showing 125F right now.
It did take some non-default bios settings to achieve that,
the default running the memory as DDR333, but the cpu as
a 3200+, which understandably didn't always want to post!

Kernel is 2.6.8-rc2, with the forcedeth driver using the
builtin ethernet on this board.  The mobo has a Gig of ram
which signs on in the bios as
"DDR400 Dual Channel Mode Enabled (etc)"

I just re-entered the room from a few hours of other work,
and found this machine had apparently crashed.  I was not
able to ssh into it from the firewall, or make it respond
to the vulcan nerve pinch, so I hit the reset button and
waited for about 120G of hard drives to fsck.

This is the 2nd, or maybe the third time this has happened
since I put in this new mobo, which passes a half a days run
on memtest86 with no errors.  I *think* I've got the APIC
stuff turned off in the bios, and I'm not using it in the
kernel as I want this box to run 24/7.

The only screen blanker is a blank, black screen.

This is the only log entries made at what must have been its
untimely demise:
----------------------
Jul 24 15:37:39 coyote kernel: Unable to handle kernel paging request at virtual address 5f697461
Jul 24 15:37:39 coyote kernel:  printing eip:
Jul 24 15:37:39 coyote kernel: c0164376
Jul 24 15:37:39 coyote kernel: *pde = 00000000
Jul 24 15:37:39 coyote kernel: Oops: 0002 [#1]
Jul 24 15:37:39 coyote kernel: PREEMPT
Jul 24 15:37:39 coyote kernel: Modules linked in: tuner tvaudio bttv video_buf btcx_risc eeprom snd_seq_oss snd_seq
_midi_event snd_seq snd_pcm_oss snd_mixer_oss snd_bt87x snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd_page_allo
c snd_mpu401_uart snd_rawmidi snd_seq_device snd 8139too forcedeth sg
Jul 24 15:37:39 coyote kernel: CPU:    0
Jul 24 15:37:39 coyote kernel: EIP:    0060:[<c0164376>]    Not tainted
Jul 24 21:25:59 coyote syslogd 1.4.1: restart.
-----------------------
Previously, there was nothing in the logs at all, so this
trail is a first.

Is there anything of interest here?  What else can I supply
that might help aim a finger at something besides the operator,
who wasn't even in the room at the time :)

-- 
Cheers, Gene
There are 4 boxes to be used in defense of liberty. 
Soap, ballot, jury, and ammo.
Please use in that order, starting now.  -Ed Howdershelt, Author
Additions to this message made by Gene Heskett are Copyright 2004, 
Maurice E. Heskett, all rights reserved.
