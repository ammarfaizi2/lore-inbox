Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132062AbQLLQfV>; Tue, 12 Dec 2000 11:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132070AbQLLQfL>; Tue, 12 Dec 2000 11:35:11 -0500
Received: from nexus.iu.hio.no ([128.39.89.10]:1717 "EHLO nexus.iu.hio.no")
	by vger.kernel.org with ESMTP id <S132062AbQLLQex>;
	Tue, 12 Dec 2000 11:34:53 -0500
Message-Id: <200012121606.eBCG6gO26025@nexus.iu.hio.no>
Date: Tue, 12 Dec 2000 17:06:39 +0100 (MET)
From: sigmunds@iu.hio.no
Subject: PROBLEM: Inode<0 in /proc/net/unix (2.2.16)
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] Inode<0 in /proc/net/unix (2.2.16)

[2.] I found that Inode in /proc/net/unix often is less than zero on a
debian system with a 2.2.16 kernel. If I understand correctly, this should not happen.
I haven't found any mention of this anywhere.

The corresponding values in the filesystem and in the rest of the proc
system were not negative. I do not know the cause; the reason I found
it, was that "netstat -p" (show owner/PID) segfaulted, which I traced to
this. I have not experienced any other problems because of this.

[3.] keywords: procfs

[4.] cube% cat /proc/version
Linux version 2.2.16 (sigmunds@cube) (gcc version egcs-2.91.66 Debian GNU/Linux (egcs-1.1.2 release)) #1 Fri Jun 16 12:04:40 MET DST 2000

[5.] na

[6.] na

[7.]
[7.1] cube% sh scripts/ver_linux
-- Versions installed: (if some fields are empty or looks
-- unusual then possibly you have very old versions)
Linux cube 2.2.16 #1 Fri Jun 16 12:04:40 MET DST 2000 i686 unknown
Kernel modules         2.3.11
Gnu C                  2.95.2
Binutils               2.9.5.0.37
Linux C Library        2.1.3
Dynamic linker         ldd: version 1.9.11
Procps                 2.0.6
Mount                  2.10f
Net-tools              2.05
Kbd                    0.99
Sh-utils               2.0
cat: /proc/modules: No such file or directory
Modules Loaded

[7.2] cube% cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 2
cpu MHz         : 447.697
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr xmm
bogomips        : 891.29

[7.3] na (static)

[7.4] cube% cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: DRVS09D          Rev: 0140
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: IBM      Model: DRVS09D          Rev: 0140
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: IBM      Model: DRVS09D          Rev: 0140
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 06 Lun: 00
  Vendor: DELL     Model: 1x6 U2W SCSI BP  Rev: 5.23
  Type:   Processor                        ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 05 Lun: 00
  Vendor: NEC      Model: CD-ROM DRIVE:466 Rev: 1.06
  Type:   CD-ROM                           ANSI SCSI revision: 02

[7.5]

[X.]

This report is regretfully horribly incomplete, for which I apologize.
If anyone could give me some directions, I would be happy to supply
further information. Please CC me, as I'm not on the list.

Z

------ Example: ------
cube% cat /proc/net/unix
[...]
81ed6600: 00000001 00000000 00000000 0001 03 995458897 @0000f36f
bffdaf40: 00000000 00000000 00010000 0001 01 995108363 /dev/log
9a6fac80: 00000000 00000000 00010000 0001 01 -1592509997 /tmp//kio_125_15925pc180-74.iu.hio.no_0
9fe21700: 00000000 00000000 00010000 0001 01 -1590107035 /tmp//kio_1799_24690pc217-74.iu.hio.no_0
a2e8b700: 00000001 00000000 00000000 0001 03 -1592815323 @000332fe
a88ef6c0: 00000001 00000000 00000000 0001 03 1127257542 @00011a38
9fe21440: 00000000 00000000 00010000 0001 01 -1590107025 /tmp//kfm_1799_24690pc217-74.iu.hio.no_0
a3071080: 00000000 00000000 00010000 0001 01 -1590935513 /tmp//kio_576_21656pc12-75.iu.hio.no_0
9b918f00: 00000001 00000000 00000000 0001 03 -1611622886 @00032d66
9b153440: 00000000 00000000 00000000 0001 03   186 @00000006
849a2840: 00000000 00000000 00010000 0001 01 -1590483201 /tmp//kfm_1845_23282pc153-75.iu.hio.no_0
97f4ee80: 00000000 00000000 00010000 0001 01 -1591438669 /tmp//kfm_582_18586pc106-74.iu.hio.no_0
9a784e00: 00000000 00000000 00010000 0001 01 -1594211908 /var/run/ndc
81ed7940: 00000000 00000000 00010000 0001 01 -1592509995 /tmp//kfm_125_15925pc180-74.iu.hio.no_0
849a2000: 00000001 00000000 00000000 0001 03 -1589784369 @00033517
97b4c680: 00000000 00000000 00010000 0001 01 -1593160982 /tmp//kio_239_14419pc166-75.iu.hio.no_0
a73f2700: 00000001 00000000 00000000 0001 03 -1838726939 @0002e6f0
849a22c0: 00000001 00000000 00000000 0001 03 -1589784358 /dev/log
[...]

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
