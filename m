Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129136AbQKSMLb>; Sun, 19 Nov 2000 07:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129153AbQKSMLV>; Sun, 19 Nov 2000 07:11:21 -0500
Received: from [63.193.79.18] ([63.193.79.18]:18928 "HELO mwg.inxservices.lan")
	by vger.kernel.org with SMTP id <S129136AbQKSMLF>;
	Sun, 19 Nov 2000 07:11:05 -0500
Date: Sun, 19 Nov 2000 03:39:43 -0800
From: George Garvey <tmwg-linuxknl@inxservices.com>
To: linux-kernel@vger.kernel.org
Subject: What is 2.4.0-test10: md1 has overlapping physical units with md2!
Message-ID: <20001119033943.C935@inxservices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: inX Services, Los Angeles, CA, USA
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is this something to be concerned about? It sounds like a disaster waiting
to happen from the message. This is on 2 systems (with similar disk setups
[same other than size]).



dmesg from bootup:
Nov 18 16:31:01 mwg kernel: md driver 0.90.0 MAX_MD_DEVS=256, MAX_REAL=12  
Nov 18 16:31:01 mwg kernel: raid1 personality registered  
Nov 18 16:31:01 mwg kernel: md.c: sizeof(mdp_super_t) = 4096  
Nov 18 16:31:01 mwg kernel: autodetecting RAID arrays  
Nov 18 16:31:01 mwg kernel: (read) ide/host0/bus0/target0/lun0/part1's sb offset: 524544 [events: 00000056]  
Nov 18 16:31:01 mwg kernel: (read) ide/host0/bus0/target0/lun0/part3's sb offset: 4194688 [events: 00000055]  
Nov 18 16:31:01 mwg kernel: (read) ide/host0/bus0/target0/lun0/part4's sb offset: 24771008 [events: 00000058]  
Nov 18 16:31:01 mwg kernel: (read) ide/host0/bus1/target0/lun0/part1's sb offset: 524544 [events: 00000056]  
Nov 18 16:31:01 mwg kernel: (read) ide/host0/bus1/target0/lun0/part3's sb offset: 4194688 [events: 00000055]  
Nov 18 16:31:01 mwg kernel: (read) ide/host0/bus1/target0/lun0/part4's sb offset: 24771008 [events: 00000058]  
Nov 18 16:31:01 mwg kernel: autorun ...  
Nov 18 16:31:01 mwg kernel: considering ide/host0/bus1/target0/lun0/part4 ...  
Nov 18 16:31:01 mwg kernel:   adding ide/host0/bus1/target0/lun0/part4 ...  
Nov 18 16:31:01 mwg kernel:   adding ide/host0/bus0/target0/lun0/part4 ...  
Nov 18 16:31:01 mwg kernel: created md2  
Nov 18 16:31:01 mwg kernel: bind<ide/host0/bus0/target0/lun0/part4,1>  
Nov 18 16:31:01 mwg kernel: bind<ide/host0/bus1/target0/lun0/part4,2>  
Nov 18 16:31:01 mwg kernel: running: <ide/host0/bus1/target0/lun0/part4><ide/host0/bus0/target0/lun0/part4>  
Nov 18 16:31:01 mwg kernel: now!  
Nov 18 16:31:01 mwg kernel: ide/host0/bus1/target0/lun0/part4's event counter: 00000058  
Nov 18 16:31:01 mwg kernel: ide/host0/bus0/target0/lun0/part4's event counter: 00000058  
Nov 18 16:31:01 mwg kernel: md: md2: raid array is not clean -- starting background reconstruction  
Nov 18 16:31:01 mwg kernel: md2: max total readahead window set to 124k  
Nov 18 16:31:01 mwg kernel: md2: 1 data-disks, max readahead per data-disk: 124k  
Nov 18 16:31:01 mwg kernel: raid1: device ide/host0/bus1/target0/lun0/part4 operational as mirror 1  
Nov 18 16:31:01 mwg kernel: raid1: device ide/host0/bus0/target0/lun0/part4 operational as mirror 0  
Nov 18 16:31:01 mwg kernel: raid1: raid set md2 not clean; reconstructing mirrors  
Nov 18 16:31:01 mwg kernel: raid1: raid set md2 active with 2 out of 2 mirrors  
Nov 18 16:31:01 mwg kernel: md: updating md2 RAID superblock on device  
Nov 18 16:31:01 mwg kernel: ide/host0/bus1/target0/lun0/part4 [events: 00000059](write) ide/host0/bus1/target0/lun0/part4's sb offset: 24771008  
Nov 18 16:31:01 mwg kernel: md: syncing RAID array md2  
Nov 18 16:31:01 mwg kernel: md: minimum _guaranteed_ reconstruction speed: 100 KB/sec/disc.  
Nov 18 16:31:01 mwg kernel: md: using maximum available idle IO bandwith (but not more than 100000 KB/sec) for reconstruction.  
Nov 18 16:31:01 mwg kernel: md: using 124k window, over a total of 24771008 blocks.  
Nov 18 16:31:01 mwg kernel: ide/host0/bus0/target0/lun0/part4 [events: 00000059](write) ide/host0/bus0/target0/lun0/part4's sb offset: 24771008  
Nov 18 16:31:01 mwg kernel: .  
Nov 18 16:31:01 mwg kernel: considering ide/host0/bus1/target0/lun0/part3 ...  
Nov 18 16:31:02 mwg kernel:   adding ide/host0/bus1/target0/lun0/part3 ...  
Nov 18 16:31:02 mwg kernel:   adding ide/host0/bus0/target0/lun0/part3 ...  
Nov 18 16:31:02 mwg kernel: created md1  
Nov 18 16:31:02 mwg kernel: bind<ide/host0/bus0/target0/lun0/part3,1>  
Nov 18 16:31:02 mwg kernel: bind<ide/host0/bus1/target0/lun0/part3,2>  
Nov 18 16:31:02 mwg kernel: running: <ide/host0/bus1/target0/lun0/part3><ide/host0/bus0/target0/lun0/part3>  
Nov 18 16:31:02 mwg kernel: now!  
Nov 18 16:31:02 mwg kernel: ide/host0/bus1/target0/lun0/part3's event counter: 00000055  
Nov 18 16:31:02 mwg kernel: ide/host0/bus0/target0/lun0/part3's event counter: 00000055  
Nov 18 16:31:02 mwg kernel: md: md1: raid array is not clean -- starting background reconstruction  
Nov 18 16:31:02 mwg kernel: md1: max total readahead window set to 124k  
Nov 18 16:31:02 mwg kernel: md1: 1 data-disks, max readahead per data-disk: 124k  
Nov 18 16:31:02 mwg kernel: raid1: device ide/host0/bus1/target0/lun0/part3 operational as mirror 1  
Nov 18 16:31:02 mwg kernel: raid1: device ide/host0/bus0/target0/lun0/part3 operational as mirror 0  
Nov 18 16:31:02 mwg kernel: raid1: raid set md1 not clean; reconstructing mirrors  
Nov 18 16:31:02 mwg kernel: raid1: raid set md1 active with 2 out of 2 mirrors  
Nov 18 16:31:02 mwg kernel: md: updating md1 RAID superblock on device  
Nov 18 16:31:02 mwg kernel: ide/host0/bus1/target0/lun0/part3 [events: 00000056](write) ide/host0/bus1/target0/lun0/part3's sb offset: 4194688  
Nov 18 16:31:02 mwg kernel: md: serializing resync, md1 has overlapping physical units with md2!  
Nov 18 16:31:02 mwg kernel: ide/host0/bus0/target0/lun0/part3 [events: 00000056](write) ide/host0/bus0/target0/lun0/part3's sb offset: 4194688  
Nov 18 16:31:02 mwg kernel: .  
Nov 18 16:31:02 mwg kernel: considering ide/host0/bus1/target0/lun0/part1 ...  
Nov 18 16:31:02 mwg kernel:   adding ide/host0/bus1/target0/lun0/part1 ...  
Nov 18 16:31:02 mwg kernel:   adding ide/host0/bus0/target0/lun0/part1 ...  
Nov 18 16:31:02 mwg kernel: created md0  
Nov 18 16:31:02 mwg kernel: bind<ide/host0/bus0/target0/lun0/part1,1>  
Nov 18 16:31:02 mwg kernel: bind<ide/host0/bus1/target0/lun0/part1,2>  
Nov 18 16:31:02 mwg kernel: running: <ide/host0/bus1/target0/lun0/part1><ide/host0/bus0/target0/lun0/part1>  
Nov 18 16:31:02 mwg kernel: now!  
Nov 18 16:31:02 mwg kernel: ide/host0/bus1/target0/lun0/part1's event counter: 00000056  
Nov 18 16:31:02 mwg kernel: ide/host0/bus0/target0/lun0/part1's event counter: 00000056  
Nov 18 16:31:02 mwg kernel: md: md0: raid array is not clean -- starting background reconstruction  
Nov 18 16:31:02 mwg kernel: md0: max total readahead window set to 124k  
Nov 18 16:31:02 mwg kernel: md0: 1 data-disks, max readahead per data-disk: 124k  
Nov 18 16:31:02 mwg kernel: raid1: device ide/host0/bus1/target0/lun0/part1 operational as mirror 1  
Nov 18 16:31:02 mwg kernel: raid1: device ide/host0/bus0/target0/lun0/part1 operational as mirror 0  
Nov 18 16:31:02 mwg kernel: raid1: raid set md0 not clean; reconstructing mirrors  
Nov 18 16:31:02 mwg kernel: raid1: raid set md0 active with 2 out of 2 mirrors  
Nov 18 16:31:02 mwg kernel: md: updating md0 RAID superblock on device  
Nov 18 16:31:02 mwg kernel: ide/host0/bus1/target0/lun0/part1 [events: 00000057](write) ide/host0/bus1/target0/lun0/part1's sb offset: 524544  
Nov 18 16:31:02 mwg kernel: md: serializing resync, md0 has overlapping physical units with md2!  
Nov 18 16:31:02 mwg kernel: ide/host0/bus0/target0/lun0/part1 [events: 00000057](write) ide/host0/bus0/target0/lun0/part1's sb offset: 524544  
Nov 18 16:31:02 mwg kernel: .  
Nov 18 16:31:02 mwg kernel: ... autorun DONE.  




fdisk:
	/dev/hda:
kernel version 132096

Command (m for help): 
Disk /dev/hda: 16 heads, 63 sectors, 59554 cylinders
Units = cylinders of 1008 * 512 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/hda1             1      1041    524632+  fd  Linux raid autodetect
/dev/hda2          1042      2082    524664   82  Linux swap
/dev/hda3          2083     10405   4194792   fd  Linux raid autodetect
/dev/hda4         10406     59554  24771096   fd  Linux raid autodetect

Command (m for help): 
	/dev/hdc:
kernel version 132096

Command (m for help): 
Disk /dev/hdc: 16 heads, 63 sectors, 59554 cylinders
Units = cylinders of 1008 * 512 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/hdc1             1      1041    524632+  fd  Linux raid autodetect
/dev/hdc2          1042      2082    524664   82  Linux swap
/dev/hdc3          2083     10405   4194792   fd  Linux raid autodetect
/dev/hdc4         10406     59554  24771096   fd  Linux raid autodetect

Command (m for help): 



/etc/raidtab:
raiddev	/dev/md/0
	raid-level		1
	nr-raid-disks		2
	nr-spare-disks		0
	chunk-size		32
	persistent-superblock	1
	device			/dev/ide/host0/bus0/target0/lun0/part1
	raid-disk		0
	device			/dev/ide/host0/bus1/target0/lun0/part1
	raid-disk		1
raiddev	/dev/md/1
	raid-level		1
	nr-raid-disks		2
	nr-spare-disks		0
	chunk-size		32
	persistent-superblock	1
	device			/dev/ide/host0/bus0/target0/lun0/part3
	raid-disk		0
	device			/dev/ide/host0/bus1/target0/lun0/part3
	raid-disk		1
raiddev	/dev/md/2
	raid-level		1
	nr-raid-disks		2
	nr-spare-disks		0
	chunk-size		32
	persistent-superblock	1
	device			/dev/ide/host0/bus0/target0/lun0/part4
	raid-disk		0
	device			/dev/ide/host0/bus1/target0/lun0/part4
	raid-disk		1




/proc/mdstat:
Personalities : [raid1] 
read_ahead 1024 sectors
md0 : active raid1 ide/host0/bus1/target0/lun0/part1[1] ide/host0/bus0/target0/lun0/part1[0]
      524544 blocks [2/2] [UU]
      
md1 : active raid1 ide/host0/bus1/target0/lun0/part3[1] ide/host0/bus0/target0/lun0/part3[0]
      4194688 blocks [2/2] [UU]
      
md2 : active raid1 ide/host0/bus1/target0/lun0/part4[1] ide/host0/bus0/target0/lun0/part4[0]
      24771008 blocks [2/2] [UU]
      
unused devices: <none>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
