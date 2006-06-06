Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932065AbWFFJSZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbWFFJSZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 05:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932097AbWFFJSZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 05:18:25 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:61647 "EHLO mail.bluetone.cz")
	by vger.kernel.org with ESMTP id S932065AbWFFJSY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 05:18:24 -0400
Message-ID: <4485486A.7060502@scssoft.com>
Date: Tue, 06 Jun 2006 11:18:34 +0200
From: Petr Sebor <petr@scssoft.com>
Organization: SCS Software
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Oops with 2.6.16.18 caused by tun?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unable to handle kernel NULL pointer dereference at virtual address 00000049
 printing eip:
c01fa39e
*pde = 00000000
Oops: 0002 [#1]
Modules linked in: tun
CPU:    0
EIP:    0060:[<c01fa39e>]    Not tainted VLI
EFLAGS: 00210206   (2.6.16.18 #1)
EIP is at cdrom_read_block+0xa1/0xba
eax: dc720a60   ebx: dc720a60   ecx: 00000074   edx: dcdc1f48
esi: 00000040   edi: 080e11d8   ebp: 080e11e0   esp: dcdc1ec4
ds: 007b   es: 007b   ss: 0068
Process tincd (pid: 1124, threadinfo=dcdc0000 task=dcd8e5b0)
Stack: <0>c0207ec7 8f020002 3213cf55 00000000 00000000 dcdc1f7c 00000052 
00000052
       c020c278 00000052 00000052 00000052 00000000 c020c993 000000f0 
dcdc1f7c
       deb2ac34 00000000 dcdc1f7c 00000004 00000004 00000052 deb2ac34 
00200286
Call Trace:
 [<c0207ec7>] sys_sendto+0xf5/0x116
 [<c020c278>] memcpy_toiovec+0x25/0x47
 [<c020c993>] skb_copy_datagram_iovec+0x3b/0x19e
 [<e0930cff>] tun_chr_readv+0x305/0x30f [tun]
 [<c0208585>] sys_socketcall+0xeb/0x181
 [<c0102331>] syscall_call+0x7/0xb
Code: 00 88 46 07 89 5e 10 74 16 81 fd 30 09 00 00 74 14 81 fd 20 09 00 
00 75 12 c6 46 09 58 eb 10 c6 46 09 78 eb 0a c6 46 09 f8 eb 04 <c6> 46 
09 10 8b 4c 24 0c 89 f2 8b 44 24 08 ff 51 3c 83 c4 14 5b

It is vanilla 2.6.16.18, i386

Petr

