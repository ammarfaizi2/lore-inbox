Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932433AbWAQXkQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932433AbWAQXkQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 18:40:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932398AbWAQXkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 18:40:10 -0500
Received: from web52613.mail.yahoo.com ([206.190.48.216]:34426 "HELO
	web52613.mail.yahoo.com") by vger.kernel.org with SMTP
	id S932393AbWAQXkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 18:40:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=fEEL5zxcPNZYRghcop8gFVYIbH0HV9lWPjBAwOXWeLqjrgA+bWg6Ws9ofIhYpK5iBEgHvX1rmxcaI7N72Amwq0/QV3Zj/v/I4S9sj4XxfuVyxasIaEroBls4/I414uh9AOT3PD7zVuT65iR1CSETTRj4z5GMWDzeTxEMlRK4P/Y=  ;
Message-ID: <20060117234002.27623.qmail@web52613.mail.yahoo.com>
Date: Wed, 18 Jan 2006 10:40:02 +1100 (EST)
From: Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>
Subject: 2.6.16-rc1 Oops on serial
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[I am unsure how it's going to look, when I use this
web email interface.]

Freeing unused kernel memory: 120k freed
input: PS/2 Generic Mouse as /class/input/input1
Unable to handle kernel paging request at virtual
address 001c2000
 printing eip:
c02098d4
*pde = 00000000
Oops: 0000 [#1]
Modules linked in:
CPU:    0
EIP:    0060:[<c02098d4>]    Not tainted VLI
EFLAGS: 00010006   (2.6.16-rc1) 
EIP is at serial8250_startup+0x229/0x391
eax: 00000000   ebx: 0000000c   ecx: 001c2000   edx:
c0346b04
esi: c0346a70   edi: c0346b2c   ebp: df410b7c   esp:
c155ae7c
ds: 007b   es: 007b   ss: 0068
Process setserial (pid: 280, threadinfo=c155a000
task=c15faa50)
Stack: <0>c15bf700 c0346a70 fffffff4 df410b7c c0206ae7
c0346a70 00000000 c153d240 
       df410b7c c15bf73c df410b94 c0206cdf c15bf680
c15c486c df44b61c 00000000 
       c15bf6c0 ffffffed c153d240 00000000 00400041
c01f00ec df27f800 c153d240 
Call Trace:
 [<c0206ae7>] uart_startup+0x63/0xeb
 [<c0206cdf>] uart_open+0x170/0x350
 [<c01f00ec>] tty_open+0x17a/0x2ab
 [<c014adff>] chrdev_open+0xe9/0x100
 [<c014ad16>] chrdev_open+0x0/0x100
 [<c0143783>] __dentry_open+0xb5/0x189
 [<c0143911>] filp_open+0x30/0x38
 [<c01439de>] do_sys_open+0x3c/0xa8
 [<c0102967>] sysenter_past_esp+0x54/0x75
Code: 8d bb 20 6b 34 c0 8b 46 54 25 00 00 00 01 83 f8
01 19 c0 f7 d0 25 00 00 00 04 fa 8b 8b 20 6b 34 c0 85
c9 8d 96 94 00 00 00 74 13 <8b> 01 89 50 04 89 86 94
00 00 00 89 4a 04 89 11 fb eb 45 89 96 
 BUG: setserial/280, lock held at task exit time!
 [df410b94] {uart_register_driver}
.. held by:         setserial:  280 [c15faa50, 120]
... acquired at:               uart_open+0x3f/0x350
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27

More info shall be provided on request.

Thanks

Hari



		
____________________________________________________ 
Do you Yahoo!? 
Listen to over 20 online radio stations and watch the latest music videos on Yahoo! Music. 
http://au.launch.yahoo.com
