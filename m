Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261865AbUC0Ujt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 15:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261870AbUC0Ujs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 15:39:48 -0500
Received: from gw.c9x.org ([213.41.131.17]:11074 "HELO b.mx.42-networks.com")
	by vger.kernel.org with SMTP id S261865AbUC0Ujq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 15:39:46 -0500
X-Spam-Check-By: pureftpd.org
Message-ID: <4065E69B.8000505@skyrock.fr>
Date: Sat, 27 Mar 2004 21:39:33 +0059
From: Frank Denis <fdenis@skyrock.fr>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040310)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: nfsd oops with 2.6.5-rc2-mm4
References: <4065D19A.1040903@conterra.de> <4065DDE7.9000204@skyrock.fr>
In-Reply-To: <4065DDE7.9000204@skyrock.fr>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank Denis wrote:
> I reverted to 2.6.2-rc2-mm3, the server didn't crash after 6 hours. 
> Crossing fingers...

Pointless.

2.6.2-rc2-mm3 just crashed the same way.


Unable to handle kernel NULL pointer dereference at virtual address 00000004
  printing eip:
c029fb79
*pde = 00000000
Oops: 0002 [#1]
SMP
CPU:    0
EIP:    0060:[<c029fb79>]    Not tainted VLI
EFLAGS: 00010287   (2.6.5-rc2-mm3)
EIP is at do_tcp_sendpages+0x197/0xa79
eax: f5b75108   ebx: f42c0980   ecx: 00000008   edx: 00000000
esi: 00000001   edi: f5b75100   ebp: f61bddec   esp: f62c5e34
ds: 007b   es: 007b   ss: 0068
Process nfsd (pid: 3325, threadinfo=f62c5000 task=f7727670)
Stack: 000000d0 000000d0 f62c5e60 00000000 15270000 c01e6991 f5b75110 
f61bdc64
        00000008 00000000 00000000 00000000 000005b4 00007530 00000000 
f61bdc00
        00000008 00000000 c02a04e3 f61bdc00 f62c5eac 00000000 00000008 
00000000
Call Trace:
  [<c01e6991>] nfsd_readdir+0x69/0xe8
  [<c02a04e3>] tcp_sendpage+0x88/0x96
  [<c02d8ccd>] svc_sendto+0x16a/0x29e
  [<c01ecfd9>] encode_post_op_attr+0x1c9/0x241
  [<c02d9d39>] svc_tcp_sendto+0x53/0xa8
  [<c02da4f1>] svc_send+0xb9/0xfc
  [<c02dc17c>] svcauth_unix_release+0x57/0x59
  [<c02d8189>] svc_process+0x184/0x60e
  [<c02e2d9c>] common_interrupt+0x18/0x20
  [<c01e0ce9>] nfsd+0x1ea/0x3b6
  [<c01e0aff>] nfsd+0x0/0x3b6
  [<c0104e01>] kernel_thread_helper+0x5/0xb
