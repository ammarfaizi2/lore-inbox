Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266723AbRGFPOf>; Fri, 6 Jul 2001 11:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266724AbRGFPOZ>; Fri, 6 Jul 2001 11:14:25 -0400
Received: from dwdmx2.dwd.de ([141.38.2.10]:21073 "HELO dwdmx2.dwd.de")
	by vger.kernel.org with SMTP id <S266723AbRGFPOM>;
	Fri, 6 Jul 2001 11:14:12 -0400
Date: Fri, 6 Jul 2001 17:14:01 +0200 (CEST)
From: Holger Kiehl <Holger.Kiehl@dwd.de>
To: <linux-kernel@vger.kernel.org>
Subject: What do these SCSI error messages mean?
Message-Id: <Pine.LNX.4.30.0107061712030.18212-100000@talentix.dwd.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I have a SW-Raid 5 running across 6 IBM DNES-309170W (one disk is hot spare)
on AIC-7890/1 Ultra2 SCSI host adapter (onboard) under 2.2.19. I use the aic
driver that comes with 2.2.19 and Tagged Command Queueing is enabled and
set to 24. This system was running for about 2 years without any problems
when one disk had medium errors and I had to exchange this disk with a
DPSS-309170N of the same size.  Another thing I did was to try 2.4.5 with
the new aic driver, but went back to 2.2.19. Since then I am getting the
following errors in my syslog when the system is under heavy disk load:

 scsi : aborting command due to timeout : pid 718083, scsi0, channel 0, id 1, lun 0 Write (10) 00 00 c4 48 76 00 00 80 00
 (scsi0:0:1:0) SCSISIGI 0x4, SEQADDR 0x61, SSTAT0 0x0, SSTAT1 0x2
 (scsi0:0:1:0) SG_CACHEPTR 0x2c, SSTAT2 0x40, STCNT 0x5fc
 scsi : aborting command due to timeout : pid 718084, scsi0, channel 0, id 1, lun 0 Write (10) 00 00 c4 48 f6 00 00 80 00
 scsi : aborting command due to timeout : pid 718085, scsi0, channel 0, id 1, lun 0 Write (10) 00 00 c4 49 7e 00 00 30 00
 scsi : aborting command due to timeout : pid 718086, scsi0, channel 0, id 2, lun 0 Write (10) 00 00 c4 47 76 00 00 80 00
 scsi : aborting command due to timeout : pid 718087, scsi0, channel 0, id 2, lun 0 Write (10) 00 00 c4 47 f6 00 00 80 00
 scsi : aborting command due to timeout : pid 718088, scsi0, channel 0, id 2, lun 0 Write (10) 00 00 c4 48 76 00 00 80 00
 scsi : aborting command due to timeout : pid 718089, scsi0, channel 0, id 2, lun 0 Write (10) 00 00 c4 48 f6 00 00 80 00
 scsi : aborting command due to timeout : pid 718090, scsi0, channel 0, id 2, lun 0 Read (10) 00 00 c4 49 76 00 00 08 00
 scsi : aborting command due to timeout : pid 718091, scsi0, channel 0, id 2, lun 0 Write (10) 00 00 c4 49 7e 00 00 30 00
 scsi : aborting command due to timeout : pid 718092, scsi0, channel 0, id 3, lun 0 Write (10) 00 00 c4 47 76 00 00 80 00
 scsi : aborting command due to timeout : pid 718093, scsi0, channel 0, id 3, lun 0 Write (10) 00 00 c4 47 f6 00 00 80 00
 scsi : aborting command due to timeout : pid 718094, scsi0, channel 0, id 3, lun 0 Write (10) 00 00 c4 48 76 00 00 80 00
 scsi : aborting command due to timeout : pid 718095, scsi0, channel 0, id 3, lun 0 Write (10) 00 00 c4 48 f6 00 00 80 00
 scsi : aborting command due to timeout : pid 718096, scsi0, channel 0, id 3, lun 0 Write (10) 00 00 c4 49 7e 00 00 30 00
 scsi : aborting command due to timeout : pid 718097, scsi0, channel 0, id 4, lun 0 Write (10) 00 00 c4 47 76 00 00 80 00
 scsi : aborting command due to timeout : pid 718098, scsi0, channel 0, id 4, lun 0 Write (10) 00 00 c4 47 f6 00 00 80 00
 scsi : aborting command due to timeout : pid 718099, scsi0, channel 0, id 4, lun 0 Write (10) 00 00 c4 48 76 00 00 80 00
 scsi : aborting command due to timeout : pid 718100, scsi0, channel 0, id 4, lun 0 Write (10) 00 00 c4 48 f6 00 00 80 00
 scsi : aborting command due to timeout : pid 718101, scsi0, channel 0, id 4, lun 0 Write (10) 00 00 c4 49 7e 00 00 30 00
 scsi : aborting command due to timeout : pid 718102, scsi0, channel 0, id 2, lun 0 Read (10) 00 00 c4 49 ae 00 00 08 00
 scsi : aborting command due to timeout : pid 718103, scsi0, channel 0, id 3, lun 0 Read (10) 00 00 c3 76 86 00 00 20 00
 scsi : aborting command due to timeout : pid 718104, scsi0, channel 0, id 0, lun 0 Read (10) 00 00 28 6b 76 00 00 80 00
 scsi : aborting command due to timeout : pid 718105, scsi0, channel 0, id 0, lun 0 Read (10) 00 00 28 6b f6 00 00 80 00
 scsi : aborting command due to timeout : pid 718106, scsi0, channel 0, id 1, lun 0 Read (10) 00 00 28 6b 76 00 00 80 00
 scsi : aborting command due to timeout : pid 718107, scsi0, channel 0, id 1, lun 0 Read (10) 00 00 28 6b f6 00 00 40 00
 scsi : aborting command due to timeout : pid 718108, scsi0, channel 0, id 2, lun 0 Read (10) 00 00 28 6b 76 00 00 80 00
 scsi : aborting command due to timeout : pid 718109, scsi0, channel 0, id 2, lun 0 Read (10) 00 00 28 6c 36 00 00 40 00
 scsi : aborting command due to timeout : pid 718110, scsi0, channel 0, id 3, lun 0 Read (10) 00 00 28 6b 4e 00 00 68 00
 scsi : aborting command due to timeout : pid 718111, scsi0, channel 0, id 3, lun 0 Read (10) 00 00 28 6b f6 00 00 60 00
 scsi : aborting command due to timeout : pid 718112, scsi0, channel 0, id 4, lun 0 Read (10) 00 00 28 6b 36 00 00 40 00
 scsi : aborting command due to timeout : pid 718113, scsi0, channel 0, id 4, lun 0 Read (10) 00 00 28 6b b6 00 00 80 00
 scsi : aborting command due to timeout : pid 718114, scsi0, channel 0, id 1, lun 0 Read (10) 00 00 c2 ed 1e 00 00 08 00
 SCSI host 0 abort (pid 718083) timed out - resetting
 SCSI bus is being reset for host 0 channel 0.
 (scsi0:0:0:0) Synchronous at 80.0 Mbyte/sec, offset 31.
 (scsi0:0:1:0) Synchronous at 80.0 Mbyte/sec, offset 31.
 (scsi0:0:3:0) Synchronous at 80.0 Mbyte/sec, offset 31.
 (scsi0:0:4:0) Synchronous at 80.0 Mbyte/sec, offset 31.
 (scsi0:0:2:0) Synchronous at 80.0 Mbyte/sec, offset 63.


