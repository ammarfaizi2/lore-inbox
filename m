Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129145AbQKXQla>; Fri, 24 Nov 2000 11:41:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129325AbQKXQlU>; Fri, 24 Nov 2000 11:41:20 -0500
Received: from faun.nada.kth.se ([130.237.222.80]:49088 "EHLO faun.nada.kth.se")
        by vger.kernel.org with ESMTP id <S129145AbQKXQlK>;
        Fri, 24 Nov 2000 11:41:10 -0500
Date: Fri, 24 Nov 2000 17:11:08 +0100 (MET)
Message-Id: <200011241611.RAA19493@faun.nada.kth.se>
From: Roland Orre <orre@nada.kth.se>
To: linux-kernel@vger.kernel.org
Subject: Re: Can't mount SCSI CDROM in 2.4.*
Reply-to: orre@nada.kth.se (Roland Orre)
CC: Douglas Gilbert <dougg@torque.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Douglas Gilbert <dougg@torque.net> Fri Nov 24 wrote:
> Roland,
> What does 'cat /proc/scsi/scsi' output on your machine?
> Which SCSI adapter do you have?
> Doug Gilbert

My scsi adapter is adaptec 7880 on one machine and 7890 on
the other, i.e. driver is aic7xxx

This is what 'cat /proc/scsi/scsi' says when I've booted with 2.4.0-test11
Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: DNES-318350W     Rev: SA30
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 04 Lun: 00
  Vendor: PIONEER  Model: CD-ROM DR-U06S   Rev: 1.05
  Type:   CD-ROM                           ANSI SCSI revision: 02

And when I give the mount command:
bayes:~# mount -t iso9660 /dev/sr0 /cdrom
mount: /dev/sr0 has wrong major or minor number

And this is what 'cat /proc/scsi/scsi' says when I've booted with 2.2.17
Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: DNES-318350W     Rev: SA30
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 04 Lun: 00
  Vendor: PIONEER  Model: CD-ROM DR-U06S   Rev: 1.05
  Type:   CD-ROM                           ANSI SCSI revision: 02

And when I give the mount command then:
bayes:~# mount -t iso9660 /dev/sr0 /cdrom
mount: block device /dev/sr0 is write-protected, mounting read-only
I.e. the mounting works fine.

And this is the other machine, at the moment running 2.4.0-test7
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: DRVS18V          Rev: 00E5
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: PIONEER  Model: DVD-ROM DVD-303  Rev: 1.10
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 05 Lun: 00
  Vendor: YAMAHA   Model: CRW6416S         Rev: 1.0b
  Type:   CD-ROM                           ANSI SCSI revision: 02

bayes:/home/orre# mount -t iso9660 /dev/sr0 /cdrom
mount: /dev/sr0 has wrong major or minor number

As I said in last mail, major number= 11 and minor = 0, which is
in accordance with the documentation for both 2.2. and 2.4.

So what can this be? Can somebody that are running scsi cdrom/cdwriter
under 2.4.0-test* kernel send me a .config file so I can see if there
is any significant difference, if you don't have any other idea of
what it can be?

     Best regards
     Roland Orre
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
