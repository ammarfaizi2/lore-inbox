Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319338AbSHVMcB>; Thu, 22 Aug 2002 08:32:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319336AbSHVMcB>; Thu, 22 Aug 2002 08:32:01 -0400
Received: from atlas.cc.itu.edu.tr ([160.75.2.22]:43479 "EHLO
	atlas.cc.itu.edu.tr") by vger.kernel.org with ESMTP
	id <S319333AbSHVMcA>; Thu, 22 Aug 2002 08:32:00 -0400
Date: Thu, 22 Aug 2002 15:35:11 +0300
From: =?ISO-8859-1?Q?=DEeref?= Tufan =?ISO-8859-1?Q?=DEen?= 
	<tufan@itu.edu.tr>
To: linux-kernel@vger.kernel.org
Subject: linux-2.5.31 OOPS
Message-Id: <20020822153511.448fa8d4.tufan@itu.edu.tr>
Organization: ITU-CC
X-Mailer: Sylpheed version 0.7.3 (GTK+ 1.2.10; i386-redhat-linux)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just untared 2.4.19 and I got the following oops. After the oops I couldn't use my virtual consoles , but I was able to reboot with CTRL-ALT-DEL.

The last log before oops..
Aug 22 13:51:57 aontws4031 login(pam_unix)[868]: session closed for user root

Logs after oops..
Aug 22 13:52:15 aontws4031 gpm[752]: oops() invoked from gpm.c(164)
Aug 22 13:52:15 aontws4031 gpm[752]: /dev/tty0: Input/output error
Aug 22 14:00:37 aontws4031 init: open(/dev/console): Input/output error
Aug 22 14:00:37 aontws4031 shutdown: shutting down for system reboot
Aug 22 14:00:37 aontws4031 init: Switching to runlevel: 6
Aug 22 14:00:37 aontws4031 login(pam_unix)[867]: session closed for user root
Aug 22 14:00:41 aontws4031 shutdown: shutting down for system reboot
Aug 22 14:00:43 aontws4031 atd: atd shutdown succeeded
Aug 22 14:00:43 aontws4031 Font Server[822]: terminating
Aug 22 14:00:44 aontws4031 xfs: xfs shutdown succeeded
Aug 22 14:00:45 aontws4031 gpm: gpm shutdown failed
....................................

If you need more info let me know..

ksymoops 2.4.4 on i686 2.5.31.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.31/ (default)
     -m /boot/System.map-2.5.31 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
Aug 22 13:51:57 aontws4031 kernel: Unable to handle kernel paging request at virtual address 5a5a5a5a
Aug 22 13:51:57 aontws4031 kernel: 5a5a5a5a
Aug 22 13:51:57 aontws4031 kernel: *pde = 00000000
Aug 22 13:51:57 aontws4031 kernel: Oops: 0000
Aug 22 13:51:57 aontws4031 kernel: CPU:    0
Aug 22 13:51:57 aontws4031 kernel: EIP:    0010:[<5a5a5a5a>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Aug 22 13:51:57 aontws4031 kernel: EFLAGS: 00010206
Aug 22 13:51:57 aontws4031 kernel: eax: c7a4b130   ebx: c029e584   ecx: 5a5a5a5a   edx: 5a5a5a5a
Aug 22 13:51:57 aontws4031 kernel: esi: c11c9f6c   edi: c11c8000   ebp: ffffffff   esp: c11c9f64
Aug 22 13:51:57 aontws4031 kernel: ds: 0018   es: 0018   ss: 0018
Aug 22 13:51:57 aontws4031 kernel: Stack: c011a8f1 5a5a5a5a c7a4b130 c029e584 c11d6ac0 00000000 c0122d53 c02961a0 
Aug 22 13:51:57 aontws4031 kernel:        00000000 c11c9fc0 c11d6ac0 00000000 00000000 00000000 00000000 00000001 
Aug 22 13:51:57 aontws4031 kernel:        00000000 00000000 00010000 00000000 00000000 c11d6040 c11d5f74 00000000 
Aug 22 13:51:57 aontws4031 kernel: Call Trace: [<c011a8f1>] [<c0122d53>] [<c0112f70>] [<c0122bd0>] [<c0105621>] 
Aug 22 13:51:57 aontws4031 kernel: Code:  Bad EIP value.

>>EIP; 5a5a5a5a Before first symbol   <=====
Trace; c011a8f1 <__run_task_queue+61/70>
Trace; c0122d53 <context_thread+183/250>
Trace; c0112f70 <default_wake_function+0/40>
Trace; c0122bd0 <context_thread+0/250>
Trace; c0105621 <kernel_thread_helper+5/14>


2 warnings issued.  Results may not be reliable.




