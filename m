Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264839AbSKEMv3>; Tue, 5 Nov 2002 07:51:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264842AbSKEMv3>; Tue, 5 Nov 2002 07:51:29 -0500
Received: from smtp-out-4.wanadoo.fr ([193.252.19.23]:43948 "EHLO
	mel-rto4.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S264839AbSKEMv2>; Tue, 5 Nov 2002 07:51:28 -0500
From: Duncan Sands <baldrick@wanadoo.fr>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.5.46 oops in __wake_up, from pipe_write
Date: Tue, 5 Nov 2002 13:58:19 +0100
User-Agent: KMail/1.4.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200211051358.19808.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

During system shutdown:

Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c01140f0
*pde = 00000000
Oops: 0000
r128 snd-seq-midi snd-seq-midi-event snd-seq snd-usb-audio snd-cs46xx snd-pcm snd-timer snd-rawmidi snd-seq-device snd-ac97-codec snd usbtest uhci-hcd usbcore nls_iso8859-1 nls_cp437 vfat fat rtc  
CPU:    0
EIP:    0060:[<c01140f0>]    Not tainted
EFLAGS: 00010003
EIP is at __wake_up_common+0x10/0x60
eax: c84e2ae0   ebx: c6342000   ecx: 00000001   edx: 00000000
esi: 00000282   edi: 00000001   ebp: c6343f30   esp: c6343f24
ds: 0068   es: 0068   ss: 0068
Process uname (pid: 697, threadinfo=c6342000 task=c65fb3c0)
Stack: c6342000 00000282 00000000 c6343f50 c0114160 c84e2ae0 00000001 00000001 
       00000000 00000007 cb4f5ba0 40012007 c014a3df c6342000 c6342000 cb4f5bfc 
       00000001 00000007 00000007 00000000 c94e0f60 c94e0f60 00000002 c013f906 
Call Trace:
 [<c0114160>] __wake_up+0x20/0x60
 [<c014a3df>] pipe_write+0x1ff/0x2a0
 [<c013f906>] vfs_write+0xa6/0x100
 [<c013fb08>] sys_write+0x28/0x40
 [<c0108f77>] syscall_call+0x7/0xb

Code: 8b 32 74 29 8b 5a f4 8d 42 f4 ff 75 14 ff 75 0c 50 ff 50 08 
 <6>note: uname[697] exited with preempt_count 1
