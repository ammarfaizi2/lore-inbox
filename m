Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265724AbUGMSVN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265724AbUGMSVN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 14:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265725AbUGMSVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 14:21:13 -0400
Received: from out014pub.verizon.net ([206.46.170.46]:58029 "EHLO
	out014.verizon.net") by vger.kernel.org with ESMTP id S265724AbUGMSVI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 14:21:08 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Organization: Organization: undetectable
To: linux-kernel@vger.kernel.org
Subject: Bus error?
Date: Tue, 13 Jul 2004 14:21:06 -0400
User-Agent: KMail/1.6
Cc: kde@mail.kde.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200407131421.06935.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out014.verizon.net from [151.205.57.208] at Tue, 13 Jul 2004 13:21:07 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings;

Cross-posted to the kde list and to lkml, answer either.

Running FC1, but with 2.6.x kernels and utils required (I think)

I first built, using konstruct, a kde3.2.3 install that worked great
for a couple of months.

In the meantime, I've been following the Linus and Andrew kernels,
and currently have 2.6.8-rc1 doing the chores here.

Eventually of course, since I like to bleed, I ran a cvs up -dP in
that konstruct working directory, and rebuilt it again, this time
totally destroying the 3.2.3 install so I'm back to running kde 3.2.

Here is the error I am now getting, from a fresh konstruct tree and
no cvs updateing done.  So it should be the same as before as I don't
think the compiler has been touched by any of the yum updates.

Using make install in the konstruct/meta/kde directory as the build agent.
---------
make[8]: Leaving directory `/usr/src/konstruct/libs/qt-x11-free/work/qt-x11-free-3.2.3/tools/designer/uilib'
cd designer && make -f Makefile
make[8]: Entering directory `/usr/src/konstruct/libs/qt-x11-free/work/qt-x11-free-3.2.3/tools/designer/designer'
/usr/src/konstruct/libs/qt-x11-free/work/qt-x11-free-3.2.3/bin/uic -L /usr/src/konstruct/libs/qt-x11-free/work/qt-x11-free-3.2.3/plugins listboxeditor.ui -o listboxeditor.h
make[8]: *** [listboxeditor.h] Bus error
make[8]: Leaving directory `/usr/src/konstruct/libs/qt-x11-free/work/qt-x11-free-3.2.3/tools/designer/designer'
make[7]: *** [sub-designer] Error 2
make[7]: Leaving directory `/usr/src/konstruct/libs/qt-x11-free/work/qt-x11-free-3.2.3/tools/designer'
make[6]: *** [sub-designer] Error 2
make[6]: Leaving directory `/usr/src/konstruct/libs/qt-x11-free/work/qt-x11-free-3.2.3/tools'
make[5]: *** [sub-tools] Error 2
make[5]: Leaving directory `/usr/src/konstruct/libs/qt-x11-free/work/qt-x11-free-3.2.3'
make[4]: *** [build-work/qt-x11-free-3.2.3/Makefile] Error 2
make[4]: Leaving directory `/usr/src/konstruct/libs/qt-x11-free'
make[3]: *** [dep-../../libs/qt-x11-free] Error 2
make[3]: Leaving directory `/usr/src/konstruct/libs/arts'
make[2]: *** [dep-../../libs/arts] Error 2
make[2]: Leaving directory `/usr/src/konstruct/kde/kdelibs'
make[1]: *** [dep-../../kde/kdelibs] Error 2
make[1]: Leaving directory `/usr/src/konstruct/kde/kdebase'
make: *** [dep-../../kde/kdebase] Error 2
[root@coyote kde]#

Now, theoreticly the only hardware change is that a cranky,
cold blooded old pny built nvidia gforce2 mx200 32 meg video
card finally puked all over itself and got replaced by an
Xtacy branded ati 9200 SE w/128 megs of dram on it.

I've built about 15 kernels now since buying this new card,
without errors.  I rebuilt everything from 2.6.7 base plus
all the mm's getting the video card drivers setup, some of
them 4 or 5 times as I fumbled around.

So what is this bus error generally caused by?

Both video cards were agp slot cards FWIW.

I can reboot to as early as 2.6.7 and still get this exact error.
Earlier I'd have to rebuild with the new video card in them.

-- 
Cheers, Gene
There are 4 boxes to be used in defense of liberty. 
Soap, ballot, jury, and ammo.
Please use in that order, starting now.  -Ed Howdershelt, Author
Additions to this message made by Gene Heskett are Copyright 2004, 
Maurice E. Heskett, all rights reserved.
