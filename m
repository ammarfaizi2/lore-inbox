Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268094AbRHAUhB>; Wed, 1 Aug 2001 16:37:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268140AbRHAUgv>; Wed, 1 Aug 2001 16:36:51 -0400
Received: from vger.timpanogas.org ([207.109.151.240]:1549 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S268094AbRHAUgj>; Wed, 1 Aug 2001 16:36:39 -0400
Date: Wed, 1 Aug 2001 14:39:35 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Scott Ransom <ransom@cfa.harvard.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 3ware Escalade problems
Message-ID: <20010801143935.A21157@vger.timpanogas.org>
In-Reply-To: <3B684714.32F6A02F@cfa.harvard.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3B684714.32F6A02F@cfa.harvard.edu>; from ransom@cfa.harvard.edu on Wed, Aug 01, 2001 at 02:14:44PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2001 at 02:14:44PM -0400, Scott Ransom wrote:


I am also using 8 way escalade adapters, and am seeing a host of problems.
The first and foremore is that the gendisk head in 2.4.X is not being 
initialized properly in the driver.  I have reported these problems to
3-ware, and they are attmepting to get the engineer who owns the drivers
on the line with us.  The problems you are seeing are probably related 
to the same bugs.  This driver requires some rework to get it compliant
with 2.4.X.  At present, several programs fail with it since is is not 
setting up the gendisk head properly.  I do not know if your
problem is related, but this one will get added to the list when I speak 
with this person.

Jeff


> Hello,
> 
> After months of running a fileserver with an 8 port 3ware escalade card
> (kernels 2.4.[3457] using reiserfs and software RAID5) I started getting
> problems this weekend.
> 
> Over the last three days, when I try to access the drives, after a
> couple minutes I get a drive failure (I even heard a "yelp" from the
> drive during one of them...).  But the "failure" has happened to 3 of
> the 8 drives over 3 days -- so unless there is a hardware problem that
> is killing my drives I find it hard to believe that 3 drives really and
> truly failed....
> 
> Here is a sample from my syslog of a failure:
> 
> 3w-xxxx: tw_interrupt(): Bad response, status = 0xc7, flags = 0x51, unit
> = 0x1.
> 3w-xxxx: tw_scsi_eh_reset(): Reset succeeded for card 1.
> 3w-xxxx: tw_interrupt(): Bad response, status = 0xc7, flags = 0x51, unit
> = 0x1.
> scsi: device set offline - not ready or command retry failed after host
> reset: host 1 channel 0 id 1 lun 0
> SCSI disk error : host 1 channel 0 id 1 lun 0 return code = 80000
> I/O error: dev 08:11, sector 158441712
> 
> I've noticed several "issues" with the 3ware cards in the archives.  Has
> anyone seen something like this?
> 
> Scott
> 
> PS:  I'm currently running 2.4.7 with the lm-sensors/i2c patches.
> 
> -- 
> Scott M. Ransom                   Address:  Harvard-Smithsonian CfA
> Phone:  (617) 496-7908                      60 Garden St.  MS 10 
> email:  ransom@cfa.harvard.edu              Cambridge, MA  02138
> GPG Fingerprint: 06A9 9553 78BE 16DB 407B  FFCA 9BFA B6FF FFD3 2989
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
