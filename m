Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131363AbRCSGWY>; Mon, 19 Mar 2001 01:22:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131365AbRCSGWO>; Mon, 19 Mar 2001 01:22:14 -0500
Received: from mpdr0.chicago.il.ameritech.net ([206.141.239.142]:57739 "EHLO
	mailhost.chi.ameritech.net") by vger.kernel.org with ESMTP
	id <S131363AbRCSGWD>; Mon, 19 Mar 2001 01:22:03 -0500
Message-ID: <3AB5A53F.F8B0373B@ameritech.net>
Date: Mon, 19 Mar 2001 00:20:47 -0600
From: watermodem <aquamodem@ameritech.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Jiffy question and sound.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With the 2.4.0 kernel the loops_per_sec field was replaced (for i386)
with current_cpu_data.loops_per_jiffy.

So... since I am using the ALSA drivers that Mandrake supplied, for the
2.4.x series of kernels I replaced the equated #define with


#define LOOPS_PER_SEC current_cpu_data.loops_per_jiffy * 100

This seems to build modules that work for 2.4.0.   However, if you play
many songs then do some heavy disk I/0 after awhile the songs start
sounding like a hellicoptor is hovering right next to the speakers.   
This wasn't too bad as it usually took about 30 to 40 mins to go
south.   

Now compiling the same  ALSA modules with 2.4.2 this problem happens
much quicker and you don't need any other activity.  In fact it is hard
to play more than half a song.  (MP3)
It doesn't matter if what set of music players or tools I use the
problem is quite visible.

When I boot back to the original 2.2.x kernel everything is perfect.   

So I guess I have a few questions here.
 1)   Is a jiffy 100th of a second or is it smaller  (so my loop count
is starving things.) (10ms) ?
 2)   Why is it so much worse in 2.4.2 than 2.4.0?
 3)   Any other "gotch's" that are important to watch for when moving
2.2.x drivers to 2.4.x?

Thanks....

Watermodem
