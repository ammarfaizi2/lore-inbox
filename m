Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292554AbSBZLV4>; Tue, 26 Feb 2002 06:21:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292538AbSBZLVs>; Tue, 26 Feb 2002 06:21:48 -0500
Received: from voyager.st-peter.stw.uni-erlangen.de ([131.188.24.132]:40117
	"EHLO voyager.st-peter.stw.uni-erlangen.de") by vger.kernel.org
	with ESMTP id <S292283AbSBZLVd>; Tue, 26 Feb 2002 06:21:33 -0500
Message-ID: <3C7B6FDE.4090308@st-peter.stw.uni-erlangen.de>
Date: Tue, 26 Feb 2002 12:22:06 +0100
From: svetljo <galia@st-peter.stw.uni-erlangen.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: linux-2.5.5-xfs-dj1 troubles (raid0_make_request bug)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanner: exiscan *16fffd-0000Nb-00*cdoHTTZfJsA* (Studentenwohnanlage Nuernberg St.-Peter)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
i'd like to ask you to CC me because i'm not subscribed to the lists

i'm having some interesting troubles
i have lvm over soft RAID-0 with LV's formated with XFS and JFS
i can work with the JFS LV's,
 but i can not with the XFS one's, i can not mount them ( no troubles 
with XFS normal partitions)

so
i'd like to ask is this problem with XFS or with raid or lvm
and is there a way to fix it

thanks for your help

here is what i found in dmesg

##################################################################################### 

id0: zone 2
raid0: checking ide/host2/bus0/target0/lun0/part8 ... contained as device 0
  (2859456) is smallest!.
raid0: checking ide/host3/bus0/target0/lun0/part10 ... nope.
raid0: checking ide/host3/bus0/target1/lun0/part6 ... nope.
raid0: zone->nb_dev: 1, size: 249024
raid0: current zone offset: 2859456
raid0: done.
raid0 : md_size is 8064256 blocks.
raid0 : conf->smallest->size is 32128 blocks.
raid0 : nb_zone is 252.
raid0 : Allocating 2016 bytes for hash.
md: updating md0 RAID superblock on device
md: ide/host3/bus0/target1/lun0/part6 [events: 000002f3]<6>(write) 
ide/host3/bus0/target1/lun0/part6's sb offset: 2610432
md: ide/host3/bus0/target0/lun0/part10 [events: 000002f3]<6>(write) 
ide/host3/bus0/target0/lun0/part10's sb offset: 2594368
md: ide/host2/bus0/target0/lun0/part8 [events: 000002f3]<6>(write) 
ide/host2/bus0/target0/lun0/part8's sb offset: 2859456
md: considering ide/host3/bus0/target1/lun0/part5 ...
md:  adding ide/host3/bus0/target1/lun0/part5 ...
md:  adding ide/host3/bus0/target0/lun0/part8 ...
md:  adding ide/host2/bus0/target0/lun0/part7 ...
md: created md2
md: bind<ide/host2/bus0/target0/lun0/part7,1>
md: bind<ide/host3/bus0/target0/lun0/part8,2>
md: bind<ide/host3/bus0/target1/lun0/part5,3>
md: running: 
<ide/host3/bus0/target1/lun0/part5><ide/host3/bus0/target0/lun0/part8><ide/host2/bus0/target0/lun0/part7>
md: ide/host3/bus0/target1/lun0/part5's event counter: 0000031a
md: ide/host3/bus0/target0/lun0/part8's event counter: 0000031a
md: ide/host2/bus0/target0/lun0/part7's event counter: 0000031a
md2: max total readahead window set to 744k
md2: 3 data-disks, max readahead per data-disk: 248k
raid0: looking at ide/host2/bus0/target0/lun0/part7
raid0:   comparing ide/host2/bus0/target0/lun0/part7(4096448) with 
ide/host2/bus0/target0/lun0/part7(4096448)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at ide/host3/bus0/target0/lun0/part8
raid0:   comparing ide/host3/bus0/target0/lun0/part8(4096448) with 
ide/host2/bus0/target0/lun0/part7(4096448)
raid0:   EQUAL
raid0: looking at ide/host3/bus0/target1/lun0/part5
raid0:   comparing ide/host3/bus0/target1/lun0/part5(4096448) with 
ide/host2/bus0/target0/lun0/part7(4096448)
raid0:   EQUAL
raid0: FINAL 1 zones
raid0: zone 0
raid0: checking ide/host2/bus0/target0/lun0/part7 ... contained as device 0
  (4096448) is smallest!.
