Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268101AbTCFNum>; Thu, 6 Mar 2003 08:50:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268105AbTCFNum>; Thu, 6 Mar 2003 08:50:42 -0500
Received: from 60.54.252.64.snet.net ([64.252.54.60]:48002 "EHLO
	hotmale.blue-labs.org") by vger.kernel.org with ESMTP
	id <S268101AbTCFNul>; Thu, 6 Mar 2003 08:50:41 -0500
Message-ID: <3E6754A6.6060801@blue-labs.org>
Date: Thu, 06 Mar 2003 09:01:10 -0500
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030304
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [OOPS] 2.5.64, pppd (PPPoE)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Bmilter: Processing completed, Bmilter version 0.1.1 build 912; timestamp 2003-03-06 14:01:12, message serial number 759179
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Had an OOPS at bootup starting my PPPoE interfaces.

I am using 2.5.58 on this machine, trying to upgrade to .64.

Unable to handle kernel NULL pointer dereference at virtual address 00000005
 printing eip:
c030eee6
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c030eee6>]    Not tainted
EFLAGS: 00010202
EIP is at packet_dev_mclist+0x16/0x38
eax: 00000005   ebx: 00000001   ecx: 00002710   edx: 00000000
esi: cbcfb400   edi: 00000001   ebp: cad51e54   esp: cad51e48
ds: 007b   es: 007b   ss: 0068
Process pppd (pid: 268, threadinfo=cad50000 task=cba45320)
Stack: cbd1e964 cbfcf59c cbcfb400 cad51e74 c030f7bd cbcfb400 00000001 
00000001
       c03edc14 cbcfb400 00000001 cad51e94 c012aa27 c03edc14 00000001 
cbcfb400
       cbcfb400 00000000 00001090 cad51eb8 c02ac6d6 c048bcc4 00000001 
cbcfb400
Call Trace:
 [<c030f7bd>] packet_notifier+0x28d/0x2a8
 [<c012aa27>] notifier_call_chain+0x23/0x40
 [<c02ac6d6>] dev_open+0xb6/0xc4
 [<c02adc71>] dev_change_flags+0x59/0x110
 [<c02e61e4>] devinet_ioctl+0x2c4/0x5cc
 [<c02e9047>] inet_ioctl+0xb3/0xf4
 [<c02a5ab1>] sock_ioctl+0x1cd/0x1dc
 [<c016779f>] sys_ioctl+0x1ef/0x210
 [<c0109777>] syscall_call+0x7/0xb

Code: 39 43 04 75 0b 57 53 56 e8 6d ff ff ff 83 c4 0c 8b 1b 85 db


