Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274036AbRISLR3>; Wed, 19 Sep 2001 07:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274031AbRISLRT>; Wed, 19 Sep 2001 07:17:19 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:57351 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S274036AbRISLRB>; Wed, 19 Sep 2001 07:17:01 -0400
Message-ID: <3BA87E9E.215A1E3@idb.hist.no>
Date: Wed, 19 Sep 2001 13:16:46 +0200
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.4.10-pre10 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.10-pre12 is impressive
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.10-pre12 is impressive compared to pre10.

128M, 300MHz and a 3G ide-drive is usually enough for office work 
and compiling, but there are times I use some swap.  Reading the 
impressive reviews for pre11,
I decided to put it through a worst-case test.  Well, worst-case
for my kind of use anyway. 

I started staroffice with 40 documents.  This is slow and tends to
ruin interactive performance for a long time.  I used
to get lots of swapping, and plenty of swapping in long after
finishing staroffice.  

This time I also started a kernel compile, a updatedb run, and a
rgrep in /usr/src while waiting for staroffice to load.
I also had netscape up.
It came up, with only 10M total in swap.  20-30M just for starting
staroffice used to be the case.  And interactive performance
was fine, even with all that going on. 

The normal under such circumstances is several seconds just to 
raise a xterm, with typing oocationally lagging and delays when 
pressing enter.  But only commands needing disk-io got delayed and 
only slightly.  Typing and window moving were just like
a normal X session with nothing else going on.

The rgrep seemed to
proceed at great speed, the compile ran very slowly.  I guess it
lost the bandwidth competition.

Then I went away for lunch, and when I came back there were
no more than 20M in swap.  Everything had finished except the
compile - it was still hampered by netscape doing one of its
100% cpu bugs.  

Staroffice and netscape _still_ performed fine, all that
io didn't destroy their working sets!  I quit staroffice,
the compile finished, and swap usage dropped do 15M.  

The machine have recovered perfectly - there seems to be none of
that long-term sluggishness that used to happen after 
updatedb or after swapping 20M.  The machine used to
recover to a usable state before too, but never this good.
Before, I had to reboot or use it a few hours.

Good work!  There's noticeable improvement for desktop use!

Helge Hafting
