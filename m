Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132246AbQKZUvq>; Sun, 26 Nov 2000 15:51:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132787AbQKZUvf>; Sun, 26 Nov 2000 15:51:35 -0500
Received: from smtp3.mail.yahoo.com ([128.11.68.135]:35853 "HELO
        smtp1b.mail.yahoo.com") by vger.kernel.org with SMTP
        id <S132246AbQKZUvU>; Sun, 26 Nov 2000 15:51:20 -0500
X-Apparently-From: <jmargaglione@yahoo.com>
Message-ID: <3A217F80.C4CA5382@yahoo.com>
Date: Sun, 26 Nov 2000 15:24:16 -0600
From: John Margaglione <jmargaglione@yahoo.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ISSUE: usb-storage causes system freeze on large transfers
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1.  usb-storage causes system freeze on large transfers.

2.  When transferring data from a SanDisk ImageMate SDDR-31 loaded with
an IBM Microdrive, I get random system freezes.  

In the first case, using 2.4.0-test10 with a 50MB transfer, the system
dropped out of X with a console freeze and a message about the watchdog
timer.  Sorry, but I didn't have paper around to write out the whole
message.

In the second and third cases, using 2.4.0-test11 with 10-20MB
transfers, the system became non-responsive and required a hard reboot. 
No messages were given in the log files.

All of the cases were within a three hour period on the same machine
(see description below).  In each case, the command "cp /mnt/camera/* ."
was issued.

Note that I have had a half-dozen successfully completed transfers of
10-40MB in between these errors.  The words "race condition" come to
mind.

3. Keywords: usb usb-storage

4. Kernel version: 2.4.0-test10/2.4.0-test11

5. No OOPS available.

6. "cp /mnt/camera/* ." will cause the error.  In this case, I mounted
/mnt/camera on /dev/sdd1, where the usb-storage driver had provided
/dev/sdd1 for the SanDisk device.

7. Environment
7.1  Software
  Linux wopr 2.4.0-test11 #9 SMP Sat Nov 25 18:52:11 CST 2000 i686
unknown
  Kernel modules         2.3.14
  Gnu C                  2.96
  Binutils               2.10.0.18
  Linux C Library        1.94.so
  ldd: missing file arguments
  Try `ldd --help' for more information.
  ls: /usr/lib/libg++.so: No such file or directory
  Procps                 2.0.7
  Mount                  2.10m
  Net-tools              (2000-05-21)
  Kbd                    [option...]
  Sh-utils               2.0
  Sh-utils               Parker.
  Sh-utils               
  Sh-utils               Inc.
  Sh-utils               NO
  Sh-utils               PURPOSE.

  Running under latest HelixGnome with Enlightenment window manager. 
Open applications included Netscape, GMC and a half-dozen xterms. 

7.2 Processor Information
  processor       : 0
  vendor_id       : GenuineIntel
  cpu family      : 6
  model           : 6
  model name      : Celeron (Mendocino)
  stepping        : 5
  cpu MHz         : 451.000028
  cache size      : 128 KB
  fdiv_bug        : no
  hlt_bug         : no
  f00f_bug        : no
  coma_bug        : no
  fpu             : yes
  fpu_exception   : yes
  cpuid level     : 2
  wp              : yes
  features        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 mmx fxsr  
  bogomips        : 897.84

  processor       : 1
  vendor_id       : GenuineIntel
  cpu family      : 6
  model           : 6
  model name      : Celeron (Mendocino)
  stepping        : 5
  cpu MHz         : 451.000028
  cache size      : 128 KB
  fdiv_bug        : no
  hlt_bug         : no
  f00f_bug        : no
  coma_bug        : no
  fpu             : yes
  fpu_exception   : yes
  cpuid level     : 2
  wp              : yes
  features        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 mmx fxsr
  bogomips        : 901.12

7.3 Module info
nls_cp437               4384   1 (autoclean)
vfat                   11500   1 (autoclean)
fat                    32504   0 (autoclean) [vfat]
usb-storage            43428   1
agpgart                15172   0 (unused)

7.4 SCSI info
  Attached devices: 
  Host: scsi1 Channel: 00 Id: 02 Lun: 00
    Vendor: SEAGATE  Model: ST39173WC        Rev: 6244
    Type:   Direct-Access                    ANSI SCSI revision: 02
  Host: scsi1 Channel: 00 Id: 04 Lun: 00
    Vendor: SEAGATE  Model: ST39173WC        Rev: 6244
    Type:   Direct-Access                    ANSI SCSI revision: 02
  Host: scsi2 Channel: 00 Id: 00 Lun: 00
    Vendor: IOMEGA   Model: ZIP 100          Rev: 23.D
    Type:   Direct-Access                    ANSI SCSI revision:
ffffffff
  Host: scsi3 Channel: 00 Id: 00 Lun: 00
    Vendor: SanDisk  Model: ImageMate II     Rev: 1.30
    Type:   Direct-Access                    ANSI SCSI revision: 02

7.5 Other info
  Please CC me in reference to this issue, as I do not subscribe to the
list.

John Margaglione
jmargaglione@yahoo.com

_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
