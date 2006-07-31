Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932168AbWGaGQr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbWGaGQr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 02:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932436AbWGaGQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 02:16:46 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:19295 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932168AbWGaGQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 02:16:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Pzd6VGI8ascXyBLZqA+4XCW5ubGKQbWhQ5d63ZJk8GWbpzvEg14dp2lv7NNuQxr0dL2hB1O9hMQ1bvq0/Fz7qoBFarBO0FD8pzRB6l1hleGgKUNfuFoYCIRU8dc/2wK+LchmNtBnod1RPCP6wuCcuWj/I/ku8lHxpwo6vM1ShgI=
Message-ID: <3b2bc9d0607302316s68734797r212e0a422ed26a50@mail.gmail.com>
Date: Mon, 31 Jul 2006 08:16:43 +0200
From: "marco gaddoni" <marco.gaddoni@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Fwd: PROBLEM: ide messages during boot caused by a strange partition table
In-Reply-To: <3b2bc9d0607302313p637ce780sf98b1727213bd6a2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <3b2bc9d0607302313p637ce780sf98b1727213bd6a2@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 [1.] One line summary of the problem:

ide messages during boot caused by a strange partition table

[2.] Full description of the problem/report:

hello,
i tried to install over an old win95 partition a
dos6.2.
it mangled badly the partition table and now linux
during the boot spews a lot of message like

hda: task_in_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
hda: task_in_intr: error=0x10 { SectorIdNotFound },
LBAsect=1052835654, high=62, low=12648262, sector=1052835654

ide: failed opcode was: unknown
hda: task_in_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
hda: task_in_intr: error=0x10 { SectorIdNotFound },
LBAsect=1052835654, high=62, low=12648262, sector=1052835654

ide: failed opcode was: unknown
hda: task_in_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
hda: task_in_intr: error=0x10 { SectorIdNotFound },
LBAsect=1052835654, high=62, low=12648262, sector=1052835654

ide: failed opcode was: unknown
hda: task_in_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
hda: task_in_intr: error=0x10 { SectorIdNotFound },
LBAsect=1052835654, high=62, low=12648262, sector=1052835654

ide: failed opcode was: unknown
ide0: reset: success

after about 1 minute of printing these error messages the
kernel "give up" and boot correctly.

the partition table is

Password:


Disk /dev/hda: 9733 cylinders, 255 heads, 63 sectors/track
Units = cylinders of 8225280 bytes, blocks of 1024 bytes, counting from 0

   Device Boot Start     End   #cyls    #blocks   Id  System
/dev/hda1   *      0+   1134    1135-   9116856    c  W95 FAT32 (LBA)

                end: (c,h,s) expected (1023,254,63) found (110,254,63)
/dev/hda2       1024   65535   64512  518192640    f  W95 Ext'd (LBA)
                start: (c,h,s) expected (1023,254,63) found (0,0,1)

/dev/hda3       1135    1274     140    1124550   82  Linux swap / Solaris
/dev/hda4       3858    9732    5875   47190937+  83  Linux
/dev/hda5       1024+  65535   64512- 518192608+   b  W95 FAT32
                start: (c,h,s) expected (1023,254,63) found (0,1,1)


btw: any idea on  how to recover my old partitions?

[3.] Keywords (i.e., modules, networking, kernel):

partition table, ide

[4.] Kernel version (from /proc/version):

Linux version
2.6.17.4 (gaddo@gaddo.sve.com) (gcc version 4.0.4 20060507
(prerelease) (Debian 4.0.3-3)) #1 Fri Jul 7 16:19:10 CEST 2006

[5.] Output of Oops.. message (if applicable) with symbolic information

     resolved (see Documentation/oops-tracing.txt)

see above

[6.] A small shell script or example program which triggers the
     problem (if possible)
[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)


gaddo@gaddo:~/src/linux-2.6.17.4$ sh scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux
gaddo.sve.com 2.6.17.4 #1 Fri Jul 7 16:19:10 CEST 2006 i686 GNU/Linux

Gnu C                  4.0.4
Gnu make               3.81
binutils
2.17
util-linux             2.12r
mount                  2.12r
module-init-tools      3.2.2
e2fsprogs              1.39
Linux C Library        2.3.6
Dynamic linker (ldd)   2.3.6
Procps
3.2.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.96
udev                   093
Modules Loaded         ipv6 nfsd exportfs nfs lockd sunrpc deflate
zlib_deflate twofish serpent blowfish des sha256 sha1 crypto_null
af_key dm_mod w83627hf hwmon_vid eeprom i2c_isa ide_generic shpchp
pci_hotplug ide_cd cdrom bt878 ide_disk i810_audio ac97_codec generic
tvaudio mousedev tsdev bttv video_buf firmware_class ir_common
snd_intel8x0 compat_ioctl32 i2c_algo_bit piix 8139cp 8139too e100
i2c_i801 snd_ac97_codec snd_ac97_bus v4l2_common btcx_risc tveeprom
videodev floppy rtc ide_core parport_pc parport mii i2c_core intel_agp
agpgart evdev psmouse pcspkr snd_pcm snd_timer snd soundcore ehci_hcd
uhci_hcd serio_raw snd_page_alloc usbcore ext3 jbd mbcache sd_mod
ata_piix libata scsi_mod unix



[7.2.] Processor information (from /proc/cpuinfo):
[7.3.] Module information (from /proc/modules):
[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
[7.5.] PCI information ('lspci -vvv' as root)

[7.6.] SCSI information (from /proc/scsi/scsi)
[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

[X.] Other notes, patches, fixes, workarounds:
