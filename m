Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129387AbRB0BKV>; Mon, 26 Feb 2001 20:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129388AbRB0BKM>; Mon, 26 Feb 2001 20:10:12 -0500
Received: from ns.arraycomm.com ([199.74.167.5]:33004 "HELO
	bastion.arraycomm.com") by vger.kernel.org with SMTP
	id <S129387AbRB0BJy>; Mon, 26 Feb 2001 20:09:54 -0500
Message-Id: <5.0.2.1.2.20010226170434.026a7d68@pop.arraycomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Mon, 26 Feb 2001 17:07:59 -0800
To: linux-kernel@vger.kernel.org (Linux Kernel)
From: Jasmeet Sidhu <jsidhu@arraycomm.com>
Subject: Linux 2.4.2 DMA Interrupt poblem?
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a linux raid 5 running with primise ultra dma ata/100 cards running 
IBM ata/100 drives with the proper cables.  A lot of people have been 
submitting reports that have the similar error in the syslog.  I myself 
have two identical systems running that are giving a lot of errors, this 
one however seems to be unique.  Since these drives are brand new, I dont 
think that could cause a failure.  Maybe somebody with a little more 
knowledge could comment on this?  The drive was rough backonline and it 
seems to be functioning properly.

Jasmeet

<-- syslog -->

Feb 24 14:00:52 bertha kernel: hdi: dma_intr: status=0x51 { DriveReady 
SeekComplete Error }
Feb 24 14:00:52 bertha kernel: hdi: dma_intr: error=0x40 { 
UncorrectableError }, LBAsect=42484802, sector=42484720
Feb 24 14:00:52 bertha kernel: end_request: I/O error, dev 38:01 (hdi), 
sector 42484720
Feb 24 14:00:52 bertha kernel: raid5: Disk failure on hdi1, disabling 
device. Operation continuing on 7 devices
Feb 24 14:00:52 bertha kernel: md: recovery thread got woken up ...
Feb 24 14:00:52 bertha kernel: md0: resyncing spare disk hdc1 to replace 
failed disk
Feb 24 14:00:52 bertha kernel: RAID5 conf printout:
Feb 24 14:00:52 bertha kernel:  --- rd:8 wd:7 fd:1
Feb 24 14:00:52 bertha kernel:  disk 0, s:0, o:1, n:0 rd:0 us:1 dev:hde1
Feb 24 14:00:52 bertha kernel:  disk 1, s:0, o:1, n:1 rd:1 us:1 dev:hdg1
Feb 24 14:00:52 bertha kernel:  disk 2, s:0, o:0, n:2 rd:2 us:1 dev:hdi1
Feb 24 14:00:52 bertha kernel:  disk 3, s:0, o:1, n:3 rd:3 us:1 dev:hdk1
Feb 24 14:00:52 bertha kernel:  disk 4, s:0, o:1, n:4 rd:4 us:1 dev:hdm1
Feb 24 14:00:52 bertha kernel:  disk 5, s:0, o:1, n:5 rd:5 us:1 dev:hdo1
Feb 24 14:00:52 bertha kernel:  disk 6, s:0, o:1, n:6 rd:6 us:1 dev:hdq1
Feb 24 14:00:52 bertha kernel:  disk 7, s:0, o:1, n:7 rd:7 us:1 dev:hds1
Feb 24 14:00:52 bertha kernel: RAID5 conf printout:
Feb 24 14:00:52 bertha kernel:  --- rd:8 wd:7 fd:1
Feb 24 14:00:52 bertha kernel:  disk 0, s:0, o:1, n:0 rd:0 us:1 dev:hde1
Feb 24 14:00:52 bertha kernel:  disk 1, s:0, o:1, n:1 rd:1 us:1 dev:hdg1
Feb 24 14:00:52 bertha kernel:  disk 2, s:0, o:0, n:2 rd:2 us:1 dev:hdi1
Feb 24 14:00:52 bertha kernel:  disk 3, s:0, o:1, n:3 rd:3 us:1 dev:hdk1
Feb 24 14:00:52 bertha kernel:  disk 4, s:0, o:1, n:4 rd:4 us:1 dev:hdm1
Feb 24 14:00:52 bertha kernel:  disk 5, s:0, o:1, n:5 rd:5 us:1 dev:hdo1
Feb 24 14:00:52 bertha kernel:  disk 6, s:0, o:1, n:6 rd:6 us:1 dev:hdq1
Feb 24 14:00:52 bertha kernel:  disk 7, s:0, o:1, n:7 rd:7 us:1 dev:hds1
Feb 24 14:00:52 bertha kernel: md: syncing RAID array md0
Feb 24 14:00:52 bertha kernel: md: minimum _guaranteed_ reconstruction 
speed: 100 KB/sec/disc.
Feb 24 14:00:52 bertha kernel: md: using maximum available idle IO bandwith 
(but not more than 100000 KB/sec) for reconstruction.
Feb 24 14:00:52 bertha kernel: md: using 124k window, over a total of 
75068160 blocks.
Feb 24 14:00:52 bertha kernel: md: updating md0 RAID superblock on device
Feb 24 14:00:52 bertha kernel: hds1 [events: 00000016](write) hds1's sb 
offset: 75068160
Feb 24 14:00:52 bertha kernel: hdq1 [events: 00000016](write) hdq1's sb 
offset: 75068160
Feb 24 14:00:52 bertha kernel: hdo1 [events: 00000016](write) hdo1's sb 
offset: 75068160
Feb 24 14:00:52 bertha kernel: hdm1 [events: 00000016](write) hdm1's sb 
offset: 75068160
Feb 24 14:00:52 bertha kernel: hdk1 [events: 00000016](write) hdk1's sb 
offset: 75068160
Feb 24 14:00:52 bertha kernel: (skipping faulty hdi1 )
Feb 24 14:00:52 bertha kernel: hdg1 [events: 00000016](write) hdg1's sb 
offset: 75068160
Feb 24 14:00:52 bertha kernel: hde1 [events: 00000016](write) hde1's sb 
offset: 75068160
Feb 24 14:00:52 bertha kernel: hdc1 [events: 00000016](write) hdc1's sb 
offset: 75068160
Feb 24 14:00:52 bertha kernel: .
Feb 24 16:50:32 bertha kernel: md: md0: sync done.
Feb 24 16:50:32 bertha kernel: RAID5 conf printout:
Feb 24 16:50:32 bertha kernel:  --- rd:8 wd:7 fd:1
Feb 24 16:50:32 bertha kernel:  disk 0, s:0, o:1, n:0 rd:0 us:1 dev:hde1
Feb 24 16:50:32 bertha kernel:  disk 1, s:0, o:1, n:1 rd:1 us:1 dev:hdg1
Feb 24 16:50:32 bertha kernel:  disk 2, s:0, o:0, n:2 rd:2 us:1 dev:hdi1
Feb 24 16:50:32 bertha kernel:  disk 3, s:0, o:1, n:3 rd:3 us:1 dev:hdk1
Feb 24 16:50:32 bertha kernel:  disk 4, s:0, o:1, n:4 rd:4 us:1 dev:hdm1
Feb 24 16:50:32 bertha kernel:  disk 5, s:0, o:1, n:5 rd:5 us:1 dev:hdo1
Feb 24 16:50:32 bertha kernel:  disk 6, s:0, o:1, n:6 rd:6 us:1 dev:hdq1
Feb 24 16:50:32 bertha kernel:  disk 7, s:0, o:1, n:7 rd:7 us:1 dev:hds1
Feb 24 16:50:32 bertha kernel: RAID5 conf printout:
Feb 24 16:50:32 bertha kernel:  --- rd:8 wd:8 fd:0
Feb 24 16:50:32 bertha kernel:  disk 0, s:0, o:1, n:0 rd:0 us:1 dev:hde1
Feb 24 16:50:32 bertha kernel:  disk 1, s:0, o:1, n:1 rd:1 us:1 dev:hdg1
Feb 24 16:50:32 bertha kernel:  disk 2, s:0, o:1, n:2 rd:2 us:1 dev:hdc1
Feb 24 16:50:32 bertha kernel:  disk 3, s:0, o:1, n:3 rd:3 us:1 dev:hdk1
Feb 24 16:50:32 bertha kernel:  disk 4, s:0, o:1, n:4 rd:4 us:1 dev:hdm1
Feb 24 16:50:32 bertha kernel:  disk 5, s:0, o:1, n:5 rd:5 us:1 dev:hdo1
Feb 24 16:50:32 bertha kernel:  disk 6, s:0, o:1, n:6 rd:6 us:1 dev:hdq1
Feb 24 16:50:32 bertha kernel:  disk 7, s:0, o:1, n:7 rd:7 us:1 dev:hds1
Feb 24 16:50:32 bertha kernel: md: updating md0 RAID superblock on device

