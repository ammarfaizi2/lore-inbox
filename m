Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280032AbRJaCs5>; Tue, 30 Oct 2001 21:48:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280030AbRJaCss>; Tue, 30 Oct 2001 21:48:48 -0500
Received: from dfw-smtpout4.email.verio.net ([129.250.36.44]:62454 "EHLO
	dfw-smtpout4.email.verio.net") by vger.kernel.org with ESMTP
	id <S280044AbRJaCse>; Tue, 30 Oct 2001 21:48:34 -0500
Message-ID: <3BDF66A6.1091D25A@bigfoot.com>
Date: Tue, 30 Oct 2001 18:49:10 -0800
From: Tim Moore <timothymoore@bigfoot.com>
Organization: Yoyodyne Propulsion Systems, Inc.
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.2.20pre11vi i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Richard Kettlewell <rjk@greenend.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: problem with ide-scsi and IDE tape drive
In-Reply-To: <wwvady8vhfs.fsf@rjk.greenend.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If I try and save a tar to the tape twice in succession, rewinding and
> reading forward to the same point each time first, the second attempt
> fails (details below).

I use 'dd if=<file> of=/dev/nst0 bs=512 conv=sync' all the time to move
dumps from disk to tape w no problems.  Differences: 'mt tell' with 'mt seek'
for positioning and only dd for I/O, no tar.  Weird.
...
kernel: scsi0 : SCSI host adapter emulation for IDE ATAPI devices
kernel: scsi : 1 host.
kernel:   Vendor: HP        Model: COLORADO 20GB     Rev: 4.01
kernel:   Type:   Sequential-Access                  ANSI SCSI revision: 02
kernel: Detected scsi tape st0 at scsi0, channel 0, id 0, lun 0
kernel: scsi : detected 1 SCSI generic 1 SCSI tape total.
...
kernel: st0: Error with sense data: Info fld=0xf000, Deferred st09:00: sns = f1  3  
kernel: ASC=50 ASCQ= 1  
kernel: Raw sense data:0xf1 0x00 0x03 0x00 0x00 0xf0 0x00 0x10 0x00 0x00 0x00 0x00
0x50 0x01 0x00 0x00   
kernel: st0: Error with sense data: Info fld=0xf000, Current st09:00: sns = f0  3  
kernel: ASC=50 ASCQ= 1  
kernel: Raw sense data:0xf0 0x00 0x03 0x00 0x00 0xf0 0x00 0x10 0x00 0x00 0x00 0x00
0x50 0x01 0x00 0x00   
kernel: st0: Error on write filemark.  
...
[tim@dell]> tar --version | head -1
tar (GNU tar) 1.13.17
[tim@dell]> mt -v
mt-st v. 0.5b
[tim@dell]> dd --version | head -1
dd (GNU fileutils) 4.0p
[tim@dell]> cat /proc/version
Linux version 2.2.20pre6 (root@abit) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 
release)) #4 Sun Oct 28 22:32:11 PST 2001

rgds,
tim.
--
