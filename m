Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291754AbSBNQQN>; Thu, 14 Feb 2002 11:16:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291746AbSBNQQC>; Thu, 14 Feb 2002 11:16:02 -0500
Received: from chaos.analogic.com ([204.178.40.224]:56198 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S291753AbSBNQPc>; Thu, 14 Feb 2002 11:15:32 -0500
Date: Thu, 14 Feb 2002 11:17:42 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Strange disk-write speeds
Message-ID: <Pine.LNX.3.95.1020214111438.31768A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Weird. I have two identical SCSI drives. They both synchronize
at 40 Mb/s on my Buslogic controller. They are the two ... 
    Vendor: SEAGATE  Model: ST318233LWV      Rev: 0002
... drives shown below.

They both have ext2 file-systems occupying a single partition.
The time to write a file that fills up the file-system on the
"Id: 01" drive is about 1/2 an hour and the time to write a
file that fills up the file-system on "Id: 02" is about 1/2 day!

This is with the file created with "O_SYNC". If the file is
not created with "O_SYNC", there is no apparent difference in
write speed.

If I swap the jumpers on the two drives to isolate the drives
from the problem, the slooooo drive is the logical "ID: 02",
always... not the physical one!

Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: SEAGATE  Model: ST32171W         Rev: 0484
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: SEAGATE  Model: ST318233LWV      Rev: 0002
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: SEAGATE  Model: ST318233LWV      Rev: 0002
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 04 Lun: 00
  Vendor: YAMAHA   Model: CRW6416S         Rev: 1.0b
  Type:   CD-ROM                           ANSI SCSI revision: 02


`uname -a`
Linux chaos 2.4.1 #39 SMP Wed Jan 2 14:35:06 EST 2002 i686

Does anybody have a clue?

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


