Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278001AbRJODfJ>; Sun, 14 Oct 2001 23:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278002AbRJODfA>; Sun, 14 Oct 2001 23:35:00 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:14326
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S278001AbRJODet>; Sun, 14 Oct 2001 23:34:49 -0400
Date: Sun, 14 Oct 2001 20:35:15 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Kip Macy <kmacy@netapp.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, cyrus@linuxmail.org
Subject: Re: Large Storage Devices in Linux.....Kernel level support.....
Message-ID: <20011014203515.D28547@mikef-linux.matchmail.com>
Mail-Followup-To: Kip Macy <kmacy@netapp.com>,
	linux-kernel <linux-kernel@vger.kernel.org>, cyrus@linuxmail.org
In-Reply-To: <Pine.GSO.4.10.10110141947400.18511-100000@orbit-fe.eng.netapp.com> <Pine.GSO.4.10.10110142007130.18511-100000@orbit-fe.eng.netapp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.10.10110142007130.18511-100000@orbit-fe.eng.netapp.com>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > On Sun, 14 Oct 2001, Mike Fedyk wrote:
> > 
> > > On Sun, Oct 14, 2001 at 05:24:59PM +1000, Cyrus wrote:
> > > > hi all,
> > > > 
> > > > i've got a setup of 2 hard drives (30GB & 40GB) with an Asus a7m266 mobo 
> > > > with a VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06).
> > > > 
> > > > 30GB= fujitsu, 40GB= IBM (both are 7200rpm
> > > > 
> > > > i've got my cdrw on /dev/hdc, 30GB=/dev/hda, and 40GB=/dev/hdb...
> > > > 
> > > > all works alright for a while, but when i keep my computer turned on for 
> > > > a couple of days and then reboot. bios sometimes tells me that smart 
> > > > array (or something) failed with my primary master (30GB) and i should 
> > > > back-up soon.. next reboot it tells me that pri-master fails.. it's 
> > > > doing this quite regularly and i don't know how to stop it. i'm running 
> > > 
> > > Turn off "S.M.A.R.T." in your bios...  Probably under the advanced bios
> > > config menu.
> > > 
> > > I know that Compaq has a SMART RAID controller, but does anyone know what
> > > this does?  (I've seen it on old p2 MBs and they didn't have raid...)
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > Please read the FAQ at  http://www.tux.org/lkml/
> > > 
> > 

> On Sun, 14 Oct 2001, Kip Macy wrote:
> 
> > S.M.A.R.T. and SMART are not the same thing. A quick google search got me
> > to this page:
> >  
> > <http://www.belarc.com/Images/blank.gif>
> > [About S.M.A.R.T.]
> > S.M.A.R.T. (Self-Monitoring Analysis and Reporting Technology) is a
> > diagnostic method originally developed by I.B.M. for their mainframe
> > drives to give advanced warning of drive failures. Large mainframe data
> > centers wanted to know in advance if a hard disk drive was going to fail,
> > because this gave them the opportunity to take steps to protect their
> > data. Later Compaq announced a diagnostic which operated with a number of
> > different disk drive manufacturers. These products were submitted to the
> > ATA/IDE standards committees and the resulting standard was named
> > S.M.A.R.T. Today all major hard disk drive manufacturers support
> > S.M.A.R.T., including IBM, Western Digital, Quantum, Seagate, and Fujitsu.
> > etc.

On Sun, Oct 14, 2001 at 08:08:35PM -0700, Kip Macy wrote:
> On second thought they most likely are the same thing. And, just in case
> it is not obvious, it is telling you to back up your data because it
> thinks the drive is about to fail.
> 
> 				-Kip

Yes, some BIOSes have "S.M.A.R.T." and some "SMART".

Thanks for the history lesson and research...

Cyrus, replace that drive, or at least test it with badblocks.  One thing
that I've noticed about badblocks is that there are times when part of a
drive is about to go bad, but doesn't give an error message.  It just takes
longer, and uses several reads but finally completes successfully.  The
only time I've noticed this was on
a drive where badblocks *did* find an error, but there were parts that took
much too long to read, and probably should've been marked faulty.  (This was
with badblocks in e2fsprogs 1.18).  Though, taking a long time to read could
be caused by other users on a multi-user system, but if there is a way to
detect if a drive is retrying to read, that would be a good way to check...

BTW Cyrus, your mail bounced, so if you take the time to read the archive,
you'll know...

----- The following addresses had permanent fatal errors -----  
<cyrus@linuxmail.org>                                               
    (reason: 521 sorry, user inactive)         
       
Mike
