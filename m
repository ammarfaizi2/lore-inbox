Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262093AbULCI7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262093AbULCI7O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 03:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262096AbULCI7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 03:59:14 -0500
Received: from th00.ifrance.com ([82.196.4.10]:4358 "HELO th00.idoo.com")
	by vger.kernel.org with SMTP id S262093AbULCI62 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 03:58:28 -0500
Send-By: 213.30.144.178 with Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0)
To: <linux-kernel@vger.kernel.org>
Subject: Kernel 2.6.9 oops during data transfer to noname usb key
From: "Olivier RAMAT" <olrt@ifrance.com>
X-Priority: 3 (normal)
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Date: Fri, 3 Dec 2004 08:57:55 GMT
Message-id: <0412030857.370100@th00.idoo.com>
if-filter0: Y
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello !
This is my first post to the linux.kernel mailing list so please
apologize ;-)

Here's the oops that I experienced while copying files to my noname
usb key :

-----------------------------8<----------------------------------------

Nov 10 07:47:10 darkstar kernel: SCSI error : <0 0 0 0> return code =
0x70000
Nov 10 07:47:10 darkstar kernel: end_request: I/O error, dev sda, sector
348962
Nov 10 07:47:10 darkstar kernel: Buffer I/O error on device sda1,
logical block 348899
Nov 10 07:47:10 darkstar kernel: lost page write due to I/O error on
sda1
Nov 10 07:47:10 darkstar kernel: SCSI error : <0 0 0 0> return code =
0x70000
Nov 10 07:47:10 darkstar kernel: end_request: I/O error, dev sda, sector
348963
Nov 10 07:47:10 darkstar kernel: Buffer I/O error on device sda1,
logical block 348900
Nov 10 07:47:10 darkstar kernel: lost page write due to I/O error on
sda1
Nov 10 07:47:10 darkstar kernel: SCSI error : <0 0 0 0> return code =
0x70000
Nov 10 07:47:10 darkstar kernel: end_request: I/O error, dev sda, sector
348964
Nov 10 07:47:10 darkstar kernel: Buffer I/O error on device sda1,
logical block 348901
Nov 10 07:47:10 darkstar kernel: lost page write due to I/O error on
sda1
Nov 10 07:47:10 darkstar kernel: SCSI error : <0 0 0 0> return code =
0x70000
Nov 10 07:47:10 darkstar kernel: end_request: I/O error, dev sda, sector
348965
Nov 10 07:47:10 darkstar kernel: Buffer I/O error on device sda1,
logical block 348902
Nov 10 07:47:10 darkstar kernel: lost page write due to I/O error on
sda1
Nov 10 07:47:10 darkstar kernel: SCSI error : <0 0 0 0> return code =
0x70000
Nov 10 07:47:10 darkstar kernel: end_request: I/O error, dev sda, sector
348966
Nov 10 07:47:10 darkstar kernel: Buffer I/O error on device sda1,
logical block 348903
Nov 10 07:47:10 darkstar kernel: lost page write due to I/O error on
sda1
Nov 10 07:47:10 darkstar kernel: SCSI error : <0 0 0 0> return code =
0x70000
Nov 10 07:47:10 darkstar kernel: end_request: I/O error, dev sda, sector
348967
Nov 10 07:47:10 darkstar kernel: Buffer I/O error on device sda1,
logical block 348904
Nov 10 07:47:10 darkstar kernel: lost page write due to I/O error on
sda1
Nov 10 07:47:10 darkstar kernel: SCSI error : <0 0 0 0> return code =
0x70000
Nov 10 07:47:10 darkstar kernel: end_request: I/O error, dev sda, sector
348968
Nov 10 07:47:10 darkstar kernel: Buffer I/O error on device sda1,
logical block 348905
Nov 10 07:47:10 darkstar kernel: lost page write due to I/O error on
sda1
Nov 10 07:47:10 darkstar kernel: SCSI error : <0 0 0 0> return code =
0x70000
Nov 10 07:47:10 darkstar kernel: end_request: I/O error, dev sda, sector
348969
Nov 10 07:47:10 darkstar kernel: Buffer I/O error on device sda1,
logical block 348906
Nov 10 07:47:10 darkstar kernel: lost page write due to I/O error on
sda1
Nov 10 07:47:40 darkstar kernel: sd 0:0:0:0: Illegal state transition
cancel->offline
Nov 10 07:47:40 darkstar kernel: Badness in scsi_device_set_state at
/usr/src/linux-2.6.9/drivers/scsi/scsi_lib.c:1688
Nov 10 07:47:40 darkstar kernel:  [<c029ebae>]
scsi_device_set_state+0xce/0x120
Nov 10 07:47:40 darkstar kernel:  [<c029c814>]
scsi_eh_offline_sdevs+0x64/0x80
Nov 10 07:47:40 darkstar kernel:  [<c029ccb6>] scsi_unjam_host+0xc6/0xd0
Nov 10 07:47:40 darkstar kernel:  [<c029cd61>]
scsi_error_handler+0xa1/0xd0
Nov 10 07:47:40 darkstar kernel:  [<c029ccc0>]
scsi_error_handler+0x0/0xd0
Nov 10 07:47:40 darkstar kernel:  [<c0103f25>]
kernel_thread_helper+0x5/0x10
Nov 10 07:47:40 darkstar kernel: SCSI error : <0 0 0 0> return code =
0x70000
Nov 10 07:47:40 darkstar kernel: end_request: I/O error, dev sda, sector
348970
Nov 10 07:47:40 darkstar kernel: Buffer I/O error on device sda1,
logical block 348907
Nov 10 07:47:40 darkstar kernel: lost page write due to I/O error on
sda1
Nov 10 07:47:50 darkstar kernel: ------------[ cut here ]------------
Nov 10 07:47:50 darkstar kernel: kernel BUG at
/usr/src/linux-2.6.9/drivers/block/as-iosched.c:1853!
Nov 10 07:47:50 darkstar kernel: invalid operand: 0000 [#1]
Nov 10 07:47:50 darkstar kernel: PREEMPT 
Nov 10 07:47:50 darkstar kernel: Modules linked in: apm usb_storage
snd_pcm_oss snd_mixer_oss snd_via82xx snd_ac97_codec snd_pcm snd_timer
snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore
8250 serial_core parport_pc lp parport uhci_hcd ohci_hcd ehci_hcd
usbcore ide_scsi agpgart
Nov 10 07:47:50 darkstar kernel: CPU:    0
Nov 10 07:47:50 darkstar kernel: EIP:    0060:[<c025d4c2>]    Not
tainted VLI
Nov 10 07:47:50 darkstar kernel: EFLAGS: 00010216   (2.6.9) 
Nov 10 07:47:50 darkstar kernel: EIP is at as_exit+0x62/0x80
Nov 10 07:47:50 darkstar kernel: eax: c11733ac   ebx: c11733a0   ecx:
c13ae088   edx: 00000001
Nov 10 07:47:50 darkstar kernel: esi: c13ae114   edi: 00000282   ebp:
c11662b4   esp: c5ba7eb4
Nov 10 07:47:50 darkstar kernel: ds: 007b   es: 007b   ss: 0068
Nov 10 07:47:50 darkstar kernel: Process scsi_eh_0 (pid: 1633,
threadinfo=c5ba6000 task=c5108020)
Nov 10 07:47:50 darkstar kernel: Stack: c117341c c13ae088 c0253dfe
c13ae088 c13ae094 c0255fc8 c13ae088 c116650c 
Nov 10 07:47:50 darkstar kernel:        c5b69424 c5b69400 c02a08c8
c13ae088 c5b695a8 c03fc7f0 c03fc820 c11662d8 
Nov 10 07:47:50 darkstar kernel:        c024f599 c5b69584 c5ba7f3c
c0358420 c5108560 c0213448 c5b695a8 c5b695c0 
Nov 10 07:47:50 darkstar kernel: Call Trace:
Nov 10 07:47:50 darkstar kernel:  [<c0253dfe>] elevator_exit+0x1e/0x20
Nov 10 07:47:50 darkstar kernel:  [<c0255fc8>]
blk_cleanup_queue+0x38/0x90
Nov 10 07:47:50 darkstar kernel:  [<c02a08c8>]
scsi_device_dev_release+0xf8/0x120
Nov 10 07:47:50 darkstar kernel:  [<c024f599>] device_release+0x19/0x60
Nov 10 07:47:50 darkstar kernel:  [<c0358420>] schedule+0x2e0/0x4f0
Nov 10 07:47:50 darkstar kernel:  [<c0213448>] kobject_cleanup+0x98/0xa0
Nov 10 07:47:50 darkstar kernel:  [<c0213450>] kobject_release+0x0/0x10
Nov 10 07:47:50 darkstar kernel:  [<c0213819>] kref_put+0x39/0xa0
Nov 10 07:47:50 darkstar kernel:  [<c021347e>] kobject_put+0x1e/0x30
Nov 10 07:47:50 darkstar kernel:  [<c0213450>] kobject_release+0x0/0x10
Nov 10 07:47:50 darkstar kernel:  [<c0299aa1>]
__scsi_iterate_devices+0x71/0x90
Nov 10 07:47:50 darkstar kernel:  [<c029c2e3>] scsi_eh_stu+0x93/0x100
Nov 10 07:47:50 darkstar kernel:  [<c029caeb>]
scsi_eh_ready_devs+0x2b/0xa0
Nov 10 07:47:50 darkstar kernel:  [<c029ccb6>] scsi_unjam_host+0xc6/0xd0
Nov 10 07:47:50 darkstar kernel:  [<c029cd61>]
scsi_error_handler+0xa1/0xd0
Nov 10 07:47:50 darkstar kernel:  [<c029ccc0>]
scsi_error_handler+0x0/0xd0
Nov 10 07:47:50 darkstar kernel:  [<c0103f25>]
kernel_thread_helper+0x5/0x10
Nov 10 07:47:50 darkstar kernel: Code: ed ff 8b 83 cc 00 00 00 89 04 24
e8 d9 aa ff ff 8b 43 30 89 04 24 e8 6e e4 ed ff 89 5c 24 0c 8b 5c 24 04
83 c4 08 e9 5e e4 ed ff <0f> 0b 3d 07 e0 a2 38 c0 eb c2 0f 0b 3c 07 e0
a2 38 c0 eb b0 8d 

-----------------------------8<----------------------------------------

I would like the replies/comments to this posting to be CC'ed at
olrt@ifrance.com

Thanks a lot !
Olivier,
Paris France.

 ___[ Pub ]____________________________________________________________
Envie de discuter gratuitement avec vos amis ?
Téléchargez Yahoo! Messenger http://yahoo.ifrance.com

