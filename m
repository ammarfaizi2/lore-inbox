Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264975AbUFTPtI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264975AbUFTPtI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 11:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265644AbUFTPtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 11:49:08 -0400
Received: from guanin.uni-konstanz.de ([134.34.240.60]:12724 "EHLO
	guanin.uni-konstanz.de") by vger.kernel.org with ESMTP
	id S264975AbUFTPtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 11:49:03 -0400
From: Michael Dreher <michael.dreher@uni-konstanz.de>
To: linux-kernel@vger.kernel.org
Subject: oops eject cardbus 2.6.7
Date: Sun, 20 Jun 2004 17:49:00 +0200
User-Agent: KMail/1.6
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200406201749.00739.michael.dreher@uni-konstanz.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

when ejecting a cardbus card, I got the following oops.
The box is a vaio C1 picturebook, the card is part of a 
CD-ROM drive. Kernel is 2.6.7.

Just ask if you need more information.


Unable to handle kernel paging request at virtual address 6b6b6b83
 printing eip:
c011f697
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
Modules linked in: nls_iso8859_1 hci_vhci hci_uart hci_usb i2c_dev i2c_ali1535 
i2c_ali15x3 i2c_core 8250 serial_core
CPU:    0
EIP:    0060:[<c011f697>]    Not tainted
EFLAGS: 00010212   (2.6.7)
EIP is at __release_resource+0x17/0x40
eax: c1339468   ebx: cec8a000   ecx: 6b6b6b83   edx: 00000188
esi: 00000001   edi: 00000180   ebp: cec8bedc   esp: cec8bed8
ds: 007b   es: 007b   ss: 0068
Process pccardd (pid: 147, threadinfo=cec8a000 task=ceccab70)
Stack: cec8a000 cec8beec c011f75c cec6d574 00000001 cec8bf04 c02d4b71 00000008
       00000002 ced44cb0 cec6d574 cec8bf18 c02d5ab4 ced44c98 ced44c98 ced44d10
       cec8bf30 c02bca1b ced44d10 ced44d64 00000008 00000001 cec8bf38 c02bcb31
Call Trace:
 [<c0105c66>] show_stack+0xa6/0xb0
 [<c0105dda>] show_registers+0x14a/0x1b0
 [<c0105f7d>] die+0x8d/0x100
 [<c01167c1>] do_page_fault+0x3e1/0x567
 [<c01058d5>] error_code+0x2d/0x38
 [<c011f75c>] release_resource+0x1c/0x40
 [<c02d4b71>] release_io_space+0x71/0x90
 [<c02d5ab4>] pcmcia_release_io+0xa4/0xd0
 [<c02bca1b>] ide_release+0x3b/0xa0
 [<c02bcb31>] ide_event+0xb1/0xd0
 [<c02d3f81>] send_event+0x41/0x60
 [<c02d3fb5>] socket_remove_drivers+0x15/0x40
 [<c02d3feb>] socket_shutdown+0xb/0x60
 [<c02d455b>] socket_remove+0xb/0x60
 [<c02d461f>] socket_detect_change+0x6f/0x80
 [<c02d47f8>] pccardd+0x1c8/0x1f0
 [<c01032a5>] kernel_thread_helper+0x5/0x10

Code: 8b 11 bb ea ff ff ff 85 d2 75 ee eb 0e 8b 42 14 31 db 89 01
 <6>note: pccardd[147] exited with preempt_count 1


 
