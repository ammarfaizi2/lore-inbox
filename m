Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267972AbRHASvp>; Wed, 1 Aug 2001 14:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267950AbRHASv0>; Wed, 1 Aug 2001 14:51:26 -0400
Received: from presto.harvard.edu ([131.142.9.143]:63382 "HELO
	presto.harvard.edu") by vger.kernel.org with SMTP
	id <S267940AbRHASvO>; Wed, 1 Aug 2001 14:51:14 -0400
Message-ID: <3B684FAA.DB50B3FA@cfa.harvard.edu>
Date: Wed, 01 Aug 2001 14:51:22 -0400
From: Scott Ransom <ransom@cfa.harvard.edu>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Adam Radford <aradford@3ware.com>
CC: linux-kernel@vger.kernel.org, Scott Ransom <ransom@cfa.harvard.edu>
Subject: Re: 3ware Escalade problems
In-Reply-To: <53B208BD9A7FD311881A009027B6BBFB9EADC7@siamese>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

The drives I am using are Maxtor 81.9G drives (model 98196H8).

I refuse to believe that 3 different disks could fail during the span of
3 days without _something_ causing it -- especially since things have
been working great since February or so.  And if I hadn't heard at least
one of the drives scream in agony, I wouldn't have believed that any of
them were really failing...  Is it possible that a bad drive could
affect other drives in some way?

Here is the first failure:

Jul 27 23:24:53 munin kernel: 3w-xxxx: tw_interrupt(): Bad response,
status = 0xc7, flags = 0x1b, unit = 0x3.
Jul 27 23:24:53 munin last message repeated 6 times
Jul 27 23:25:08 munin kernel: 3w-xxxx: tw_poll_status(): Flag 0x40000
not found.
Jul 27 23:25:08 munin kernel: 3w-xxxx: tw_aen_drain_queue(): No
attention interrupt for card 1
Jul 27 23:25:08 munin kernel: 3w-xxxx: tw_reset_sequence(): No attention
interrupt for card 1.
Jul 27 23:25:24 munin kernel: 3w-xxxx: tw_poll_status(): Flag 0x40000
not found.
Jul 27 23:25:24 munin kernel: 3w-xxxx: tw_aen_drain_queue(): No
attention interrupt for card 1
Jul 27 23:25:24 munin kernel: 3w-xxxx: tw_reset_sequence(): No attention
interrupt for card 1.
Jul 27 23:25:37 munin kernel: 3w-xxxx: tw_scsi_eh_reset(): Reset
succeeded for card 1.
Jul 27 23:25:47 munin kernel: 3w-xxxx: tw_interrupt(): Bad response,
status = 0xcf, flags = 0x0, unit = 0x3.
Jul 27 23:25:47 munin kernel: scsi: device set offline - not ready or
command retry failed after host reset: host 1 channel 0 id 3 lun 0
Jul 27 23:25:47 munin kernel: 3w-xxxx: tw_interrupt(): Bad response,
status = 0xcf, flags = 0x0, unit = 0x3.
Jul 27 23:25:47 munin kernel: scsi: device set offline - not ready or
command retry failed after host reset: host 1 channel 0 id 3 lun 0
Jul 27 23:25:47 munin kernel: 3w-xxxx: tw_interrupt(): Bad response,
status = 0xcf, flags = 0x0, unit = 0x3.
Jul 27 23:25:47 munin kernel: scsi: device set offline - not ready or
command retry failed after host reset: host 1 channel 0 id 3 lun 0
Jul 27 23:25:47 munin kernel: 3w-xxxx: tw_interrupt(): Bad response,
status = 0xcf, flags = 0x0, unit = 0x3.
Jul 27 23:25:47 munin kernel: scsi: device set offline - not ready or
command retry failed after host reset: host 1 channel 0 id 3 lun 0
Jul 27 23:25:47 munin kernel: 3w-xxxx: tw_interrupt(): Bad response,
status = 0xcf, flags = 0x0, unit = 0x3.
Jul 27 23:25:47 munin kernel: scsi: device set offline - not ready or
command retry failed after host reset: host 1 channel 0 id 3 lun 0
Jul 27 23:25:47 munin kernel: 3w-xxxx: tw_interrupt(): Bad response,
status = 0xcf, flags = 0x0, unit = 0x3.
Jul 27 23:25:47 munin kernel: scsi: device set offline - not ready or
command retry failed after host reset: host 1 channel 0 id 3 lun 0
Jul 27 23:25:47 munin kernel: 3w-xxxx: tw_interrupt(): Bad response,
status = 0xcf, flags = 0x0, unit = 0x3.
Jul 27 23:25:47 munin kernel: scsi: device set offline - not ready or
command retry failed after host reset: host 1 channel 0 id 3 lun 0

followed by a bunch of garbage looking like the following (don't know if
this came from the RAID code or the 3ware code or something else...

Jul 27 23:25:47 munin kernel:  : D:0 D:0 :0 D: D:0 D:0 D:0 D: D:0 D:0
D:0 T:1:00> .01c967 65WD C 0sdIS,3DID5)SK6,  K>: :0  0,<40:,S[d0)K<00
v   N:  N: N: N: N  N  N  N  DN:0  DN:   N: N:****: el<4> drrrc>
Jul 27 23:25:47 munin kernel: **MP****da1>ck0ea
Jul 27 23:25:47 munin kernel:      L5 S853 0: 1:6 2:1 3:  DISK<N:6> :6
:6> 6:  DI: 7:: 8: ::411:  DISK<N:0:412:4>
Jul 27 23:25:47 munin kernel: <13:414:415:4>
Jul 27 23:25:47 munin kernel:      16:417:4>
Jul 27 23:25:47 munin kernel:   1:4>
Jul 27 23:25:47 munin kernel: <20:421:42:423:42:4>25:26:4IS>
Jul 27 23:25:47 munin kernel: 7 :a
Jul 27 23:25:47 munin kernel: 6
Jul 27 23:25:47 munin kernel: <d

Then a different disk "failure" a couple days later...

Jul 31 19:21:16 munin kernel: 3w-xxxx: tw_interrupt(): Bad response,
status = 0xc7, flags = 0x51, unit = 0x4.
Jul 31 19:21:19 munin kernel: 3w-xxxx: tw_scsi_eh_reset(): Reset
succeeded for card 1.
Jul 31 19:21:33 munin kernel: 3w-xxxx: tw_interrupt(): Bad response,
status = 0xc7, flags = 0x51, unit = 0x4.
Jul 31 19:21:33 munin kernel: scsi: device set offline - not ready or
command retry failed after host reset: host 1 channel 0 id 4 lun 0
Jul 31 19:21:33 munin kernel: SCSI disk error : host 1 channel 0 id 4
lun 0 return code = 80000
Jul 31 19:21:33 munin kernel:  I/O error: dev 08:41, sector 2362112

And finally a third "failure" today... 

Aug  1 12:54:29 munin kernel: 3w-xxxx: tw_interrupt(): Bad response,
status = 0xc7, flags = 0x51, unit = 0x1.
Aug  1 12:54:32 munin kernel: 3w-xxxx: tw_scsi_eh_reset(): Reset
succeeded for card 1.
Aug  1 12:54:45 munin kernel: 3w-xxxx: tw_interrupt(): Bad response,
status = 0xc7, flags = 0x51, unit = 0x1.
Aug  1 12:54:45 munin kernel: scsi: device set offline - not ready or
command retry failed after host reset: host 1 channel 0 id 1 lun 0
Aug  1 12:54:45 munin kernel: SCSI disk error : host 1 channel 0 id 1
lun 0 return code = 80000
Aug  1 12:54:45 munin kernel:  I/O error: dev 08:11, sector 158441712


Scott


> Adam Radford wrote:
> 
> Scott,
> 
> Several of the 'problems' users are seeing are due to bad IBM 75 Gig
> drives
> that had contamination during the manufacturing process.  Lots of them
> have
> been recalled but some are still in use.  Unfortunately, these drives
> give lots
> of ECC errors.
> 
> The status=c7, flags=51, unit=0x1  means that the drive on unit 1
> (which is
> port 1 since you are using software raid) is showing ECC errors during
> reads.
> 
> You didn't mention what kind of drives you have, but in either case,
> you need
> to replace that drive, IBM or not.
> 
> --
> Adam Radford
> Software Engineer
> 3ware, Inc.
> 
> -----Original Message-----
> From: Scott Ransom [mailto:ransom@cfa.harvard.edu]
> Sent: Wednesday, August 01, 2001 11:15 AM
> To: linux-kernel@vger.kernel.org; Scott Ransom
> Subject: 3ware Escalade problems
> 
> Hello,
> 
> After months of running a fileserver with an 8 port 3ware escalade
> card
> (kernels 2.4.[3457] using reiserfs and software RAID5) I started
> getting
> problems this weekend.
> 
> Over the last three days, when I try to access the drives, after a
> couple minutes I get a drive failure (I even heard a "yelp" from the
> drive during one of them...).  But the "failure" has happened to 3 of
> the 8 drives over 3 days -- so unless there is a hardware problem that
> 
> is killing my drives I find it hard to believe that 3 drives really
> and
> truly failed....
> 
> Here is a sample from my syslog of a failure:
> 
> 3w-xxxx: tw_interrupt(): Bad response, status = 0xc7, flags = 0x51,
> unit
> = 0x1.
> 3w-xxxx: tw_scsi_eh_reset(): Reset succeeded for card 1.
> 3w-xxxx: tw_interrupt(): Bad response, status = 0xc7, flags = 0x51,
> unit
> = 0x1.
> scsi: device set offline - not ready or command retry failed after
> host
> reset: host 1 channel 0 id 1 lun 0
> SCSI disk error : host 1 channel 0 id 1 lun 0 return code = 80000
> I/O error: dev 08:11, sector 158441712
> 
> I've noticed several "issues" with the 3ware cards in the archives.
> Has
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
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Scott M. Ransom                   Address:  Harvard-Smithsonian CfA
Phone:  (617) 496-7908                      60 Garden St.  MS 10 
email:  ransom@cfa.harvard.edu              Cambridge, MA  02138
GPG Fingerprint: 06A9 9553 78BE 16DB 407B  FFCA 9BFA B6FF FFD3 2989
