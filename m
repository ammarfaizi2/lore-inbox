Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267354AbTAGJlL>; Tue, 7 Jan 2003 04:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267358AbTAGJlL>; Tue, 7 Jan 2003 04:41:11 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:16900 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S267354AbTAGJlK>; Tue, 7 Jan 2003 04:41:10 -0500
Message-ID: <3E1AA2DF.E6991506@aitel.hist.no>
Date: Tue, 07 Jan 2003 10:50:23 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.5.54 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Kaleb Pederson <kibab@icehouse.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: windows=stable, linux=reboots 5 times/50 minutes
References: <LDEEIFJOHNKAPECELHOAAEJICCAA.kibab@icehouse.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kaleb Pederson wrote:
> 
> Alan Cox Wrote:
> > Start with the easy bits. Check the CPU fans, run memtest86, reseat all
> the cards
> > ... Also if your windows test wasnt SMP its not going to have tested much.
> 
> I just reseated everything on my system and it still keeps rebooting.  I
> have two nice fans for my processors using thermal compound and both are
> working correctly.  I forgot to mention that I ran through several
> iterations of memtest86 a few weeks ago and it found no problems.  I also
> re-ran it two days ago and it again passed several iterations without errors
> at which point I started looking to other things.  LKML is my last resort.

Are you running the _same_ version of linux that worked with the drive
that broke?
If not, try an older kernel.  The current one could be buggy in some
way.

Assuming that the new drive is the only difference, try using hdparm
and deliberately run a slower transfer mode than what you do now.
Or try turning off DMA.  The new drive could have different
timing requirements, and fail to work with a linux setup "tweaked"
for the other drive.  Windows don't necessarily use the same
transfer speed as linux and could be fine because of that.

Also, consider mounting /var synchronous.  This is slow, a 
debugging-only thing, but you stand a better chance of logging
the failure in /var/log/syslog.  (You have looked there
already?)  Any kind of error message will help us
find out whats wrong.  You may also want to try
booting without X to see if you get any oops/panic/bug
messages on the console when it crashes.


Helge Hafting
