Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289198AbSA3Nc5>; Wed, 30 Jan 2002 08:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289201AbSA3Ncq>; Wed, 30 Jan 2002 08:32:46 -0500
Received: from 200-171-140-137.dsl.telesp.net.br ([200.171.140.137]:44548 "HELO
	josephine.e-mail4you.com.br") by vger.kernel.org with SMTP
	id <S289198AbSA3Ncl>; Wed, 30 Jan 2002 08:32:41 -0500
Date: Wed, 30 Jan 2002 11:33:37 -0200
From: michelpereira@uol.com.br (Michel Angelo da Silva Pereira)
To: linux-kernel@vger.kernel.org
Subject: Oops with 2.4.18-pre3-ac2 with Intel ServerRAID Controller
Message-ID: <20020130113337.A2140@josephine.e-mail4you.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.17i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Here is what I got on /var/log/messages

Jan 30 10:27:21 servmail kernel: Loading Adaptec I2O RAID: Version 2.4 Build 5
Jan 30 10:27:21 servmail kernel: Detecting Adaptec I2O RAID controllers...
Jan 30 10:27:39 servmail kernel: Linux I2O PCI support (c) 1999 Red Hat Software.
Jan 30 10:27:39 servmail kernel: I2O Core - (C) Copyright 1999 Red Hat Software
Jan 30 10:27:39 servmail kernel: i2o: Checking for PCI I2O controllers...
Jan 30 10:27:39 servmail kernel: i2o: I2O controller on bus 1 at 97.
Jan 30 10:27:39 servmail kernel: i2o: PCI I2O controller at 0xF8000000 size=67108864
Jan 30 10:27:39 servmail kernel: mtrr: Serverworks LE detected. Write-combining
disabled.
Jan 30 10:27:39 servmail kernel: mtrr: your processor doesn't support write-combining
Jan 30 10:27:39 servmail kernel: I2O: MTRR workaround for Intel i960 processor
Jan 30 10:27:39 servmail kernel: i2o/iop0: Installed at IRQ22
Jan 30 10:27:39 servmail kernel: i2o: 1 I2O controller found and installed.
Jan 30 10:27:39 servmail kernel: I2O: Event thread created as pid 787
Jan 30 10:27:39 servmail kernel: Activating I2O controllers...
Jan 30 10:27:39 servmail kernel: This may take a few minutes if there are many devices
Jan 30 10:28:09 servmail kernel: i2o/iop0: LCT has 17 entries.
Jan 30 10:29:25 servmail kernel: I2O configuration manager v 0.04.
Jan 30 10:29:25 servmail kernel:   (C) Copyright 1999 Red Hat Software
Jan 30 10:29:36 servmail kernel: I2O Block Storage OSM v0.9
Jan 30 10:29:36 servmail kernel:    (c) Copyright 1999-2001 Red Hat Software.
Jan 30 10:29:36 servmail kernel: i2o_block: registered device at major 80
Jan 30 10:29:36 servmail kernel: i2o_block: Checking for Boot device...
Jan 30 10:29:36 servmail kernel: i2o_block: Checking for I2O Block devices...
Jan 30 10:29:36 servmail kernel: i2ob: Installing tid 16 device at unit 0
Jan 30 10:29:36 servmail kernel: i2o/hda: Max segments 12, queue depth 128, byte limit 6144.
Jan 30 10:29:36 servmail kernel: i2o/hda: Type 176: 69808MB, 512 byte sectors.
Jan 30 10:29:36 servmail kernel: i2o/hda: Maximum sectors/read set to 256.
an 30 10:29:36 servmail kernel:  i2o/hda: unknown partition table
Jan 30 10:33:23 servmail kernel: i2o_scsi.c: Version 0.0.1
Jan 30 10:33:23 servmail kernel:   chain_pool: 2048 bytes @ f6b92800
Jan 30 10:33:23 servmail kernel:   (512 byte buffers X 4 can_queue X 1 i2o controllers)
Jan 30 10:33:23 servmail kernel: scsi2 : i2o/iop0
Jan 30 10:33:23 servmail kernel: scsi3 : i2o/iop0
Jan 30 10:33:23 servmail kernel: scsi3 channel 0 : resetting for second half of retries.
Jan 30 10:33:23 servmail kernel: SCSI bus is being reset for host 3 channel 0.
Jan 30 10:33:23 servmail kernel: i2o_scsi: Attempting to reset the bus.
Jan 30 10:33:24 servmail kernel: SCSI host 3 channel 0 reset (pid 9075) timed out - trying harder
Jan 30 10:33:24 servmail kernel: SCSI bus is being reset for host 3 channel 0.
Jan 30 10:33:24 servmail kernel: i2o_scsi: Attempting to reset the bus.
Jan 30 10:36:36 servmail syslogd 1.4.1: restart.

and the server boot

And here is the Oops

CPU:1
EIP:0010:[<fcc40243>] not tained
EFLAGS: 00010046

EAX: 0000001d EBX: 03f686d0 ECX: f232a000 EDX: 00000001 ESI: c3f686d0
EDI: 00000000 EBP: f236ad60 ESP: c1b75ef4
DS: 0018    ES: 0018  SS: 0018

process swapper (pid:0, stackpage=c1b75000)

stack: 31d4cd00 f236ad60 00000020 00000016 f236ad013 0b000020 00000000
       f8c33f79 fcc415f4 f236ad60 f1d4cd00 f1ddddf80 04000001 f8c3112c
       f236ad60 c01086c4 00000016 f236ad60 c1b75f7c c032fde0 c0305ac0
       00000016 c1b75f74 c01088b6

call trace: [<f8c33f79>] [<fcc415f4>] [<f8c3112c>] [<c01086c4>]
            [<c01088b6>] [<c01053c0>] [<c01053c0>] [<c01053c0>]
            [<c01053ec>] [<c0105452>] [<cd117298>] [<c01171a3>]

code: 8b 47 24 5d 68 c2 0e c4 fc e8 3f 63 4d c3 83 c4 08 fa f0 fe

<0> Kernel Panic: Aiee, killing interrupt handler!
in interrupt handler - not syncing
-- 
=================================================
Borges & Rinolfi Soluções em Redes Corporativas
Security Officer
Profissional Certificado Conectiva Linux
www.techs.com.br/kidmumu - UIN 4553082 - LC 83522
=================================================