raid0: checking ide/host3/bus0/target0/lun0/part8 ... contained as device 1
raid0: checking ide/host3/bus0/target1/lun0/part5 ... contained as device 2
raid0: zone->nb_dev: 3, size: 12289344
raid0: current zone offset: 4096448
raid0: done.
raid0 : md_size is 12289344 blocks.
raid0 : conf->smallest->size is 12289344 blocks.
raid0 : nb_zone is 1.
raid0 : Allocating 8 bytes for hash.
md: updating md2 RAID superblock on device
md: ide/host3/bus0/target1/lun0/part5 [events: 0000031b]<6>(write) 
ide/host3/bus0/target1/lun0/part5's sb offset: 4096448
md: ide/host3/bus0/target0/lun0/part8 [events: 0000031b]<6>(write) 
ide/host3/bus0/target0/lun0/part8's sb offset: 4096448
md: ide/host2/bus0/target0/lun0/part7 [events: 0000031b]<6>(write) 
ide/host2/bus0/target0/lun0/part7's sb offset: 4096448
md: considering ide/host3/bus0/target0/lun0/part12 ...
md:  adding ide/host3/bus0/target0/lun0/part12 ...
md:  adding ide/host3/bus0/target0/lun0/part6 ...
md:  adding ide/host3/bus0/target0/lun0/part5 ...
md:  adding ide/host3/bus0/target0/lun0/part1 ...
md: created md6
md: bind<ide/host3/bus0/target0/lun0/part1,1>
md6: WARNING: ide/host3/bus0/target0/lun0/part5 appears to be on the 
same physical disk as ide/host3/bus0/target0/lun0/part1. True
     protection against single-disk failure might be compromised.
md: bind<ide/host3/bus0/target0/lun0/part5,2>
md6: WARNING: ide/host3/bus0/target0/lun0/part6 appears to be on the 
same physical disk as ide/host3/bus0/target0/lun0/part5. True
     protection against single-disk failure might be compromised.
md: bind<ide/host3/bus0/target0/lun0/part6,3>
md6: WARNING: ide/host3/bus0/target0/lun0/part12 appears to be on the 
same physical disk as ide/host3/bus0/target0/lun0/part6. True
     protection against single-disk failure might be compromised.
md: bind<ide/host3/bus0/target0/lun0/part12,4>
md: running: 
<ide/host3/bus0/target0/lun0/part12><ide/host3/bus0/target0/lun0/part6><ide/host3/bus0/target0/lun0/part5><ide/host3/bus0/target0/lun0/part1>
md: ide/host3/bus0/target0/lun0/part12's event counter: 00000391
md: ide/host3/bus0/target0/lun0/part6's event counter: 00000391
md: ide/host3/bus0/target0/lun0/part5's event counter: 00000391
md: ide/host3/bus0/target0/lun0/part1's event counter: 00000391
md6: max total readahead window set to 124k
md6: 1 data-disks, max readahead per data-disk: 124k
md: updating md6 RAID superblock on device
md: ide/host3/bus0/target0/lun0/part12 [events: 00000392]<6>(write) 
ide/host3/bus0/target0/lun0/part12's sb offset: 9759360
md: ide/host3/bus0/target0/lun0/part6 [events: 00000392]<6>(write) 
ide/host3/bus0/target0/lun0/part6's sb offset: 513984
md: ide/host3/bus0/target0/lun0/part5 [events: 00000392]<6>(write) 
ide/host3/bus0/target0/lun0/part5's sb offset: 2088320
md: ide/host3/bus0/target0/lun0/part1 [events: 00000392]<6>(write) 
ide/host3/bus0/target0/lun0/part1's sb offset: 2048192
md: considering ide/host2/bus0/target0/lun0/part11 ...
md:  adding ide/host2/bus0/target0/lun0/part11 ...
md:  adding ide/host2/bus0/target0/lun0/part6 ...
md: created md7
md: bind<ide/host2/bus0/target0/lun0/part6,1>
md7: WARNING: ide/host2/bus0/target0/lun0/part11 appears to be on the 
same physical disk as ide/host2/bus0/target0/lun0/part6. True
     protection against single-disk failure might be compromised.
