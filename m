Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130211AbRCHWza>; Thu, 8 Mar 2001 17:55:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130238AbRCHWzU>; Thu, 8 Mar 2001 17:55:20 -0500
Received: from munk.apl.washington.edu ([128.95.96.184]:46608 "EHLO
	munk.apl.washington.edu") by vger.kernel.org with ESMTP
	id <S130211AbRCHWzN>; Thu, 8 Mar 2001 17:55:13 -0500
Date: Thu, 8 Mar 2001 14:50:46 -0800 (PST)
From: Brian Dushaw <dushaw@munk.apl.washington.edu>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Linux kernel - and regular sync'ing?
In-Reply-To: <20010308223319.A25679@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.30.0103081439400.18253-100000@munk.apl.washington.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the interests of finishing off this thread:
  Thanks to all who replied to my question on how to get a notebook
disk to spin down.  The clear consensus is:
- the problem was probably caused by the cron daemon (I have some doubts
    about this, but never mind)
- the problem is fixed by adding the "noatime" option when mounting the
    root filesystem (I use /etc/fstab to do this)
- there appears to be no harm in not updating the inode access times with
    this option.
- I am now using "hdparm -S 6 /dev/hda" to great effect; placed in my
    /etc/rc.d/rc.local file.
- Naturally as soon as I learned all this from this e-mail thread, I found
    the appropriate paragraph in an out-of-the-way spot on the "Linux on
    Notebooks" pages (this must be one of Murphy's Laws... :) )
- I've added this discussion to my notebook web page in the interest of
    spreading this gem of information.

B.D.


On Thu, 8 Mar 2001, Russell King wrote:

> On Thu, Mar 08, 2001 at 12:09:51PM +0000, Alan Cox wrote:
> > To quote the linux on palmax page
> >
> >    For startup my /etc/rc.d/rc.local contains the following lines.
> > mount -o remount,rw,noatime /
> > /sbin/hdparm -S 15 /dev/hda
>
> Or else place "noatime" in /etc/fstab, which is probably the better
> place for it.
>
> --
> Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
>              http://www.arm.linux.org.uk/personal/aboutme.html
>

-- 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Brian Dushaw
Applied Physics Laboratory
University of Washington
1013 N.E. 40th Street
Seattle, WA  98105-6698
(206) 685-4198   (206) 543-1300
(206) 543-6785 (fax)
dushaw@apl.washington.edu

Web Page:  http://staff.washington.edu/dushaw/index.html

