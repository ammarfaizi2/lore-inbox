Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261840AbVDCRyH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261840AbVDCRyH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 13:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261842AbVDCRyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 13:54:07 -0400
Received: from box3.punkt.pl ([217.8.180.76]:58124 "HELO box.punkt.pl")
	by vger.kernel.org with SMTP id S261841AbVDCRxx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 13:53:53 -0400
Message-ID: <42502EB2.3080802@punkt.pl>
Date: Sun, 03 Apr 2005 19:58:10 +0200
From: |TEcHNO| <techno@punkt.pl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a5) Gecko/20041122
X-Accept-Language: en-gb, en-us, en-ca, en-au, ja, pl
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [SCSI] Driver broken in 2.6.x?
References: <424EB65A.8010600@punkt.pl> <Pine.LNX.4.62.0504022301430.2525@dragon.hyggekrogen.localhost> <424F0BFF.6020402@punkt.pl> <Pine.LNX.4.62.0504022322150.2525@dragon.hyggekrogen.localhost>
In-Reply-To: <Pine.LNX.4.62.0504022322150.2525@dragon.hyggekrogen.localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

As told, I tested it w/o nvidia module loaded, here's what I found:
1. It now doesn't hang on scanning for devices.
2. It now hangs on acquiring preview, logs will follow.
2a.Not it hanged on scanning for devices again, don't know why.
3. It's true for both module loaded and w/o it.
4. xsane badly reports my scanner as Plustek 12000 or such.
5. Turning on "partial updates"(or such) in view->updates, coused whole
machine to hang up, hard reset was needed. W/o this, only xsane hanged.
Shoudln't kernel protect form that somehow?
6. Anytime xsane fails/hangs, it hangs the scanner, making it blink it's
lamp all the time, and it needt to be dissconnected form electricity to
work.
7. As a side question: any way to "reload" the whole SCSI subsystem, so
I don't hjave to reboot if I connect something new?

<begin /var/log/syslog>
Apr  3 15:36:38 techno kernel: scsi0 : aborting command
Apr  3 15:36:38 techno kernel: scsi0 : destination target 6, lun 0
Apr  3 15:36:38 techno kernel:
Apr  3 15:36:38 techno kernel: NCR5380 core release=7.
Apr  3 15:36:38 techno kernel: Base Addr: 0x00000    io_port: d800
IRQ: 11.
Apr  3 15:36:38 techno kernel: scsi0 : destination target 6, lun 0
Apr  3 15:36:38 techno kernel:         command = 42 (0x2a)00 03 00 00 00
01 10 00 00
Apr  3 15:36:38 techno kernel: scsi0: issue_queue
Apr  3 15:36:38 techno kernel: scsi0: disconnected_queue
Apr  3 15:36:38 techno kernel:
Apr  3 15:36:38 techno kernel: scsi0 : aborting command
Apr  3 15:36:38 techno kernel: scsi0 : destination target 6, lun 0
Apr  3 15:36:38 techno kernel:
Apr  3 15:36:38 techno kernel: NCR5380 core release=7.
Apr  3 15:36:38 techno kernel: Base Addr: 0x00000    io_port: d800
IRQ: 11.
Apr  3 15:36:38 techno kernel: scsi0 : destination target 6, lun 0
Apr  3 15:36:38 techno kernel:         command = 42 (0x2a)00 03 00 00 00
01 10 00 00
Apr  3 15:36:38 techno kernel: scsi0: issue_queue
Apr  3 15:36:38 techno kernel: scsi0: disconnected_queue
Apr  3 15:36:38 techno kernel:
Apr  3 15:36:38 techno kernel:
Apr  3 15:36:38 techno kernel: NCR5380 core release=7.
Apr  3 15:36:38 techno kernel: Base Addr: 0x00000    io_port: d800
IRQ: 11.
Apr  3 15:36:38 techno kernel: scsi0 : destination target 6, lun 0
Apr  3 15:36:38 techno kernel:         command = 42 (0x2a)00 03 00 00 00
01 10 00 00
Apr  3 15:36:39 techno kernel: scsi0: issue_queue
Apr  3 15:36:39 techno kernel: scsi0: disconnected_queue
Apr  3 15:36:39 techno kernel:
Apr  3 15:40:26 techno kernel: Linux version 2.6.11.3 (root@techno) (gcc
version 3.3.5) #1 Tue Mar 15 14:23:17 CET 2005

<cut>

