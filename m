Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287817AbSCaWke>; Sun, 31 Mar 2002 17:40:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287862AbSCaWkZ>; Sun, 31 Mar 2002 17:40:25 -0500
Received: from mathsun1.math.utk.edu ([160.36.50.30]:23310 "HELO
	mathsun1.math.utk.edu") by vger.kernel.org with SMTP
	id <S287817AbSCaWkI>; Sun, 31 Mar 2002 17:40:08 -0500
Date: Sun, 31 Mar 2002 17:40:03 -0500
From: Geoffrey Hoff <ghoff@math.utk.edu>
To: Andre Hedrick <andre@linux-ide.org>
Cc: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: 2.4.19-pre3 udma ide hang with heavy disk activity
Message-ID: <20020331224003.GA17534@MATHSUN1.MATH.UTK.EDU>
In-Reply-To: <20020331203726.GB16709@MATHSUN1.MATH.UTK.EDU> <Pine.LNX.4.10.10203311335400.10681-300000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just took a look at these two patches and they are already
incorporated in linux-2.4.19-pre5 which gives me the same results as
2.4.19-pre3.  Do you have any other suggestions?

Thanks to everyone who works on the IDE subsystem.  I'm sure someone
will point me to a solution in no time flat.

* Andre Hedrick <andre@linux-ide.org> [020331 16:38]:
> 
> Please apply these which have been submitted to Alan Cox but originate
> from Vojtech.
> 
> Cheers,
> 
> Andre Hedrick
> LAD Storage Consulting Group
> 
> On Sun, 31 Mar 2002, Geoffrey Hoff wrote:
> 
> > On kernels 2.4.19-pre3 and later I get a disk hang any time I generate
> > heavy disk activity.  My test is a quick script that untars 2.4.0 and
> > then applys patch up to 2.4.19 and repeats.  With kernels 19-pre3
> > through 19-pre5, I can usually get through about the third patch and then
> > my hard drive activity led goes solid and I can no longer access any
> > disk.  This is happening specifically with a VIA controller (vt82c596b
> > rev 22) with a Maxtor 91536U6.  Attached are part of my dmesg,
> > proc/ide/via, hdinfo of /dev/hda and part of my .config.  If I use
> > hdparm to set the drive to mdma2 in 19-pre3 I never see any problems.  It
> > only happens in any udma mode.  I compiled 19-pre3 with the via
> > driver disabled, but the problem continues.  I also tried 19-pre5 as I
> > looked and saw that it contains more ide updates, but I get the same
> > results.
> > 
> > In 19-pre2 and previous kernels, If the drive is running in UDMA66, I
> > ocassionally get checksum errors and retries so I usually on boot put
> > the drive in UDMA33 mode.  I have never seen any error of any kind in
> > this mode.  I have tried modes udma0, 2, and 4 on 2.4.19-pre3 and they
> > all eventually hang.  When this hang occurs, I get no kernel messages at
> > all.  I set dmesg to level 8 so I should see any message on the console.
> > If it weren't for ext3 and reiserfs, I would be very tired of fscks by
> > now.  If there is anything that I can try to help narrow this problem
> > down, please let me know.
