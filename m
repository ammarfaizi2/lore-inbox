Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129421AbQLJPr7>; Sun, 10 Dec 2000 10:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131218AbQLJPrt>; Sun, 10 Dec 2000 10:47:49 -0500
Received: from altrade.nijmegen.inter.nl.net ([193.67.237.6]:4534 "EHLO
	altrade.nijmegen.inter.nl.net") by vger.kernel.org with ESMTP
	id <S129421AbQLJPrl>; Sun, 10 Dec 2000 10:47:41 -0500
Date: Sun, 10 Dec 2000 16:17:23 +0100
From: Frank van Maarseveen <F.vanMaarseveen@inter.NL.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.0-test11 EXT2 corruption
Message-ID: <20001210161723.A1060@iapetus.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[running make depend after a fresh tar xz of a linux tree]
Dec 10 15:31:36 iapetus kernel: attempt to access beyond end of device 
Dec 10 15:31:36 iapetus kernel: 03:04: rw=0, want=1934262372, limit=6281415 
Dec 10 15:31:36 iapetus kernel: attempt to access beyond end of device 
Dec 10 15:31:36 iapetus kernel: 03:04: rw=0, want=1438848492, limit=6281415 
Dec 10 15:31:36 iapetus kernel: attempt to access beyond end of device 
Dec 10 15:31:36 iapetus kernel: 03:04: rw=0, want=564795656, limit=6281415 
Dec 10 15:31:36 iapetus kernel: attempt to access beyond end of device 
Dec 10 15:31:36 iapetus kernel: 03:04: rw=0, want=1779526748, limit=6281415 
Dec 10 15:31:36 iapetus kernel: attempt to access beyond end of device 
Dec 10 15:31:36 iapetus kernel: 03:04: rw=0, want=1934262372, limit=6281415 
Dec 10 15:31:36 iapetus kernel: attempt to access beyond end of device 
Dec 10 15:31:36 iapetus kernel: 03:04: rw=0, want=1934262372, limit=6281415 

make[4]: *** [fastdep] Error 135			(SIGBUS?)
make[4]: Leaving directory `/loc/x28/linux/drivers/scsi'
make[3]: *** [_sfdep_scsi] Error 2
make[3]: Leaving directory `/loc/x28/linux/drivers'
make[2]: *** [fastdep] Error 2
make[2]: Leaving directory `/loc/x28/linux/drivers'
make[1]: *** [_sfdep_drivers] Error 2
make[1]: Leaving directory `/loc/x28/linux'
make: *** [dep-files] Error 2

[have 192MB, decided to push everything out of memory first]
dd bs=80M count=1 conv=swab </dev/zero >/dev/null
1+0 records in
1+0 records out

[then decided to rm -rf the offending tree]
Dec 10 15:38:03 iapetus kernel: EXT2-fs error (device ide0(3,4)): ext2_free_blocks: Freeing blocks not in datazone - block = 1557307416, count = 1 
... Freeing blocks not in datazone - block = 896583034, count = 1 
... Freeing blocks not in datazone - block = 141198913, count = 1 
... Freeing blocks not in datazone - block = 1518623510, count = 1 
... Freeing blocks not in datazone - block = 1903593480, count = 1 
... Freeing blocks not in datazone - block = 188520539, count = 1 
... Freeing blocks not in datazone - block = 3263188504, count = 1 
... Freeing blocks not in datazone - block = 3976264905, count = 1 
... Freeing blocks not in datazone - block = 164289193, count = 1 
... Freeing blocks not in datazone - block = 819722194, count = 1 
... Freeing blocks not in datazone - block = 647422455, count = 1 
... Freeing blocks not in datazone - block = 2364399617, count = 1 
... Freeing blocks not in datazone - block = 1811366869, count = 1 
... Freeing blocks not in datazone - block = 2229683343, count = 1 
... Freeing blocks not in datazone - block = 2814774401, count = 1 
... Freeing blocks not in datazone - block = 227302366, count = 1 
... Freeing blocks not in datazone - block = 3802022963, count = 1 
... Freeing blocks not in datazone - block = 1287930384, count = 1 
... Freeing blocks not in datazone - block = 3876604110, count = 1 
... Freeing blocks not in datazone - block = 3299679005, count = 1 
... Freeing blocks not in datazone - block = 3498132489, count = 1 
... Freeing blocks not in datazone - block = 2566691056, count = 1 
... Freeing blocks not in datazone - block = 3869315139, count = 1 
... Freeing blocks not in datazone - block = 2671383471, count = 1 
... Freeing blocks not in datazone - block = 2620212037, count = 1 
... Freeing blocks not in datazone - block = 47276984, count = 1 
... Freeing blocks not in datazone - block = 3686076790, count = 1 
... Freeing blocks not in datazone - block = 2633603944, count = 1 
... Freeing blocks not in datazone - block = 3460325208, count = 1 
... Freeing blocks not in datazone - block = 1182494213, count = 1 
... Freeing blocks not in datazone - block = 80888211, count = 1 
... Freeing blocks not in datazone - block = 3832307999, count = 1 
... Freeing blocks not in datazone - block = 199915824, count = 1 
... Freeing blocks not in datazone - block = 3416834659, count = 1 
... Freeing blocks not in datazone - block = - block = 59890643, count = 1 
... Freeing blocks not in datazone - block = 1040159054, count = 1 
... Freeing blocks not in datazone - block = 1684592249, count = 1 
... Freeing blocks not in datazone - block = 1448050660, count = 1 
... Freeing blocks not in datazone - block = 3401569695, count = 1 
... Freeing blocks not in datazone - block = 1740947199, count = 1 
... Freeing blocks not in datazone - block = 2139462009, count = 1 
... Freeing blocks not in datazone - block = 280211182, count = 1 
... Freeing blocks not in datazone - block = 4283539120, count = 1 
... Freeing blocks not in datazone - block = 2913935317, count = 1 
... Freeing blocks not in datazone - block = 2688565944, count = 1 
... Freeing blocks not in datazone - block = 729415605, count = 1 
... Freeing blocks not in datazone - block = 82433055, count = 1 
... Freeing blocks not in datazone - block = 8797319, count = 1 
... Freeing blocks not in datazone - block = 3906552007, count = 1 
... Freeing blocks not in datazone - block = 2309047735, count = 1 
... Freeing blocks not in datazone - block = 2407009082, count = 1 
... Freeing blocks not in datazone - block = 424607534, count = 1 
... Freeing blocks not in datazone - block = 471618444, count = 1 
... Freeing blocks not in datazone - block = 1309334207, count = 1 
... Freeing blocks not in datazone - block = 965973187, count = 1 
... Freeing blocks not in datazone - block = 2138041966, count = 1 
... Freeing blocks not in datazone - block = 2655979155, count = 1 
... Freeing blocks not in datazone - block = 3925499199, count = 1 
... Freeing blocks not in datazone - block = 3996657173, count = 1 
... Freeing blocks not in datazone - block = 2693632115, count = 1 
... Freeing blocks not in datazone - block = 3961174705, count = 1 
... Freeing blocks not in datazone - block = 208665023, count = 1 
... Freeing blocks not in datazone - block = 1630375508, count = 1 
... Freeing blocks not in datazone - block = 60081614, count = 1 
... Freeing blocks not in datazone - block = 4072703481, count = 1 
... Freeing blocks not in datazone - block = 1280433605, count = 1 
... Freeing blocks not in datazone - block = 1872069493, count = 1 
... Freeing blocks not in datazone - block = 2811095671, count = 1 
... Freeing blocks not in datazone - block = 800369010, count = 1 
... Freeing blocks not in datazone - block = 3585671650, count = 1 
... Freeing blocks not in datazone - block = 3030008199, count = 1 
... Freeing blocks not in datazone - block = 1528926271, count = 1 
... Freeing blocks not in datazone - block = 3908499891, count = 1 
... Freeing blocks not in datazone - block = 2034409328, count = 1 
... Freeing blocks not in datazone - block = 36717408, count = 1 
... Freeing blocks not in datazone - block = 2319472398, count = 1 
... Freeing blocks not in datazone - block = 2926302155, count = 1 
... Freeing blocks not in datazone - block = 7922521, count = 1 
... Freeing blocks not in datazone - block = 3117202664, count = 1 
... Freeing blocks not in datazone - block = 3977804511, count = 1 
... Freeing blocks not in datazone - block = 1698931621, count = 1 
... Freeing blocks not in datazone - block = 208617862, count = 1 
... Freeing blocks not in datazone - block = 3518631517, count = 1 
... Freeing blocks not in datazone - block = 1722037333, count = 1 
... Freeing blocks not in datazone - block = 406886960, count = 1 
... Freeing blocks not in datazone - block = 1350348460, count = 1 
... Freeing blocks not in datazone - block = 3811553425, count = 1 
... Freeing blocks not in datazone - block = 3300468606, count = 1 
... Freeing blocks not in datazone - block = 581949345, count = 1 
... Freeing blocks not in datazone - block = 2739966092, count = 1 
... Freeing blocks not in datazone - block = 2418566121, count = 1 
... Freeing blocks not in datazone - block = 4197831265, count = 1 
... Freeing blocks not in datazone - block = 221713745, count = 1 
... Freeing blocks not in datazone - block = 3800944987, count = 1 
... Freeing blocks not in datazone - block = 1526217124, count = 1 
... Freeing blocks not in datazone - block = 807446554, count = 1 
... Freeing blocks not in datazone - block = 569299664, count = 1 
... Freeing blocks not in datazone - block = 4124043613, count = 1 
... Freeing blocks not in datazone - block = 2383569860, count = 1 
... Freeing blocks not in datazone - block = 1595525380, count = 1 
... Freeing blocks not in datazone - block = 665187763, count = 1 
... Freeing blocks not in datazone - block = 294411201, count = 1 
... Freeing blocks not in datazone - block = 2538196083, count = 1 
... Freeing blocks not in datazone - block = 1499544928, count = 1 
... Freeing blocks not in datazone - block = 3211874416, count = 1 
... Freeing blocks not in datazone - block = 209757245, count = 1 
... Freeing blocks not in datazone - block = 3128727337, count = 1 
... Freeing blocks not in datazone - block = 383266036, count = 1 
... Freeing blocks not in datazone - block = 1985288863, count = 1 
... Freeing blocks not in datazone - block = 3562199885, count = 1 
... Freeing blocks not in datazone - block = 4059152875, count = 1 
... Freeing blocks not in datazone - block = 1719350326, count = 1 
... Freeing blocks not in datazone - block = 1374172446, count = 1 
... Freeing blocks not in datazone - block = 3542034493, count = 1 
... Freeing blocks not in datazone - block = 2616481354, count = 1 
... Freeing blocks not in datazone - block = 74323718, count = 1 
... Freeing blocks not in datazone - block = 3904708069, count = 1 
... Freeing blocks not in datazone - block = 1275517910, count = 1 
... Freeing blocks not in datazone - block = 2391427460, count = 1 
... Freeing blocks not in datazone - block = 2673983808, count = 1 
... Freeing blocks not in datazone - block = 2906894531, count = 1 
... Freeing blocks not in datazone - block = 2799801770, count = 1 
... Freeing blocks not in datazone - block = 66908849, count = 1 
... Freeing blocks not in datazone - block = 3378841455, count = 1 
... Freeing blocks not in datazone - block = 411835620, count = 1 
... Freeing blocks not in datazone - block = 2599742227, count = 1 
... Freeing blocks not in datazone - block = 163957507, count = 1 
... Freeing blocks not in datazone - block = 1672265229, count = 1 
... Freeing blocks not in datazone - block = 2012005337, count = 1 
... Freeing blocks not in datazone - block = 1522267535, count = 1 
... Freeing blocks not in datazone - block = 1825751725, count = 1 
... Freeing blocks not in datazone - block = 1095046218, count = 1 
... Freeing blocks not in datazone - block = 2854848324, count = 1 
... Freeing blocks not in datazone - block = 831762143, count = 1 
... Freeing blocks not in datazone - block = 1941053933, count = 1 
... Freeing blocks not in datazone - block = 3974871956, count = 1 
... Freeing blocks not in datazone - block = 3979915084, count = 1 
... Freeing blocks not in datazone - block = 4102722934, count = 1 
... Freeing blocks not in datazone - block = 4195801648, count = 1 
... Freeing blocks not in datazone - block = 3905294210, count = 1 
... Freeing blocks not in datazone - block = 1302744532, count = 1 
... Freeing blocks not in datazone - block = 1196766738, count = 1 
... Freeing blocks not in datazone - block = 1290314155, count = 1 
... Freeing blocks not in datazone - block = 3232279605, count = 1 
... Freeing blocks not in datazone - block = 812585369, count = 1 
... Freeing blocks not in datazone - block = 2857485850, count = 1 
... Freeing blocks not in datazone - block = 7694995, count = 1 
... Freeing blocks not in datazone - block = 3287906514, count = 1 
... Freeing blocks not in datazone - block = 1141012974, count = 1 
... Freeing blocks not in datazone - block = 3742320097, count = 1 
... Freeing blocks not in datazone - block = 1043435421, count = 1 
... Freeing blocks not in datazone - block = 2433099239, count = 1 
... Freeing blocks not in datazone - block = 2811106121, count = 1 
... Freeing blocks not in datazone - block = 3441571780, count = 1 
... Freeing blocks not in datazone - block = 3896018699, count = 1 
... Freeing blocks not in datazone - block = 2748305294, count = 1 
... Freeing blocks not in datazone - block = 3270904206, count = 1 
... Freeing blocks not in datazone - block = 787127136, count = 1 
... Freeing blocks not in datazone - block = 3467437423, count = 1 
... Freeing blocks not in datazone - block = 3236419113, count = 1 
... Freeing blocks not in datazone - block = 1899478769, count = 1 
... Freeing blocks not in datazone - block = 2021228594, count = 1 
... Freeing blocks not in datazone - block = 3136291039, count = 1 
... Freeing blocks not in datazone - block = 129287119, count = 1 
... Freeing blocks not in datazone - block = 7703525, count = 1 
... Freeing blocks not in datazone - block = 181397538, count = 1 
... Freeing blocks not in datazone - block = 2402701298, count = 1 
... Freeing blocks not in datazone - block = 3389641806, count = 1 
... Freeing blocks not in datazone - block = 510385342, count = 1 
... Freeing blocks not in datazone - block = 595148476, count = 1 
... Freeing blocks not in datazone - block = 896681985, count = 1 
... Freeing blocks not in datazone - block = 2632903903, count = 1 
... Freeing blocks not in datazone - block = 2999921412, count = 1 
... Freeing blocks not in datazone - block = 2402809807, count = 1 

[going to runlevel 1, umounted everything]

bash# fsck -f /loc			(== /dev/hda4)
Parallelizing fsck version 1.15 (18-Jul-1999)
e2fsck 1.15, 18-Jul-1999 for EXT2 FS 0.5b, 95/08/09
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
Block bitmap differences:  -288766 -288767 -288768 -288769 -288770 -288771 -288772 -288773 -288774 -288775 -288776 -288777 -288778 -288779 -288780 -288781 -288782 -288783 -288784 -288785 -288786 -288787 -288788 -288789 -288790 -288791 -288792 -288793 -288794 -288795 -288796 -288797 -288798 -288799 -288800 -288801 -288802 -288803 -288804 -288805 -288806 -288807 -288808 -288809 -288810 -288811 +1549069
Fix<y>? yes

Free blocks count wrong for group #8 (10228, counted=10274).
Fix<y>? yes

Free blocks count wrong for group #47 (21796, counted=21795).
Fix<y>? yes

Free blocks count wrong (474566, counted=474611).


/dev/hda4: ***** FILE SYSTEM WAS MODIFIED *****
/dev/hda4: 178293/786432 files (4.7% non-contiguous), 1095742/1570353 blocks

fdisk -l /dev/hda:
Disk /dev/hda: 255 heads, 63 sectors, 1582 cylinders
Units = cylinders of 16065 * 512 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/hda1             1       600   4819468+  83  Linux
/dev/hda2           601       750   1204875   83  Linux
/dev/hda3           751       800    401625   82  Linux swap
/dev/hda4           801      1582   6281415   83  Linux

fstab:
/dev/hda1		/			ext2	defaults	1 1
/dev/hda2		/home			ext2	defaults	1 2
/boot/swap		/boot/swap		swap	defaults	0 0
/dev/cdrom		/cdrom			iso9660	noauto,user,ro	0 0
#/dev/hda3		swap			swap	defaults	0 0
/dev/hda4		/loc			ext2	defaults	1 2
/dev/fd0		/a			vfat	noauto,user	0 0
/dev/fd0		/mnt			ext2	noauto,user	0 0
#iapetus:/loc		/try			nfs	noauto,vers=2	0 0
none			/proc			proc	defaults	0 0
none			/dev/pts		devpts	gid=5,mode=620	0 0
none			/dev/shm		shm	defaults	0 0
none			/usb			usbdevfs	noauto	0 0

No other filesystems affected.

-- 
Frank
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
