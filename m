Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318365AbSGYIVL>; Thu, 25 Jul 2002 04:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318359AbSGYIVL>; Thu, 25 Jul 2002 04:21:11 -0400
Received: from signup.localnet.com ([207.251.201.46]:63402 "HELO
	smtp.localnet.com") by vger.kernel.org with SMTP id <S318365AbSGYIVJ>;
	Thu, 25 Jul 2002 04:21:09 -0400
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: 2.4.19-rc3-ac3+ and sbp2
From: "James H. Cloos Jr." <cloos@jhcloos.com>
Date: 25 Jul 2002 04:24:14 -0400
Message-ID: <m37kjkz041.fsf@lugabout.jhcloos.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

I'm getting the below errors when plugging in a maxtor 160 as of
2.4.19-rc3-ac3 + the next couple of csets after v2.4.19-rc3.
They did not show up in 2.4.19-pre8 and earlier.

I've not yet tested the svn tree.

After the errors are some relevant data about the drive.

As you can see from them and the fdisk -l -u output, the error sectors
are well beyond the partition table's idea of the end of the disk, but
I see the previous kernels also saw 320173056 sectors; they just
didn't give the lba oor errors.

Anyone have any thoughts on this?


--=-=-=
Content-Disposition: inline

kernel: ohci1394_0: SelfID received outside of bus reset sequence
kernel: ieee1394: Device added: Node[01:1023]  GUID[0010b90101409990]  [Maxtor  ]
kernel: ieee1394: sbp2: Logged into SBP-2 device
kernel: ieee1394: sbp2: Node[01:1023]: Max speed [S400] - Max payload [2048]
kernel: scsi0 : IEEE-1394 SBP-2 protocol driver (host: ohci1394)
kernel: $Rev: 515 $ James Goodwin <jamesg@filanet.com>
kernel: SBP-2 module load options:
kernel: - Max speed supported: S400
kernel: - Max sectors per I/O supported: 255
kernel: - Max outstanding commands supported: 8
kernel: - Max outstanding commands per lun supported: 1
kernel: - Serialized I/O (debug): no
kernel: - Exclusive login: yes
kernel:   Vendor: Maxtor    Model: 1394 storage      Rev: v1.2
kernel:   Type:   Direct-Access                      ANSI SCSI revision: 06
kernel: Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
kernel: SCSI device sda: 320173056 512-byte hdwr sectors (163929 MB)
kernel:  sda:SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 8000002
kernel: Current sd08:00: sense key Aborted Command
kernel: Additional sense indicates Logical block address out of range
kernel:  I/O error: dev 08:00, sector 320173048
kernel: SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 8000002
kernel: Current sd08:00: sense key Aborted Command
kernel: Additional sense indicates Logical block address out of range
kernel:  I/O error: dev 08:00, sector 320173049
kernel: SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 8000002
kernel: Current sd08:00: sense key Aborted Command
kernel: Additional sense indicates Logical block address out of range
kernel:  I/O error: dev 08:00, sector 320173050
kernel: SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 8000002
kernel: Current sd08:00: sense key Aborted Command
kernel: Additional sense indicates Logical block address out of range
kernel:  I/O error: dev 08:00, sector 320173051
kernel: SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 8000002
kernel: Current sd08:00: sense key Aborted Command
kernel: Additional sense indicates Logical block address out of range
kernel:  I/O error: dev 08:00, sector 320173052
kernel: SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 8000002
kernel: Current sd08:00: sense key Aborted Command
kernel: Additional sense indicates Logical block address out of range
kernel:  I/O error: dev 08:00, sector 320173053
kernel: SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 8000002
kernel: Current sd08:00: sense key Aborted Command
kernel: Additional sense indicates Logical block address out of range
kernel:  I/O error: dev 08:00, sector 320173054
kernel: SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 8000002
kernel: Current sd08:00: sense key Aborted Command
kernel: Additional sense indicates Logical block address out of range
kernel:  I/O error: dev 08:00, sector 320173055
kernel: SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 8000002
kernel: Current sd08:00: sense key Aborted Command
kernel: Additional sense indicates Logical block address out of range
kernel:  I/O error: dev 08:00, sector 320173048
kernel: SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 8000002
kernel: Current sd08:00: sense key Aborted Command
kernel: Additional sense indicates Logical block address out of range
kernel:  I/O error: dev 08:00, sector 320173049
kernel: SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 8000002
kernel: Current sd08:00: sense key Aborted Command
kernel: Additional sense indicates Logical block address out of range
kernel:  I/O error: dev 08:00, sector 320173050
kernel: SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 8000002
kernel: Current sd08:00: sense key Aborted Command
kernel: Additional sense indicates Logical block address out of range
kernel:  I/O error: dev 08:00, sector 320173051
kernel: SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 8000002
kernel: Current sd08:00: sense key Aborted Command
kernel: Additional sense indicates Logical block address out of range
kernel:  I/O error: dev 08:00, sector 320173052
kernel: SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 8000002
kernel: Current sd08:00: sense key Aborted Command
kernel: Additional sense indicates Logical block address out of range
kernel:  I/O error: dev 08:00, sector 320173053
kernel: SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 8000002
kernel: Current sd08:00: sense key Aborted Command
kernel: Additional sense indicates Logical block address out of range
kernel:  I/O error: dev 08:00, sector 320173054
kernel: SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 8000002
kernel: Current sd08:00: sense key Aborted Command
kernel: Additional sense indicates Logical block address out of range
kernel:  I/O error: dev 08:00, sector 320173055
kernel:  sda1 sda2
insmod: Using /lib/modules/2.4.19-rc3-ac3+/kernel/drivers/ieee1394/sbp2.o
insmod: Symbol version prefix ''

--=-=-=
Content-Disposition: inline

:; fdisk -l -u /dev/sda

Disk /dev/sda: 255 heads, 63 sectors, 19929 cylinders
Units = sectors of 1 * 512 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/sda1            63  80051894  40025916    c  Win95 FAT32 (LBA)
/dev/sda2      80051895 320159384 120053745   83  Linux

--=-=-=
Content-Disposition: inline

:; cat /proc/bus/ieee1394/devices 
Node[00:1023]  GUID[424fc0002de51021]:
  Vendor ID: `Linux OHCI-1394' [0x000000]
  Capabilities: 0x0083c0
  Bus Options:
    IRMC(1) CMC(1) ISC(1) BMC(0) PMC(0) GEN(0)
    LSPD(2) MAX_REC(2048) CYC_CLK_ACC(0)
  Host Node Status:
    Host Driver     : ohci1394
    Nodes connected : 2
    Nodes active    : 2
    SelfIDs received: 2
    Irm ID          : [00:1023]
    BusMgr ID       : [00:1023]
    In Bus Reset    : no
    Root            : no
    Cycle Master    : no
    IRM             : yes
    Bus Manager     : yes
Node[01:1023]  GUID[0010b90101409990]:
  Vendor ID: `Maxtor  ' [0x0010b9]
  Capabilities: 0x0083c0
  Bus Options:
    IRMC(0) CMC(0) ISC(0) BMC(0) PMC(0) GEN(0)
    LSPD(0) MAX_REC(64) CYC_CLK_ACC(255)
  Unit Directory 0:
    Vendor/Model ID: Maxtor   [0010b9] / 1394 storage     [000001]
    Software Specifier ID: 00609e
    Software Version: 010483
    Driver: SBP2 Driver
    Length (in quads): 8

--=-=-=--

