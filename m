Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130242AbRCBBRe>; Thu, 1 Mar 2001 20:17:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130243AbRCBBRX>; Thu, 1 Mar 2001 20:17:23 -0500
Received: from tomts5.bellnexxia.net ([209.226.175.25]:54738 "EHLO
	tomts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S130242AbRCBBRL>; Thu, 1 Mar 2001 20:17:11 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: [BUG] 2.4.x system Freezes
Date: Thu, 1 Mar 2001 20:17:10 -0500
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01030120171000.01156@oscar>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A couple of weeks age I reported a couple of problems.  The first two turned 
out not to be serious but the third, where the system freezes, has not 
stopped happening.  Several other people have reported similar problems...

Typically my system will die while kde2.1 is starting (about 1 time in 4) or 
shortly after I start a caching news server (newsplex), another common 
trigger is dpkg, when reading its database just before it starts up unpack 
packages.   If it gets thru these hurdles it may last up to three days - most 
of the time I am luckly to get one...  

Once it hangs its really hung.  A ups cannot trigger a shutdown, sysrq is 
dead, the num lock indicator will not toggle.  Trying to use shift, alt or 
control + shiftlock does not result in any data on a serial console, nor are 
there any unexpected messages there.   Also pinging from the box running the 
serial console gets no answers during a stall.   The software watchdog does 
not get triggered either.

I would love NOT to have to be such close friends with the reset button.  
(reiserfs has been very usefully with all the crashes...)

I have install kdb on the off chance that I can hit PAUSE fast enought to it 
to do a bt command one time it freezes.  What else can be done to debug this? 
Could this be related to the memory problems reported reciently?

TIA
Ed Tomlinson <tomlins@cam.org>

Current kernel is 2.4.2-ac7 + kdb 1.8
K6-III 400 via mp3 128M
mga400max AGP (x1) with xfree 4.02 driver
SB16 ISA, nonpnp using alsa 5.10b drivers
USR ISA modem, nonpnp
Tuplip based card connected to an small internal 100BaseT network
VIA Rhine based cards connected to a 10BaseT xDSL modem
no scsi
hda=13G hdb=4.3G (both quantum, UDMA2) hdc=CDROM hdd=tape (both ATAPI PIO)
usb optical MS mouse
My root filesystem is on reiserfs and reiserfsck tells me its fine when 
booted from a recovery partition.

On Feb 6 Ed Tomlinson wrote:
>System hangs.  This box has been quite stable.  The hangs started 
>appearing around 2.4.1 or so.  I very much doubt they are heat releated.  I 
>have had heat problems in the past an have moved the kit into a much better 
>case.  The old symptoms (ide tape problems) have gone and not returned even 
>on the hotest summer day...  Next time this happens I will try to telnet or 
>ssh into box to see if anything is active, I will also setup a UPS on the 
>box and see it that can shut it down.  Its interesting that the software 
>watchdog does not get triggered.
