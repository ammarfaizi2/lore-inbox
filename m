Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267716AbTBYOOH>; Tue, 25 Feb 2003 09:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267726AbTBYOOH>; Tue, 25 Feb 2003 09:14:07 -0500
Received: from proxy.ovh.net ([213.244.20.42]:47372 "EHLO proxy.ovh.net")
	by vger.kernel.org with ESMTP id <S267716AbTBYOOG>;
	Tue, 25 Feb 2003 09:14:06 -0500
Date: Tue, 25 Feb 2003 15:13:37 +0100
From: Bertrand <bert@ovh.net>
To: linux-kernel@vger.kernel.org
Subject: rootfs on nfs : oops 2.5.63
Message-Id: <20030225151337.358a6ee6.bert@ovh.net>
Organization: OVH
X-Mailer: Sylpheed version 0.7.4claws (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I got a diskless station and i wanted to test the 2.5.* series.

I got an Oops when the kernel tries to mount the rootfs on nfs.

The kernel is build without modules, without ide, without scsi, with  nfs and root on nfs option, devfs.

The oops is shown bellow.

Thank for advice.

			Bert.


ksymoops -m /tftpboot/slaves-2.5.63.System.map : 
********************************************************************
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
BIOS EDD facility v0.09 2003-Jan-22, 0 devices found
EDD information not available.
Looking up port of RPC 100003/2 on 213.186.***.***
Unable to handle kernel NULL pointer dereference at virtual address 0000006c
c02255d4
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0060:[<c02255d4>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: 00000000   ebx: c17acf40   ecx: 0000006c   edx: c17d6200
esi: dfd8fd58   edi: dfd8fd58   ebp: dfd8fe94   esp: dfd8fd54
ds: 007b   es: 007b   ss: 0068
Stack: 00000000 dfd8fd58 dfd8fd58 c17acf40 c17acf40 c17addc0 dfd8fe94 c0225ae5 
       c17acf40 c17d6200 dfde94e0 dfd8fd80 00000282 c17be720 00000010 00000001 
       dfd8fe94 c17e2ec0 dfd8fe38 dfd8fe38 c0217434 c17e2f54 c17e2ec0 c02174a9 
Call Trace: [<c0225ae5>]  [<c0217434>]  [<c02174a9>]  [<c021be67>]  [<c021b80b>]  [<c0118ff0>]  [<c021775a>]  [<c0217639>]  [<c021764a>]  [<c021a9b0>]  [<c022255d>]  [<c02225ae>]  [<c011c9e6>]  [<c011cd00>]  [<c010530b>]  [<c01050a3>]  [<c0105050>]  [<c0107005>] 
Code: f0 ff 48 6c 0f 88 5a 09 00 00 f0 fe 0d 40 f7 27 c0 0f 88 57 

>>EIP; c02255d4 <rpc_depopulate+24/100>   <=====
Trace; c0225ae5 <rpc_rmdir+55/90>
Trace; c0217434 <rpc_destroy_client+44/70>
Trace; c02174a9 <rpc_release_client+49/50>
Trace; c021be67 <rpc_release_task+1a7/1d0>
Trace; c021b80b <__rpc_execute+34b/360>
Trace; c0118ff0 <default_wake_function+0/20>
Trace; c021775a <rpc_call_setup+4a/60>
Trace; c0217639 <rpc_call_sync+69/a0>
Trace; c021764a <rpc_call_sync+7a/a0>
Trace; c021a9b0 <rpc_run_timer+0/a0>
Trace; c022255d <rpc_getport_external+8d/100>
Trace; c02225ae <rpc_getport_external+de/100>
Trace; c011c9e6 <__call_console_drivers+46/60>
Trace; c011cd00 <printk+120/160>
Trace; c010530b <prepare_namespace+fb/140>
Trace; c01050a3 <init+53/1c0>
Trace; c0105050 <init+0/1c0>
Trace; c0107005 <kernel_thread_helper+5/10>
Code;  c02255d4 <rpc_depopulate+24/100>
00000000 <_EIP>:
Code;  c02255d4 <rpc_depopulate+24/100>   <=====
   0:   f0 ff 48 6c               lock decl 0x6c(%eax)   <=====
Code;  c02255d8 <rpc_depopulate+28/100>
   4:   0f 88 5a 09 00 00         js     964 <_EIP+0x964> c0225f38 <.text.lock.rpc_pipe+d0/188>
Code;  c02255de <rpc_depopulate+2e/100>
   a:   f0 fe 0d 40 f7 27 c0      lock decb 0xc027f740
Code;  c02255e5 <rpc_depopulate+35/100>
  11:   0f 88 57 00 00 00         js     6e <_EIP+0x6e> c0225642 <rpc_depopulate+92/100>

**************************************************************
