Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262878AbTKPPYl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 10:24:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262868AbTKPPYl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 10:24:41 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:44515 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S262878AbTKPPYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 10:24:38 -0500
Date: Sun, 16 Nov 2003 07:24:24 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: linux@1g6.biz
Subject: [Bug 1545] New: oops with i810_audio
Message-ID: <29070000.1068996264@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1545

           Summary: oops with i810_audio
    Kernel Version: 2.6.0-test9
            Status: NEW
          Severity: normal
             Owner: bugme-janitors@lists.osdl.org
         Submitter: linux@1g6.biz


Distribution: Mandrake 9.1 
 
Hardware Environment: 
Multimedia audio controller: Silicon Integrated Systems [SiS] SiS7012 PCI 
Audio Accelerator (rev a0) 
 
Software Environment: 
Using transcode. 
 
Problem Description: 
I had an oops when trying to grab sound and video with transcode. 
Nov 11 23:27:35 hal9003 kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 00000104 
Nov 11 23:27:35 hal9003 kernel:  printing eip: 
Nov 11 23:27:35 hal9003 kernel: f901fa30 
Nov 11 23:27:35 hal9003 kernel: *pde = 00000000 
Nov 11 23:27:35 hal9003 kernel: Oops: 0000 [#1] 
Nov 11 23:27:35 hal9003 kernel: CPU:    0 
Nov 11 23:27:35 hal9003 kernel: EIP:    
0060:[__crc_pci_find_parent_resource+489479/6085373]    Not tainted 
Nov 11 23:27:35 hal9003 kernel: EIP:    0060:[<f901fa30>]    Not tainted 
Nov 11 23:27:35 hal9003 kernel: EFLAGS: 00210046 
Nov 11 23:27:35 hal9003 kernel: EIP is at __i810_update_lvi+0x2a/0x130 
[i810_audio] 
Nov 11 23:27:35 hal9003 kernel: eax: 00000000   ebx: 0000b800   ecx: 
d9f36db0   edx: 00000000 
Nov 11 23:27:35 hal9003 kernel: esi: 00000484   edi: d9f36db0   ebp: 
dd33a000   esp: dd33bedc 
Nov 11 23:27:35 hal9003 kernel: ds: 007b   es: 007b   ss: 0068 
Nov 11 23:27:35 hal9003 kernel: Process transcode (pid: 13219, 
threadinfo=dd33a000 task=efd9d900) 
Nov 11 23:27:35 hal9003 kernel: Stack: 40287611 00200202 00000484 
d9f36db0 dd33a000 f901fb65 d9f36d80 00000000 
Nov 11 23:27:35 hal9003 kernel:        00200296 f901ffd3 d9f36d80 00000000 
dd33a000 00000000 efd9d900 c0117a1e 
Nov 11 23:27:35 hal9003 kernel:        00000000 00000000 00000094 
dd2ca40c 00001000 00000000 efd9d900 c0117a1e 
Nov 11 23:27:35 hal9003 kernel: Call Trace: 
Nov 11 23:27:35 hal9003 kernel:  
[__crc_pci_find_parent_resource+489788/6085373] i810_update_lvi+0x2f/0x33 
[i810_audio] 
Nov 11 23:27:35 hal9003 kernel:  [<f901fb65>] i810_update_lvi+0x2f/0x33 
[i810_audio] 
Nov 11 23:27:35 hal9003 kernel:  
[__crc_pci_find_parent_resource+490922/6085373] drain_dac+0x182/0x187 
[i810_audio] 
Nov 11 23:27:35 hal9003 kernel:  [<f901ffd3>] drain_dac+0x182/0x187 
[i810_audio] 
Nov 11 23:27:35 hal9003 kernel:  [default_wake_function+0/46] 
default_wake_function+0x0/0x2e 
Nov 11 23:27:35 hal9003 kernel:  [<c0117a1e>] 
default_wake_function+0x0/0x2e 
Nov 11 23:27:35 hal9003 kernel:  [default_wake_function+0/46] 
default_wake_function+0x0/0x2e 
Nov 11 23:27:35 hal9003 kernel:  [<c0117a1e>] 
default_wake_function+0x0/0x2e 
Nov 11 23:27:35 hal9003 kernel:  
[__crc_pci_find_parent_resource+500057/6085373] i810_release+0xcf/0xd8 
[i810_audio] 
Nov 11 23:27:35 hal9003 kernel:  [<f9022382>] i810_release+0xcf/0xd8 
[i810_audio] 
Nov 11 23:27:35 hal9003 kernel:  [__fput+227/245] __fput+0xe3/0xf5 
Nov 11 23:27:35 hal9003 kernel:  [<c014a468>] __fput+0xe3/0xf5 
Nov 11 23:27:35 hal9003 kernel:  [filp_close+89/134] filp_close+0x59/0x86 
Nov 11 23:27:35 hal9003 kernel:  [<c0148d46>] filp_close+0x59/0x86 
Nov 11 23:27:35 hal9003 kernel:  [sys_close+80/95] sys_close+0x50/0x5f 
Nov 11 23:27:35 hal9003 kernel:  [<c0148dc3>] sys_close+0x50/0x5f 
Nov 11 23:27:35 hal9003 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb 
Nov 11 23:27:35 hal9003 kernel:  [<c0108e9f>] syscall_call+0x7/0xb 
Nov 11 23:27:35 hal9003 kernel: 
Nov 11 23:27:35 hal9003 kernel: Code: 03 98 04 01 00 00 80 79 05 00 0f 85 
e9 00 00 00 f6 41 54 02 
 
 
Steps to reproduce:


