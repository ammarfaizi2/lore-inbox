Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130302AbQKORDC>; Wed, 15 Nov 2000 12:03:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130016AbQKORCp>; Wed, 15 Nov 2000 12:02:45 -0500
Received: from ip-205-254-202-114.netwrx1.com ([205.254.202.114]:31494 "EHLO
	eagle.netwrx1.com") by vger.kernel.org with ESMTP
	id <S130408AbQKORCX>; Wed, 15 Nov 2000 12:02:23 -0500
From: "George R. Kasica" <georgek@netwrx1.com>
To: linux-kernel@vger.kernel.org
Subject: Question on SCSI Tape Changer Status
Date: Wed, 15 Nov 2000 10:32:19 -0600
Organization: Netwrx Consulting Inc.
Reply-To: georgek@netwrx1.com
Message-ID: <cpc51to6bgkkg4dk9vn786vbmd4i6u9ij0@4ax.com>
X-Mailer: Forte Agent 1.8/32.548
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This may not be the right place for this so if not let me know where I
should send it.

Question:

I've got an HP 4mm DAT Autochanger here (Scsi detection shown below
from boot)...what I'm wondering is this: Is there a way to tell WHICH
ONE of the 6 tapes is in the actual tape drive from the OS? And if so,
a way to make it load a specific tape (1-6 or maybe 0-5 I'm not sure
what the numbering is) I know I can look at the LCD on the drive but
that doesn't help if I'm 90 miles away in another city trying to
tell...main reason I want to do this is after it starts to write on
tape 5 and finished there is a cleaning tape in slot 6 that I'd like
to force to load then eject the magazine so that it can get changed by
the operator next morning....if they don't see it sticking out they
forget to change it and the backup fails the next day since there is
no tape in the drive due to #5 filling up and when it loads 6 its a
cleaner which runs and unloads but obviously doesn't write data so the
job fails....does this make any sense??

Here's the boot output:

Oct 26 22:20:27 eagle kernel: (scsi0) Narrow Channel, SCSI ID=7, 3/255
SCBs
Oct 26 22:20:27 eagle kernel: (scsi0) Cables present (Int-50 YES,
Ext-50 YES)
Oct 26 22:20:27 eagle kernel: (scsi0) Downloading sequencer code...
415 instructions downloaded
Oct 26 22:20:27 eagle kernel: scsi0 : Adaptec AHA274x/284x/294x
(EISA/VLB/PCI-Fast SCSI) 5.1.31/3.2.4
Oct 26 22:20:27 eagle kernel:        <Adaptec AIC-7850 SCSI host
adapter>
Oct 26 22:20:27 eagle kernel: scsi : 1 host.
Oct 26 22:20:27 eagle kernel:   Vendor: SEAGATE   Model: ST32550N
Rev:0021
Oct 26 22:20:27 eagle kernel:   Type:   Direct-Access ANSI SCSI
revision: 02
Oct 26 22:20:27 eagle kernel: Detected scsi disk sda at scsi0, channel
0, id 1,lun 0
Oct 26 22:20:27 eagle kernel:   Vendor: HP        Model: C1553A
Rev:NS01
Oct 26 22:20:27 eagle kernel:   Type:   Sequential-Access
ANSI SCSI revision: 02
Oct 26 22:20:27 eagle kernel: Detected scsi tape st0 at scsi0, channel
0, id 3,lun 0
Oct 26 22:20:27 eagle kernel:   Vendor: HP        Model: C1553A
Rev:NS01
Oct 26 22:20:27 eagle kernel:   Type:   Medium Changer
ANSI SCSI revision: 02
Oct 26 22:20:27 eagle kernel: Detected scsi generic sg2 at scsi0,
channel 0, id 3, lun 1
Oct 26 22:20:27 eagle kernel: scsi : detected 3 SCSI generics 1 SCSI
tape 1 SCSI disk total.
Oct 26 22:20:27 eagle kernel: SCSI device sda: hdwr sector= 512 bytes.
Sectors=4194058 [2047 MB] [2.0 GB]


And here's an mt status output:

# mt -f /dev/st0 status
SCSI 2 tape drive:
File number=1, block number=0, partition=0.
Tape block size 0 bytes. Density code 0x24 (DDS-2).
Soft error count since last status=0
General status bits on (81010000):
 EOF ONLINE IM_REP_EN

# mt -f /dev/nst0 status
SCSI 2 tape drive:
File number=0, block number=0, partition=0.
Tape block size 0 bytes. Density code 0x24 (DDS-2).
Soft error count since last status=0
General status bits on (41010000):
 BOT ONLINE IM_REP_EN


George, MR. Tibbs & The Beast Kasica
Waukesha, WI USA
georgek@netwrx1.com
http://www.netwrx1.com
ICQ #12862186

      Zz
       zZ
    |\ z    _,,,---,,_
    /,`.-'`'    _   ;-;;,_
   |,4-  ) )-,_..;\ (  `'_'
  '---''(_/--'  `-'\_)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
