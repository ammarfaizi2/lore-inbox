Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315259AbSHKRtL>; Sun, 11 Aug 2002 13:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315805AbSHKRtL>; Sun, 11 Aug 2002 13:49:11 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13326 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315259AbSHKRtK>;
	Sun, 11 Aug 2002 13:49:10 -0400
Date: Sun, 11 Aug 2002 18:52:52 +0100
From: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
To: linux-kernel@vger.kernel.org
Cc: axp-list@redhat.com, debian-alpha@lists.debian.org
Subject: 2.4.19 eat my disc (contents)
Message-ID: <20020811175252.GB755@gallifrey>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.4.18 (i686)
X-Uptime: 18:36:47 up  7:23,  1 user,  load average: 2.19, 2.50, 2.49
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I've just lost the contents of my disc on my Alpha to 2.4.19 - be
careful! (luckily there wasn't anything important on it...or at least if
there was I can't remember what....)

Some details:
2.4.19 straight
Alpha 21164A on LX164 board
Compiled for LX164 architecture
Hard drive is an IBM 34GB Deathstar connected to the on board CMD646
controller.

It has been running Linux/Debian happily for ages; booted into 2.4.17,
compiled 2.4.19, booted into that and saw two problems;
  1) RTL8139 network card was identified but would not connect.  I got
	giant packet errors - it spitted out a 32 bit identifier which looked
	like it might have got some ASCII where some value should have lived.
	(It is an RTL8139 prior to the -c)

	2) I tried to go into the directory which I'd built the kernel in and
	found it didn't actually agree that it was a directory; but thought it
	was a file of many GB with odd permissions.  I unmounted the partition
	and fsck'd - lots of errors; most complaining of invalid blocks.
	debugfs seemed to indicate that lots of things in the inode had been
	cleared to -1 (size, uid, gid, pretty much everything).

	3) I hit reset and the AlphaBIOS came to the conclusion there was no
	OS and it looks like the partition table has gone to the great block
	in the sky.

All tools were from Debian/unstable; updated immediatly prior to the 
kernel build.

I'd give you a log and .config if it weren't for the fact that it has
just wiped itself from the disc. hdparm looked OK from the brief look;
I think it got the drive size right.  I had seen some DMA negotiation
alike errors go past during the boot.

Oh well - time to try the Debian/Woody install process on Alpha....

Dave

 ---------------- Have a happy GNU millennium! ----------------------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM, SPARC and HP-PA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
