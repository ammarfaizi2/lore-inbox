Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281457AbRKTW7L>; Tue, 20 Nov 2001 17:59:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281461AbRKTW7B>; Tue, 20 Nov 2001 17:59:01 -0500
Received: from unknown.Level3.net ([63.210.233.154]:16394 "EHLO
	cinshrexc01.shermfin.com") by vger.kernel.org with ESMTP
	id <S281457AbRKTW6q>; Tue, 20 Nov 2001 17:58:46 -0500
Message-ID: <35F52ABC3317D511A55300D0B73EB8056FCC3D@cinshrexc01.shermfin.com>
From: "Rechenberg, Andrew" <ARechenberg@shermanfinancialgroup.com>
To: "'linux-mm@kvack.org'" <linux-mm@kvack.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: "'marcelo@conectiva.com.br'" <marcelo@conectiva.com.br>
Subject: RE: kupdated high load with heavy disk I/O
Date: Tue, 20 Nov 2001 17:58:44 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have to find time to down the box because it's production, but as soon as
I do I'll post the numbers here.

Thanks for your help.	

Regards,
Andy.


> Could you please guys try to reproduce the problem with kernel profiling
> turned on and send us the output of readprofile? 

> This way we can know which function is using more CPU time, thus we can
> identify the problem. 


On Wed, 14 Nov 2001, John McCutchan wrote:

> Hi,
> 
> I also have the exact same behaviour when running mkisofs. During the 
> creation of the ISO the interactive feel is sluggish and after mkisofs
> is complete the box is sluggish and appears to lock up. During
> this sluggish period there is alot of disk activity. This is under
> 2.4.14
> 
> John
> On Wed, Nov 14, 2001 at 06:01:23PM -0500, Rechenberg, Andrew wrote:
> > Hello,
> > 
> > I have read some previous threads about kupdated consuming 99% of CPU
under
> > intense disk I/O in kernel 2.4.x on the archives of linux-kernel (April
> > 2001), and some issues about I/O problems on linux-mm, but have yet to
find
> > any suggestions or fixes.  I am currently experiencing the same issue
and
> > was wondering if anyone has any thoughts or suggestions on the issue.  I
am
> > not subscribed to the list so would you please CC: me directly on any
> > responses?  I can also check out the archives at theaimsgroup.com if a
CC:
> > would not be appropriate.  Thank you.
> > 
> > The issue that I am having is that when there is a heavy amount a disk
I/O,
> > the box becomes slightly unresponsive and kupdated is using 99.9% in
'top.'
> > Sometimes the box appears to totally lock up.  If one waits several
seconds
> > to a couple of minutes the system appears to 'unlock' and runs
sluggishly
> > for a while.  This cycle will repeat itself until the I/O subsides.  The
> > memory usage goes up to the full capacity of the box and then about 10MB
of
> > swap is used while this problem is occurring.  Memory and swap does not
get
> > relinquished afer the incident.
> > 
> > The issue appears in kernel 2.4.14 compiled directly from source from
> > kernel.org with no patches.  These problems manifest themselves with
only
> > one user doing heavy disk I/O.  The normal user load on the box can run
> > between 350-450 users so this behavior would be unacceptable because the
> > application that is being run is interactive.  With 450 users, and the
same
> > process running on a 2.2.20 kernel the performance of the box is great,
with
> > only a very slightly noticeable slow down.
> > 
> > I am running the Informix database UniVerse version 9.6.2.4 on a 4
processor
> > 700MHz Xeon Dell PowerEdge 6400.  The disk subsystem is controlled by a
PERC
> > 2/DC RAID card with 128MB on-board cache (megaraid driver compiled
directly
> > in to the kernel).  Data array is on 5 36GB 10K Ultra160 disks in a
RAID5
> > configuration.  The box has 4GB RAM, but is only using 2GB due to the
move
> > back to the 2.2 kernel.  The only kernel paramters that have been
modified
> > are in /proc/sys/kernel/sem.  All filesystems are ext2.
> > 
> > If you need any more detailed info, please let me know.  Any help on
this
> > problem would be immensely appreciated.  Thank you in advance.
> > 
> > Regards,
> > Andrew Rechenberg
> > Network Team, Sherman Financial Group
> > arechenberg@shermanfinancialgroup.com
> > 
> > --
> > To unsubscribe, send a message with 'unsubscribe linux-mm' in
> > the body to majordomo@kvack.org.  For more info on Linux MM,
> > see: http://www.linux-mm.org/
> > 
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo@kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/
> 

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/