After this it continues happily and none of the disks are kicked out of
the raid array. Sometimes the errors look a bit different:

 scsi : aborting command due to timeout : pid 703214, scsi0, channel 0, id 0, lun 0 Write (10) 00 00 28 cb 76 00 00 80 00
 scsi : aborting command due to timeout : pid 703215, scsi0, channel 0, id 0, lun 0 Write (10) 00 00 28 cb f6 00 00 68 00
 scsi : aborting command due to timeout : pid 703216, scsi0, channel 0, id 0, lun 0 Write (10) 00 00 28 cc f6 00 00 68 00
 scsi : aborting command due to timeout : pid 703218, scsi0, channel 0, id 1, lun 0 Write (10) 00 00 28 c9 ee 00 00 80 00
 scsi : aborting command due to timeout : pid 703219, scsi0, channel 0, id 1, lun 0 Write (10) 00 00 28 ca 6e 00 00 80 00
 scsi : aborting command due to timeout : pid 703220, scsi0, channel 0, id 1, lun 0 Write (10) 00 00 28 ca ee 00 00 80 00
 scsi : aborting command due to timeout : pid 703221, scsi0, channel 0, id 1, lun 0 Write (10) 00 00 28 cb 6e 00 00 80 00
 scsi : aborting command due to timeout : pid 703222, scsi0, channel 0, id 1, lun 0 Write (10) 00 00 28 cb ee 00 00 70 00
 scsi : aborting command due to timeout : pid 703223, scsi0, channel 0, id 1, lun 0 Write (10) 00 00 28 cc f6 00 00 68 00
 scsi : aborting command due to timeout : pid 703224, scsi0, channel 0, id 2, lun 0 Write (10) 00 00 28 c9 76 00 00 80 00
 scsi : aborting command due to timeout : pid 703225, scsi0, channel 0, id 2, lun 0 Write (10) 00 00 28 c9 f6 00 00 80 00
 scsi : aborting command due to timeout : pid 703226, scsi0, channel 0, id 2, lun 0 Write (10) 00 00 28 ca 76 00 00 80 00
 scsi : aborting command due to timeout : pid 703227, scsi0, channel 0, id 2, lun 0 Write (10) 00 00 28 ca f6 00 00 80 00
 scsi : aborting command due to timeout : pid 703228, scsi0, channel 0, id 2, lun 0 Write (10) 00 00 28 cb 76 00 00 80 00
 scsi : aborting command due to timeout : pid 703229, scsi0, channel 0, id 2, lun 0 Write (10) 00 00 28 cb f6 00 00 60 00
 scsi : aborting command due to timeout : pid 703230, scsi0, channel 0, id 2, lun 0 Write (10) 00 00 28 cc f6 00 00 68 00
 scsi : aborting command due to timeout : pid 703231, scsi0, channel 0, id 3, lun 0 Write (10) 00 00 28 c9 76 00 00 80 00
 scsi : aborting command due to timeout : pid 703232, scsi0, channel 0, id 3, lun 0 Write (10) 00 00 28 c9 f6 00 00 80 00
 scsi : aborting command due to timeout : pid 703233, scsi0, channel 0, id 3, lun 0 Write (10) 00 00 28 ca 76 00 00 80 00
 scsi : aborting command due to timeout : pid 703234, scsi0, channel 0, id 3, lun 0 Write (10) 00 00 28 ca f6 00 00 80 00
 scsi : aborting command due to timeout : pid 703235, scsi0, channel 0, id 3, lun 0 Write (10) 00 00 28 cb 76 00 00 80 00
 scsi : aborting command due to timeout : pid 703236, scsi0, channel 0, id 3, lun 0 Write (10) 00 00 28 cb f6 00 00 60 00
 scsi : aborting command due to timeout : pid 703237, scsi0, channel 0, id 3, lun 0 Write (10) 00 00 28 cc f6 00 00 68 00
 scsi : aborting command due to timeout : pid 703238, scsi0, channel 0, id 4, lun 0 Write (10) 00 00 28 c9 6e 00 00 80 00
 scsi : aborting command due to timeout : pid 703239, scsi0, channel 0, id 4, lun 0 Write (10) 00 00 28 c9 ee 00 00 80 00
 scsi : aborting command due to timeout : pid 703240, scsi0, channel 0, id 4, lun 0 Write (10) 00 00 28 ca 6e 00 00 80 00
 scsi : aborting command due to timeout : pid 703241, scsi0, channel 0, id 4, lun 0 Write (10) 00 00 28 ca ee 00 00 80 00
 scsi : aborting command due to timeout : pid 703242, scsi0, channel 0, id 4, lun 0 Write (10) 00 00 28 cb 6e 00 00 80 00
 scsi : aborting command due to timeout : pid 703243, scsi0, channel 0, id 4, lun 0 Write (10) 00 00 28 cb ee 00 00 68 00
 scsi : aborting command due to timeout : pid 703244, scsi0, channel 0, id 4, lun 0 Write (10) 00 00 28 cc f6 00 00 68 00
 scsi : aborting command due to timeout : pid 703245, scsi0, channel 0, id 0, lun 0 Write (10) 00 00 28 cc 5e 00 00 80 00
 scsi : aborting command due to timeout : pid 703246, scsi0, channel 0, id 0, lun 0 Write (10) 00 00 28 cc de 00 00 18 00
 scsi : aborting command due to timeout : pid 703247, scsi0, channel 0, id 1, lun 0 Write (10) 00 00 28 cc 5e 00 00 80 00
 scsi : aborting command due to timeout : pid 703248, scsi0, channel 0, id 1, lun 0 Write (10) 00 00 28 cc de 00 00 18 00
 scsi : aborting command due to timeout : pid 703249, scsi0, channel 0, id 2, lun 0 Write (10) 00 00 28 cc 56 00 00 80 00
 scsi : aborting command due to timeout : pid 703250, scsi0, channel 0, id 2, lun 0 Write (10) 00 00 28 cc d6 00 00 20 00
 scsi : aborting command due to timeout : pid 703251, scsi0, channel 0, id 3, lun 0 Write (10) 00 00 28 cc 56 00 00 80 00
 scsi : aborting command due to timeout : pid 703252, scsi0, channel 0, id 3, lun 0 Write (10) 00 00 28 cc d6 00 00 20 00
 scsi : aborting command due to timeout : pid 703253, scsi0, channel 0, id 4, lun 0 Write (10) 00 00 28 cc 56 00 00 80 00
 scsi : aborting command due to timeout : pid 703254, scsi0, channel 0, id 4, lun 0 Write (10) 00 00 28 cc d6 00 00 18 00
 scsi : aborting command due to timeout : pid 703255, scsi0, channel 0, id 4, lun 0 Write (10) 00 00 28 cc ee 00 00 08 00
 scsi : aborting command due to timeout : pid 703256, scsi0, channel 0, id 0, lun 0 Write (10) 00 00 28 cd 66 00 00 08 00
 scsi : aborting command due to timeout : pid 703257, scsi0, channel 0, id 1, lun 0 Read (10) 00 00 28 cd 5e 00 00 08 00
 scsi : aborting command due to timeout : pid 703258, scsi0, channel 0, id 1, lun 0 Write (10) 00 00 28 cd 66 00 00 08 00
 scsi : aborting command due to timeout : pid 703259, scsi0, channel 0, id 2, lun 0 Write (10) 00 00 28 cd 66 00 00 08 00
 scsi : aborting command due to timeout : pid 703260, scsi0, channel 0, id 3, lun 0 Write (10) 00 00 28 cd 66 00 00 08 00
 scsi : aborting command due to timeout : pid 703261, scsi0, channel 0, id 4, lun 0 Write (10) 00 00 28 cd 66 00 00 08 00
 SCSI host 0 abort (pid 703214) timed out - resetting
 SCSI bus is being reset for host 0 channel 0.

 wait_on_bh, CPU 1:
 irq:  0 [0 0]
 bh:   1 [1 0]
 <[c010aead]> <[c0199ffc]> <[c019ab9b]> <[c01a3860]> <6>(scsi0:0:0:0) Synchronous at 80.0 Mbyte/sec, offset 31.
 (scsi0:0:1:0) Synchronous at 80.0 Mbyte/sec, offset 31.
 (scsi0:0:2:0) Synchronous at 80.0 Mbyte/sec, offset 63.
 (scsi0:0:3:0) Synchronous at 80.0 Mbyte/sec, offset 31.
 (scsi0:0:4:0) Synchronous at 80.0 Mbyte/sec, offset 31.

Could someone please tell me from these messages what is wrong with my
SCSI-subsystem?

Thanks,
Holger

