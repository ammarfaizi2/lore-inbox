Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964955AbWEBSKI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964955AbWEBSKI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 14:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964956AbWEBSKI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 14:10:08 -0400
Received: from mail.ij.net ([207.22.166.253]:64941 "EHLO ij.net")
	by vger.kernel.org with ESMTP id S964955AbWEBSKH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 14:10:07 -0400
From: "johng" <johng@ij.net>
Reply-to: johng@ij.net
To: linux-kernel@vger.kernel.org
Subject: kernel: Oops:  Assertion failed! qc != NULL,libata-core.c,ata_pio_error,line=3227
X-Mailer: Quality Web Email v3.1o, http://netwinsite.com/refw.htm
X-Originating-IP: 207.100.240.50
Date: Tue, 02 May 2006 13:13:59 -0500
Message-id: <4457a167.156.20ff.456090205@ij.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
X-Server: High Performance Mail Server - http://surgemail.com r=329229864
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following Kernel Oops is a problem in 2.4.33-pre2, but
does not happen in 2.4.32.

I am willing to help test this, if a patch is available.

below is part of the /var/log/messages before the kernel
panic.



Apr 20 08:16:09 dhcp-wk45 smartd: smartd startup succeeded


***** Waited a couple of minutes, then pulled /dev/sdb out
of it's tray to disable it.


Apr 20 08:18:50 dhcp-wk45 kernel: ata2: command 0xec
timeout, stat 0xd0 host_stat 0x0
Apr 20 08:18:50 dhcp-wk45 kernel: ata2: translated ATA
stat/err 0xd0/00 to SCSI
SK/ASC/ASCQ 0xb/47/00
Apr 20 08:18:50 dhcp-wk45 kernel: ata2: status=0xd0 { Busy }
Apr 20 08:18:58 dhcp-wk45 kernel: ATA: abnormal status 0xD0
on port 0xE407
Apr 20 08:18:58 dhcp-wk45 last message repeated 2 times
Apr 20 08:19:08 dhcp-wk45 kernel: ata2: command 0xec
timeout, stat 0xd0 host_stat 0x0
Apr 20 08:19:08 dhcp-wk45 kernel: ata2: translated ATA
stat/err 0xd0/00 to SCSI
SK/ASC/ASCQ 0xb/47/00
Apr 20 08:19:08 dhcp-wk45 kernel: ata2: status=0xd0 { Busy }
Apr 20 08:19:28 dhcp-wk45 kernel: ata2: PIO error
Apr 20 08:19:28 dhcp-wk45 kernel: Assertion failed! qc !=
NULL,libata-core.c,ata_pio_error,line=3227
Apr 20 08:19:28 dhcp-wk45 kernel: Unable to handle kernel
NULL pointer dereference at virtual address 00000000
Apr 20 08:19:28 dhcp-wk45 kernel:  printing eip:
Apr 20 08:19:28 dhcp-wk45 kernel: c0250edb
Apr 20 08:19:28 dhcp-wk45 kernel: *pde = 3679f001
Apr 20 08:19:28 dhcp-wk45 kernel: *pte = 00000000
Apr 20 08:19:28 dhcp-wk45 kernel: Oops: 0000
Apr 20 08:19:28 dhcp-wk45 kernel: CPU:    2
Apr 20 08:19:28 dhcp-wk45 kernel: EIP:    0010:[<c0250edb>] 
  Not tainted
Apr 20 08:19:28 dhcp-wk45 kernel: EFLAGS: 00010296
Apr 20 08:19:28 dhcp-wk45 kernel: eax: 00000001   ebx:
00000000   ecx: 00000001
  edx: c036d320
Apr 20 08:19:28 dhcp-wk45 kernel: esi: c289487c   edi:
00000000   ebp: 00000000
  esp: f7fc3f44
Apr 20 08:19:28 dhcp-wk45 kernel: ds: 0018   es: 0018   ss:
0018
Apr 20 08:19:28 dhcp-wk45 kernel: Process keventd (pid: 2,
stackpage=f7fc3000)
Apr 20 08:19:28 dhcp-wk45 kernel: Process keventd (pid: 2,
stackpage=f7fc3000)
Apr 20 08:19:28 dhcp-wk45 kernel: Stack: 0000000a 00000400
c0342426 00000000 c289487c 00000000 f7fc2000 c0251938
Apr 20 08:19:28 dhcp-wk45 kernel:        00000000 00000004
c033b594 c033b701 00000c9b f7fc3f88 f7fc3f88 c0121b7a
Apr 20 08:19:28 dhcp-wk45 kernel:        c289487c c2894e2c
c2894e2c 00000000 00000000 c012aea7 c036e594 f7fc3fb0
Apr 20 08:19:28 dhcp-wk45 kernel: Call Trace:   
[<c0251938>] [<c0121b7a>] [<c012aea7>] [<c012ad70>]
[<c0105000>]
Apr 20 08:19:28 dhcp-wk45 kernel:   [<c010747e>]
[<c012ad70>]
Apr 20 08:19:28 dhcp-wk45 kernel:
Apr 20 08:19:28 dhcp-wk45 kernel: Code: 8b 75 00 9c 5f fa 8b
86 98 05 00 00 f0 fe 08 0f 88 bc 25 00
Apr 20 08:20:08 dhcp-wk45 shutdown: shutting down for system
reboot
Apr 20 08:20:08 dhcp-wk45 init: Switching to runlevel: 6