Apr  3 15:54:07 techno kernel: scsi0 : aborting command
Apr  3 15:54:07 techno kernel: scsi0 : destination target 6, lun 0
Apr  3 15:54:07 techno kernel:
Apr  3 15:54:07 techno kernel: NCR5380 core release=7.
Apr  3 15:54:07 techno kernel: Base Addr: 0x00000    io_port: d800
IRQ: 11.
Apr  3 15:54:07 techno kernel: scsi0: no currently connected command
Apr  3 15:54:07 techno kernel: scsi0: issue_queue
Apr  3 15:54:07 techno kernel: scsi0: disconnected_queue
Apr  3 15:54:07 techno kernel:
Apr  3 15:54:07 techno kernel: scsi0 : aborting command
Apr  3 15:54:07 techno kernel: scsi0 : destination target 6, lun 0
Apr  3 15:54:07 techno kernel:
Apr  3 15:54:07 techno kernel: NCR5380 core release=7.
Apr  3 15:54:07 techno kernel: Base Addr: 0x00000    io_port: d800
IRQ: 11.
Apr  3 15:54:07 techno kernel: scsi0: no currently connected command
Apr  3 15:54:07 techno kernel: scsi0: issue_queue
Apr  3 15:54:07 techno kernel: scsi0: disconnected_queue
Apr  3 15:54:07 techno kernel:
Apr  3 15:54:07 techno kernel: scsi0 : warning : SCSI command probably
completed successfully
Apr  3 15:54:07 techno kernel:          before abortion
Apr  3 15:54:07 techno kernel:
Apr  3 15:54:07 techno kernel: NCR5380 core release=7.
Apr  3 15:54:07 techno kernel: Base Addr: 0x00000    io_port: d800
IRQ: 11.
Apr  3 15:54:07 techno kernel: scsi0: no currently connected command
Apr  3 15:54:07 techno kernel: scsi0: issue_queue
Apr  3 15:54:07 techno kernel: scsi0: disconnected_queue
Apr  3 15:54:07 techno kernel:
Apr  3 15:54:27 techno kernel: scsi0 : aborting command
Apr  3 15:54:27 techno kernel: scsi0 : destination target 6, lun 0
Apr  3 15:54:27 techno kernel:
Apr  3 15:54:27 techno kernel: NCR5380 core release=7.
Apr  3 15:54:27 techno kernel: Base Addr: 0x00000    io_port: d800
IRQ: 11.
Apr  3 15:54:27 techno kernel: scsi0: no currently connected command
Apr  3 15:54:27 techno kernel: scsi0: issue_queue
Apr  3 15:54:27 techno kernel: scsi0 : destination target 6, lun 0
Apr  3 15:54:27 techno kernel:         command =  0 (0x00)00 00 00 00 00
Apr  3 15:54:27 techno kernel: scsi0: disconnected_queue
Apr  3 15:54:27 techno kernel:
Apr  3 15:54:27 techno kernel: scsi0 : aborting command
Apr  3 15:54:27 techno kernel: scsi0 : destination target 6, lun 0
Apr  3 15:54:27 techno kernel:
Apr  3 15:54:27 techno kernel: NCR5380 core release=7.
Apr  3 15:54:27 techno kernel: Base Addr: 0x00000    io_port: d800
IRQ: 11.
Apr  3 15:54:27 techno kernel: scsi0: no currently connected command
Apr  3 15:54:27 techno kernel: scsi0: issue_queue
Apr  3 15:54:27 techno kernel: scsi0 : destination target 6, lun 0
Apr  3 15:54:27 techno kernel:         command =  0 (0x00)00 00 00 00 00
Apr  3 15:54:27 techno kernel: scsi0: disconnected_queue
Apr  3 15:54:27 techno kernel:
Apr  3 15:54:27 techno kernel: Unable to handle kernel NULL pointer
dereference at virtual address 0000014c
Apr  3 15:54:27 techno kernel:  printing eip:
Apr  3 15:54:27 techno kernel: c03d8143
Apr  3 15:54:27 techno kernel: *pde = 00000000
Apr  3 15:54:27 techno kernel: Oops: 0000 [#1]
Apr  3 15:54:27 techno kernel: PREEMPT
Apr  3 15:54:27 techno kernel: Modules linked in: nvidia
Apr  3 15:54:27 techno kernel: CPU:    0
Apr  3 15:54:27 techno kernel: EIP:    0060:[<c03d8143>]    Tainted: P
     VLI
Apr  3 15:54:27 techno kernel: EFLAGS: 00010286   (2.6.11.3)
Apr  3 15:54:27 techno kernel: EIP is at scsi_finish_command+0x63/0xc0
Apr  3 15:54:27 techno kernel: eax: 00000000   ebx: db821800   ecx:
00000000   edx: c3a6dc00
Apr  3 15:54:27 techno kernel: esi: 00000000   edi: db83d040   ebp:
db84dfb4   esp: db84df6c
Apr  3 15:54:27 techno kernel: ds: 007b   es: 007b   ss: 0068
Apr  3 15:54:27 techno kernel: Process scsi_eh_0 (pid: 1096,
threadinfo=db84c000 task=dbcf50e0)
Apr  3 15:54:27 techno kernel: Stack: db821800 db84dfb4 c03db86a
db84dfac db84dfac db84dfac c03dbc3d db83d040
Apr  3 15:54:27 techno kernel:        db821c30 db821c30 00000286
db84dfac c03dbcfd db84dfac db84dfac db84dfac
Apr  3 15:54:27 techno kernel:        db84dfac db84dfac db84dfb4
db84dfb4 db84dfd8 db821c00 00000000 00000000
Apr  3 15:54:27 techno kernel: Call Trace:
Apr  3 15:54:27 techno kernel:  [<c03db86a>] scsi_eh_offline_sdevs+0x7a/0x90
Apr  3 15:54:27 techno kernel:  [<c03dbc3d>] scsi_eh_flush_done_q+0x7d/0xb0
Apr  3 15:54:27 techno kernel:  [<c03dbcfd>] scsi_unjam_host+0x8d/0xd0
Apr  3 15:54:27 techno kernel:  [<c03dbddf>] scsi_error_handler+0x9f/0xd0
Apr  3 15:54:27 techno kernel:  [<c03dbd40>] scsi_error_handler+0x0/0xd0
Apr  3 15:54:27 techno kernel:  [<c01012fd>] kernel_thread_helper+0x5/0x18
Apr  3 15:54:27 techno kernel: Code: e0 70 83 f8 70 74 67 0f b7 87 98 00
00 00 66 c7 47 0a 00 01 8b 57 0c 66 c7 47 08 01 10 85 d2 66 89 87 9a 00
00 00 74 10 8b 4a 70 <8b> 81 4c 01 00 00 85 c0 89 42 04 75 16 89 3c 24
ff 57 28 8b 5c
Apr  3 15:54:27 techno kernel:  <3>scsi0 (6:0): rejecting I/O to offline
device

<end>

<begin /var/log/messages>
Apr  3 15:13:20 techno kernel: scsi0 : Domex DMX3191D
Apr  3 15:13:20 techno kernel:   Vendor: SCANNER   Model:
     Rev: V100
Apr  3 15:13:20 techno kernel:   Type:   Scanner
     ANSI SCSI revision: 01 CCS
Apr  3 15:13:20 techno kernel: Attached scsi generic sg0 at scsi0,
channel 0, id 6, lun 0,  type 6

<cut>

Apr  3 15:21:31 techno kernel:         command: cdb[0]=0x12: 12 00 00 00
60 00
Apr  3 15:21:31 techno kernel:         command: cdb[0]=0x12: 12 00 00 00
60 00
Apr  3 15:21:51 techno kernel:         command: cdb[0]=0x0: 00 00 00 00
00 00
Apr  3 15:21:52 techno kernel:         command: cdb[0]=0x0: 00 00 00 00
00 00
Apr  3 15:21:52 techno kernel: scsi: Device offlined - not ready after
error recovery: host 0 channel 0 id 6 lun 0

<cut>

Apr  3 15:36:38 techno kernel:         command: cdb[0]=0x2a: 2a 00 03 00
00 00 01 10 00 00

<cut>
Apr  3 15:54:07 techno kernel:         command: cdb[0]=0x12: 12 00 00 00
60 00
Apr  3 15:54:07 techno kernel:         command: cdb[0]=0x12: 12 00 00 00
60 00
Apr  3 15:54:27 techno kernel:         command: cdb[0]=0x0: 00 00 00 00
00 00
Apr  3 15:54:27 techno kernel:         command: cdb[0]=0x0: 00 00 00 00
00 00
Apr  3 15:54:27 techno kernel: scsi: Device offlined - not ready after
error recovery: host 0 channel 0 id 6 lun 0

<end>

As previously, please CC any replies ect. to me, I'm willing to help as
much as I can.
-- 
pozdrawiam     |"Who says the Anti-Christ has to be a man?!"
techno@punkt.pl|Art Bell - Radio Talk Show Host

