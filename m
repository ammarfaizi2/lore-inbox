Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262073AbTFOJwX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 05:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262093AbTFOJwX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 05:52:23 -0400
Received: from tag.witbe.net ([81.88.96.48]:19212 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S262073AbTFOJwW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 05:52:22 -0400
From: "Paul Rolland" <rol@as2917.net>
To: "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: [2.5.71] Oops
Date: Sun, 15 Jun 2003 12:06:12 +0200
Message-ID: <009201c33325$c0306730$2101a8c0@witbe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just compiled a 2.5.71 with the same config as a previously
OK 2.5.70....

Unable to handle kernel NULL pointer dereference at virtual address 0000002c
 printing eip:
c03ae559
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c03ae559>]    Not tainted
EFLAGS: 00010202
EIP is at register_netdevice+0x33/0x1b6
eax: 00000001   ebx: 00000000   ecx: c05070a0   edx: 00000000
esi: 00000000   edi: df899800   ebp: dd1edf68   esp: dd1edf1c
ds: 007b   es: 007b   ss: 0068
Process vtund (pid: 606, threadinfo=dd1ec000 task=de7e1900)
Stack: df899800 c028cf0a 00000000 df899a20 00000000 df899800 dd1edf68 c02e31f6 
       00000000 df899800 c02e3036 ddeac380 bffffb70 dd1ec000 dd1edf68 c02e3302 
       ddeac380 dd1edf68 00000020 00000000 00000000 00000000 00000000 00001002 
Call Trace:
 [<c028cf0a>] misc_open+0x0/0x2b6
 [<c02e31f6>] tun_set_iff+0x15a/0x18a
 [<c02e3036>] tun_setup+0x0/0x66
 [<c02e3302>] tun_chr_ioctl+0xdc/0x134
 [<c0161411>] sys_ioctl+0x115/0x29c
 [<c010a9c7>] syscall_call+0x7/0xb

I've seen some changes in TUN in the release notes...

Paul

