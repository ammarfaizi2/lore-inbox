Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261295AbTBVOCM>; Sat, 22 Feb 2003 09:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261353AbTBVOCM>; Sat, 22 Feb 2003 09:02:12 -0500
Received: from 60.54.252.64.snet.net ([64.252.54.60]:38814 "EHLO
	hotmale.blue-labs.org") by vger.kernel.org with ESMTP
	id <S261295AbTBVOCL>; Sat, 22 Feb 2003 09:02:11 -0500
Message-ID: <3E578543.3000107@blue-labs.org>
Date: Sat, 22 Feb 2003 09:12:19 -0500
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030209
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [OOPS] 2.5.61, rpciod, more NFS issues
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel 2.5.61, gcc 3.2.2, Athlon 1Mhz.  Reiserfs root filesystem.  This 
is an NFS client machine.

Unable to handle kernel NULL pointer dereference at virtual address 00000080
 printing eip:
c04d7439
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0060:[<c04d7439>]    Not tainted
EFLAGS: 00010203
EIP is at rpc_depopulate+0x29/0x270
eax: 00000000   ebx: ce2d025c   ecx: 00000080   edx: e7e00000
esi: ce2d025c   edi: e673ce08   ebp: e6b69e78   esp: e6b69e3c
ds: 007b   es: 007b   ss: 0068
Process rpciod (pid: 2099, threadinfo=e6b68000 task=e6bd8e00)
Stack: e673cd88 ce2d025c e6b69e58 c019b4f4 ce2d025c 00000000 fffffff4 
e6b69e78
       00000080 00000000 e6b69e64 e6b69e64 ce2d025c ce2d025c e673ce08 
e6b69ecc
       c04d7b9f ce2d025c e3b87504 00000010 e673cd88 e3b87504 e7feab1c 
e76803a4
Call Trace:
 [<c019b4f4>] simple_lookup+0x24/0x30
 [<c04d7b9f>] rpc_rmdir+0x9f/0xc0
 [<c04c065a>] rpc_destroy_client+0x2a/0x80
 [<c04c8a28>] rpc_release_task+0x2b8/0x4c0
 [<c04c7db8>] __rpc_execute+0x4f8/0x590
 [<c0108a3c>] __switch_to+0x14c/0x160
 [<c04c8054>] __rpc_schedule+0x174/0x3a0
 [<c04c931d>] rpciod+0x7d/0x210
 [<c0126940>] default_wake_function+0x0/0x20
 [<c04c92a0>] rpciod+0x0/0x210
 [<c010825d>] kernel_thread_helper+0x5/0x18

Code: ff 88 80 00 00 00 0f 88 0a 0e 00 00 b8 00 e0 ff ff 21 e0 ff


