Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262355AbTJNPJ0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 11:09:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262360AbTJNPJ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 11:09:26 -0400
Received: from citrine.spiritone.com ([216.99.193.133]:23236 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S262355AbTJNPJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 11:09:23 -0400
Date: Tue, 14 Oct 2003 08:09:10 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: lenar@city.ee
Subject: [Bug 1353] New: oops with 2.6.0-test7
Message-ID: <588350000.1066144150@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

           Summary: oops with 2.6.0-test7
    Kernel Version: 2.6.0-test8
            Status: NEW
          Severity: normal
             Owner: bugme-janitors@lists.osdl.org
         Submitter: lenar@city.ee


Distribution: compiled from source
Hardware Environment: athlon xp 2500+ 1.5GB RAM

Error (regular_file): read_ksyms stat /proc/ksyms failed
ksymoops: No such file or directory
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Machine check exception polling timer started.
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:01:08.0: 3Com PCI 3c905B Cyclone 100baseTx at 0x9000. Vers LK1.1.19
Unable to handle kernel NULL pointer dereference at virtual address 00000034
c0183365
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c0183365>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010212
eax: 00000000   ebx: 00000000   ecx: 00043bab   edx: c0120cf0
esi: 0000000a   edi: f41160c0   ebp: f40fe080   esp: f4095e44
ds: 007b   es: 007b   ss: 0068
Stack: f40fe080 c02ea6a0 c02ea6a0 c02ea6a0 f4090c90 f4094000 f7b25e00 c0169862
       f7b25e00 c03a9af0 f4094000 f7ff4fc0 f7ff4fc0 c01800d4 f41162c0 f7ff4fc0
       c011ccae f41162d4 c038024c f41162c0 00000000 f7e739a8 f4090c90 f409fb40
Call Trace:
 [<c0169862>] dput+0x22/0x210
 [<c01800d4>] proc_check_root+0x104/0x160
 [<c011ccae>] mmput+0x1e/0xc0
 [<c0180e71>] pid_revalidate+0x41/0xd0
 [<c013b041>] buffered_rmqueue+0xd1/0x170
 [<c0120cf0>] do_exit+0x260/0x400
 [<c01802f4>] proc_info_read+0x54/0x140
 [<c0152c38>] vfs_read+0xb8/0x130
 [<c0152ee2>] sys_read+0x42/0x70
 [<c01091db>] syscall_call+0x7/0xb
Code: 8b 58 34 8b 70 2c 8b 45 40 89 84 24 ac 00 00 00 8b 85 60 01


>> EIP; c0183365 <proc_pid_stat+265/510>   <=====

>> edx; c0120cf0 <do_exit+260/400>
>> edi; f41160c0 <_end+33d5c6c8/3fc44608>
>> ebp; f40fe080 <_end+33d44688/3fc44608>
>> esp; f4095e44 <_end+33cdc44c/3fc44608>

Trace; c0169862 <dput+22/210>
Trace; c01800d4 <proc_check_root+104/160>
Trace; c011ccae <mmput+1e/c0>
Trace; c0180e71 <pid_revalidate+41/d0>
Trace; c013b041 <buffered_rmqueue+d1/170>
Trace; c0120cf0 <do_exit+260/400>
Trace; c01802f4 <proc_info_read+54/140>
Trace; c0152c38 <vfs_read+b8/130>
Trace; c0152ee2 <sys_read+42/70>
Trace; c01091db <syscall_call+7/b>

Code;  c0183365 <proc_pid_stat+265/510>
00000000 <_EIP>:
Code;  c0183365 <proc_pid_stat+265/510>   <=====
   0:   8b 58 34                  mov    0x34(%eax),%ebx   <=====
Code;  c0183368 <proc_pid_stat+268/510>
   3:   8b 70 2c                  mov    0x2c(%eax),%esi
Code;  c018336b <proc_pid_stat+26b/510>
   6:   8b 45 40                  mov    0x40(%ebp),%eax
Code;  c018336e <proc_pid_stat+26e/510>
   9:   89 84 24 ac 00 00 00      mov    %eax,0xac(%esp,1)
Code;  c0183375 <proc_pid_stat+275/510>
  10:   8b 85 60 01 00 00         mov    0x160(%ebp),%eax


