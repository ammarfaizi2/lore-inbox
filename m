Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267878AbRHASPD>; Wed, 1 Aug 2001 14:15:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267857AbRHASOx>; Wed, 1 Aug 2001 14:14:53 -0400
Received: from presto.harvard.edu ([131.142.9.143]:45462 "HELO
	presto.harvard.edu") by vger.kernel.org with SMTP
	id <S267873AbRHASOg>; Wed, 1 Aug 2001 14:14:36 -0400
Message-ID: <3B684714.32F6A02F@cfa.harvard.edu>
Date: Wed, 01 Aug 2001 14:14:44 -0400
From: Scott Ransom <ransom@cfa.harvard.edu>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Scott Ransom <ransom@cfa.harvard.edu>
Subject: 3ware Escalade problems
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

After months of running a fileserver with an 8 port 3ware escalade card
(kernels 2.4.[3457] using reiserfs and software RAID5) I started getting
problems this weekend.

Over the last three days, when I try to access the drives, after a
couple minutes I get a drive failure (I even heard a "yelp" from the
drive during one of them...).  But the "failure" has happened to 3 of
the 8 drives over 3 days -- so unless there is a hardware problem that
is killing my drives I find it hard to believe that 3 drives really and
truly failed....

Here is a sample from my syslog of a failure:

3w-xxxx: tw_interrupt(): Bad response, status = 0xc7, flags = 0x51, unit
= 0x1.
3w-xxxx: tw_scsi_eh_reset(): Reset succeeded for card 1.
3w-xxxx: tw_interrupt(): Bad response, status = 0xc7, flags = 0x51, unit
= 0x1.
scsi: device set offline - not ready or command retry failed after host
reset: host 1 channel 0 id 1 lun 0
SCSI disk error : host 1 channel 0 id 1 lun 0 return code = 80000
I/O error: dev 08:11, sector 158441712

I've noticed several "issues" with the 3ware cards in the archives.  Has
anyone seen something like this?

Scott

PS:  I'm currently running 2.4.7 with the lm-sensors/i2c patches.

-- 
Scott M. Ransom                   Address:  Harvard-Smithsonian CfA
Phone:  (617) 496-7908                      60 Garden St.  MS 10 
email:  ransom@cfa.harvard.edu              Cambridge, MA  02138
GPG Fingerprint: 06A9 9553 78BE 16DB 407B  FFCA 9BFA B6FF FFD3 2989
