Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932278AbWDGNU3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278AbWDGNU3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 09:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932291AbWDGNU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 09:20:29 -0400
Received: from A.painless.aaisp.net.uk ([81.187.81.51]:44441 "EHLO
	smtp.aaisp.net.uk") by vger.kernel.org with ESMTP id S932278AbWDGNU3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 09:20:29 -0400
Subject: [oops] 2.6.17-rc1
From: Andrew Clayton <andrew@rootshell.co.uk>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Fri, 07 Apr 2006 14:20:08 +0100
Message-Id: <1144416008.22650.13.camel@zeus.pccl.info>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just got the following while watching a .avi with mplayer.

System is FC4 running on a single proc AMD64 with 1GB RAM.


Unable to handle kernel NULL pointer dereference at 00000000000002e8
RIP:
<ffffffff8046a14d>{snd_pcm_oss_make_ready+29}
PGD 3ca55067 PUD 9cf5067 PMD 0
Oops: 0000 [1]
CPU 0
Pid: 9376, comm: mplayer Not tainted 2.6.17-rc1 #5
RIP: 0010:[<ffffffff8046a14d>] <ffffffff8046a14d>{snd_pcm_oss_make_ready
+29}
RSP: 0018:ffff81002a125e98  EFLAGS: 00010286
RAX: 0000000000000050 RBX: ffff81003fc6fc00 RCX: ffffffff8046af90
RDX: 00007fff67898c24 RSI: 0000000080045017 RDI: ffff81003fc6fc00
RBP: 0000000000000000 R08: ffff81002e661880 R09: 000000000a90616c
R10: 0000000044366530 R11: 0000000000000246 R12: 00007fff67898c24
R13: 0000000080045017 R14: 0000000000000000 R15: 0000000000000001
FS:  00002ad94324bac0(0000) GS:ffffffff80630000(0000)
knlGS:00000000f7bcf920
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000000002e8 CR3: 0000000031a7e000 CR4: 00000000000006e0
Process mplayer (pid: 9376, threadinfo ffff81002a124000, task
ffff810003ee44c0)
Stack: 0000000000000000 00007fff67898c24 ffff81003fc6fc00
ffffffff8046badf
       0000000000000000 ffff810003ee44c0 0000000000000000
0000000200000000
       00007fff67898c24 ffff81002e661880
Call Trace: <ffffffff8046badf>{snd_pcm_oss_ioctl+2895}
       <ffffffff80272beb>{do_ioctl+27} <ffffffff80272e8b>{vfs_ioctl+603}
       <ffffffff80272ee9>{sys_ioctl+73} <ffffffff802099de>{system_call
+126}

Code: 0f b6 95 e8 02 00 00 89 d0 83 e0 01 84 c0 74 13 e8 3e f3 ff
RIP <ffffffff8046a14d>{snd_pcm_oss_make_ready+29} RSP <ffff81002a125e98>
CR2: 00000000000002e8
 <1>Unable to handle kernel NULL pointer dereference at 0000000000000100
RIP:
<ffffffff8046ac63>{snd_pcm_oss_sync+51}
PGD 0
Oops: 0000 [2]
CPU 0
Pid: 9376, comm: mplayer Not tainted 2.6.17-rc1 #5
RIP: 0010:[<ffffffff8046ac63>] <ffffffff8046ac63>{snd_pcm_oss_sync+51}
RSP: 0018:ffff81002a125b78  EFLAGS: 00010286
RAX: ffff81003fc6fc00 RBX: ffff81003fc6fe00 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffff81002e661880 RDI: ffff81003f4cf9c0
RBP: ffff81002a125ba8 R08: 0000000000000003 R09: 00000000000005a0
R10: 0000000000000000 R11: ffffffff8048ac10 R12: ffff81003e593100
R13: 0000000000000000 R14: ffff81003fc6fc00 R15: ffff81003dc40680
FS:  00002ad94324bac0(0000) GS:ffffffff80630000(0000)
knlGS:00000000f7bcf920
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000100 CR3: 0000000031a7e000 CR4: 00000000000006e0
Process mplayer (pid: 9376, threadinfo ffff81002a124000, task
ffff810003ee44c0)
Stack: ffff81003f4cf9c0 ffff81003fc6fe00 ffff81003e593100
ffff81002e661880
       ffff81003e0f7dc0 ffff81003dc40680 ffff81003f4cf9c0
ffffffff8046af2b
       ffff81002e661880 0000000000000008
Call Trace: <ffffffff8046af2b>{snd_pcm_oss_release+59}
       <ffffffff80262132>{__fput+194} <ffffffff8025f848>{filp_close+104}
       <ffffffff8022826a>{put_files_struct+122}
<ffffffff802294c1>{do_exit+593}
       <ffffffff803ae267>{do_unblank_screen+119}
<ffffffff80219b65>{do_page_fault+2037}
       <ffffffff8048aedc>{do_sock_write+172}
<ffffffff8048b44f>{sock_aio_write+79}
       <ffffffff8020a30d>{error_exit+0}
<ffffffff8046af90>{snd_pcm_oss_ioctl+0}
       <ffffffff8046a14d>{snd_pcm_oss_make_ready+29}
<ffffffff8046badf>{snd_pcm_oss_ioctl+2895}
       <ffffffff80272beb>{do_ioctl+27} <ffffffff80272e8b>{vfs_ioctl+603}
       <ffffffff80272ee9>{sys_ioctl+73} <ffffffff802099de>{system_call
+126}

Code: 41 8b 85 00 01 00 00 85 c0 0f 85 d2 01 00 00 4c 89 f7 e8 b6
RIP <ffffffff8046ac63>{snd_pcm_oss_sync+51} RSP <ffff81002a125b78>
CR2: 0000000000000100
 <1>Fixing recursive fault but reboot is needed!


