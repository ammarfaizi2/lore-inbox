Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264682AbTGGE5V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 00:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264683AbTGGE5V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 00:57:21 -0400
Received: from mail.tbdnetworks.com ([63.209.25.99]:55052 "EHLO stargazer")
	by vger.kernel.org with ESMTP id S264682AbTGGE5T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 00:57:19 -0400
Date: Sun, 6 Jul 2003 22:11:52 -0700
To: linux-kernel@vger.kernel.org
Subject: [OOPS] 2.5.74-bk4 in __lookup_hash
Message-ID: <20030707051152.GA641@tbdnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Norbert Kiesel <nkiesel@tbdnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

still get the same oops during boot (started with -bk3).  System
continues booting and seems to be usable anyway.

ksymoops 2.4.8 on i686 2.5.74-bk4.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.74-bk4/ (default)
     -m /boot/System.map-2.5.74-bk4 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel NULL pointer dereference at virtual address 00000000
00000000
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<00000000>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: c0316260   ebx: fffffff4   ecx: c665553c   edx: c665553c
esi: c77dc070   edi: c6655ac0   ebp: c669ff70   esp: c669ff08
ds: 007b   es: 007b   ss: 0068
Stack: c015f0f4 c77dc070 c6655ac0 c669ff70 ffffffd8 c6655520 00008242 c669ff70 
       c015f8d9 c669ff78 c6655520 c669ff70 00000000 c669ff78 00000001 00000002 
       c66da640 00008241 400098b8 c77dd000 c669e000 c014fdde c77dd000 00008242 
Call Trace: [<c015f0f4>]  [<c015f8d9>]  [<c014fdde>]  [<c01502ab>]  [<c010ae4b>] 
Code:  Bad EIP value.


>>EIP; 00000000 Before first symbol

>>eax; c0316260 <proc_link_inode_operations+0/4c>
>>ebx; fffffff4 <__kernel_rt_sigreturn+1bb4/????>
>>ecx; c665553c <__crc_acpi_get_timer+32c02d/7a74fb>
>>edx; c665553c <__crc_acpi_get_timer+32c02d/7a74fb>
>>esi; c77dc070 <__crc_class_device_remove_file+640d35/8b48b2>
>>edi; c6655ac0 <__crc_acpi_get_timer+32c5b1/7a74fb>
>>ebp; c669ff70 <__crc_acpi_get_timer+376a61/7a74fb>
>>esp; c669ff08 <__crc_acpi_get_timer+3769f9/7a74fb>

Trace; c015f0f4 <__lookup_hash+a4/e0>
Trace; c015f8d9 <open_namei+2e9/430>
Trace; c014fdde <filp_open+3e/70>
Trace; c01502ab <sys_open+5b/90>
Trace; c010ae4b <syscall_call+7/b>


1 warning and 1 error issued.  Results may not be reliable.
