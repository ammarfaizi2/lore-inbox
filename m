Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135965AbREGBdI>; Sun, 6 May 2001 21:33:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135968AbREGBc6>; Sun, 6 May 2001 21:32:58 -0400
Received: from cr481834-a.ktchnr1.on.wave.home.com ([24.102.89.11]:11763 "HELO
	scotch.homeip.net") by vger.kernel.org with SMTP id <S135965AbREGBcs>;
	Sun, 6 May 2001 21:32:48 -0400
Date: Sun, 6 May 2001 21:32:28 -0400 (EDT)
From: God <atm@sdk.ca>
To: linux-kernel@vger.kernel.org
Subject: kernelnotes.org down / loop device results
Message-ID: <Pine.LNX.4.21.0105061522440.23642-100000@scotch.homeip.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hiya,

Just a few quickies ....

One, is kernelnotes.org down ?  .. I can't get to it (times out), I've
tried from a few boxes on different networks just incase it was on my end
.. (since I've compiled ecn in, MANY things don't seem to be working
... even the best search engine in the world .. dogpile, doesn't work
.. grr) .. enough of that.

Loop device:

I know there was a thread on here awhile ago about problems with it or
something ...  dyndns shut down the domain I was using to subscribe here
(penguinpowered.com) so I didn't catch the whole thread.... 

Problems (Are they related or am I on crack here?):

If I make an image of a floppy:

# dd if=/dev/fd0 of=32xCDRomBootDisk.bin bs=32k

then try to mount the image (no errors on the floppy):

# mount 32xCDRomBootDisk.bin /mnt/nt -t msdos -o loop=/dev/loop3

Mount hangs ...  what do I mean by that? .. well:

<in another tty>

# killall -9 mount
# killall -9 mount
# ps -eaux |grep mount
root      9719  0.0  1.3  6024 2152 ?        S    Apr30   0:00 /sbin/mount.smbfs
root     12245  0.0  0.9  1472 1472 ?        DL   14:41   0:00 mount /mnt/Mount_this_you_whore
root     12342  0.0  0.9  1472 1472 pts/36   DL 14:50   0:00 mount 32xCDRomBoo
root     12604  0.0  0.3  1520  608 pts/4S    15:30     0:00 grep mount PWD=/m


The two mouts are STILL running! ... and acutally, I started writting this
email eairly this morning ... yet even now, at almost 10pm EST, those
procs are still there.  Had it not been for the fact that I do most things
under screen, those two ttys would be unusable.


Some points to think about:

I may have made an incorrect assumption that one can even do what I'm
trying.  It works for making boot disks, so I assumed the reverse would be
true.   I know there was a thread on here about the loop device, but
again, I didn't follow it all, and even now as I check again to see if
kernelnotes,org is up, it still isn't.   SOOOOOOO .... am I goin crazy
here, or on crack? ...

box:
Red Nut 7.1,
Linux scotch 2.4.2 #2 SMP Thu Mar 1 18:08:51 EST 2001 i686 unknown

loop device is compiled as a module (and loaded).  I have about 200
floppys I would like to turn into images and burn onto one cd, which is
why I even tried.