md: bind<ide/host2/bus0/target0/lun0/part11,2>
md: running: 
<ide/host2/bus0/target0/lun0/part11><ide/host2/bus0/target0/lun0/part6>
md: ide/host2/bus0/target0/lun0/part11's event counter: 000003bf
md: ide/host2/bus0/target0/lun0/part6's event counter: 000003bf
md7: max total readahead window set to 124k
md7: 1 data-disks, max readahead per data-disk: 124k
md: updating md7 RAID superblock on device
md: ide/host2/bus0/target0/lun0/part11 [events: 000003c0]<6>(write) 
ide/host2/bus0/target0/lun0/part11's sb offset: 10514432
md: ide/host2/bus0/target0/lun0/part6 [events: 000003c0]<6>(write) 
ide/host2/bus0/target0/lun0/part6's sb offset: 3421696
md: ... autorun DONE.
LVM version 1.0.1-rc4(ish)(03/10/2001)
IEEE 802.2 LLC for Linux 2.1 (c) 1996 Tim Alpaerts
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 131072 bind 65536)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device 22:4b, size 8192, journal first block 
18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (ide3(34,75)) for (ide3(34,75))
Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 256k freed
Real Time Clock Driver v1.10e
loop: loaded (max 32 devices)
mice: PS/2 mouse device common for all mice
cdrom: open failed.
VFS: Disk change detected on device ide1(22,0)
Adding Swap: 473876k swap-space (priority 1)
Adding Swap: 457812k swap-space (priority 1)
Adding Swap: 473876k swap-space (priority 1)


XFS mounting filesystem lvm(58,2)
raid0_make_request bug: can't convert block across chunks or bigger than 
16k 8323317 64
raid0_make_request bug: can't convert block across chunks or bigger than 
16k 8323445 64
I/O error in filesystem ("lvm(58,2)") meta-data dev 0xc0223a02 block 
0x601f7d
       ("xlog_bread") error 5 buf count 131072
raid0_make_request bug: can't convert block across chunks or bigger than 
16k 8324829 29
I/O error in filesystem ("lvm(58,2)") meta-data dev 0xc0223a02 block 
0x602565
       ("xlog_bread") error 5 buf count 30208
XFS: failed to find log head
XFS: log mount/recovery failed
XFS: log mount failed
XFS mounting filesystem lvm(58,3)
XFS: WARNING: recovery required on readonly filesystem.
XFS: write access will be enabled during mount.
Starting XFS recovery on filesystem: lvm(58,3) (dev: 58/3)
XFS: xlog_recover_process_data: bad clientid
XFS: log mount/recovery failed
XFS: log mount failed
XFS mounting filesystem lvm(58,1)
raid0_make_request bug: can't convert block across chunks or bigger than 
16k 23610115 64
raid0_make_request bug: can't convert block across chunks or bigger than 
16k 23610243 64
I/O error in filesystem ("lvm(58,1)") meta-data dev 0xc0223a01 block 
0xa0218b
       ("xlog_bread") error 5 buf count 131072
raid0_make_request bug: can't convert block across chunks or bigger than 
16k 23611101 29
I/O error in filesystem ("lvm(58,1)") meta-data dev 0xc0223a01 block 
0xa02565
       ("xlog_bread") error 5 buf count 30208
XFS: failed to find log head
XFS: log mount/recovery failed
XFS: log mount failed

XFS mounting filesystem lvm(58,2)
raid0_make_request bug: can't convert block across chunks or bigger than 
16k 8323317 64
raid0_make_request bug: can't convert block across chunks or bigger than 
16k 8323445 64
I/O error in filesystem ("lvm(58,2)") meta-data dev 0xc0223a02 block 
0x601f7d
       ("xlog_bread") error 5 buf count 131072
raid0_make_request bug: can't convert block across chunks or bigger than 
16k 8324829 29
I/O error in filesystem ("lvm(58,2)") meta-data dev 0xc0223a02 block 
0x602565
       ("xlog_bread") error 5 buf count 30208
XFS: failed to find log head
XFS: log mount/recovery failed
XFS: log mount failed
XFS mounting filesystem lvm(58,3)
XFS: WARNING: recovery required on readonly filesystem.
XFS: write access will be enabled during mount.
Starting XFS recovery on filesystem: lvm(58,3) (dev: 58/3)
XFS: xlog_recover_process_data: bad clientid
XFS: log mount/recovery failed
XFS: log mount failed
XFS mounting filesystem lvm(58,1)
raid0_make_request bug: can't convert block across chunks or bigger than 
16k 23610115 64
raid0_make_request bug: can't convert block across chunks or bigger than 
16k 23610243 64
I/O error in filesystem ("lvm(58,1)") meta-data dev 0xc0223a01 block 
0xa0218b
       ("xlog_bread") error 5 buf count 131072
raid0_make_request bug: can't convert block across chunks or bigger than 
16k 23611101 29
I/O error in filesystem ("lvm(58,1)") meta-data dev 0xc0223a01 block 
0xa02565
       ("xlog_bread") error 5 buf count 30208
XFS: failed to find log head
XFS: log mount/recovery failed
XFS: log mount failed


