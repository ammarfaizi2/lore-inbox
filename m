Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318153AbSGMMax>; Sat, 13 Jul 2002 08:30:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318154AbSGMMaw>; Sat, 13 Jul 2002 08:30:52 -0400
Received: from web14008.mail.yahoo.com ([216.136.175.124]:50949 "HELO
	web14008.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S318153AbSGMMav>; Sat, 13 Jul 2002 08:30:51 -0400
Message-ID: <20020713123342.10442.qmail@web14008.mail.yahoo.com>
Date: Sat, 13 Jul 2002 05:33:42 -0700 (PDT)
From: Tony Spinillo <tspinillo@yahoo.com>
Subject: Re: ittle problems with /dev/sr0 with 2.4.19-rc1
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think I also hit this. Kernel 2.4.19-rc1-ac3. I tried the
-no-pad option. I also tried readcd dev=2,0,0 f=/test.iso,
that failed also.

The latest cdrdao seems to read and make good copies though.

from /var/log/messages:
Jul 13 07:50:14 251 kernel: scsi2: ERROR on channel 0, id 0, lun

0,CDB: Request Sense 00 00 00 40 00
Jul 13 07:50:14 251 kernel: Info fld=0x50698 (nonstd), Current
sd0b:00: sense key Medium Error
Jul 13 07:50:14 251 kernel: Additional sense indicates 
Unrecovered read error

I will test later with some other media, a different build
of cdrecord, and I will run a cleaner through the drive.

Thanks,

Tony



>>On Sun Jul 07, 2002 at 06:07:44AM -0400, Christian Robert
wrote:
>> [root@X-home:/btemp] # md5sum /dev/sr0
>> md5sum: /dev/sr0: Input/output error         <- oups, it 
failed
>> 
>> [root@X-home:/btemp] # dd if=/dev/sr0 | md5sum
>> dd: reading `/dev/sr0': Input/output error   <- failed here
too
>> 13440+0 records in
>> 13440+0 records out
>> 5ec08b6fa7bf09741d1310e5baa800de  - <- but md5sum is 
>OK

>Looks like a read ahead bug to me...  Out of curiousity,
>did you use "-no-pad" with mkisofs?

> -Erik

__________________________________________________
Do You Yahoo!?
Yahoo! Autos - Get free new car price quotes
http://autos.yahoo.com
