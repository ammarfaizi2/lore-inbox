Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132357AbQLQEf7>; Sat, 16 Dec 2000 23:35:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132372AbQLQEft>; Sat, 16 Dec 2000 23:35:49 -0500
Received: from johnson.mail.mindspring.net ([207.69.200.177]:6944 "EHLO
	johnson.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S132357AbQLQEfn>; Sat, 16 Dec 2000 23:35:43 -0500
From: volodya@mindspring.com
Date: Sat, 16 Dec 2000 23:05:45 -0500 (EST)
Reply-To: volodya@mindspring.com
To: linux-kernel@vger.kernel.org
Subject: APM bug with Inspiron 5000e
Message-ID: <Pine.LNX.4.20.0012162303120.2738-100000@node2.localnet.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am seeing this bug with both test8 and test12 kernels. Help/suggestions
for debugging are appreciated.

Computer: Inspiron 5000e. 
Bug: oops when doing cat /proc/apm.

                      Vladimir Dergachev

PS Ksymoops output for test12:
-----------------------------------------------------------------------------
CPU:    0
EIP:    0050:[<00003319>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010046
eax: 000000ff   ebx: 00000001   ecx: 00000000   edx: 00000000
esi: c01da511   edi: 00000014   ebp: cb7e5eac   esp: cb7e5ea4
ds: 0058   es: 0000   ss: 0018
Process cat (pid: 149, stackpage=cb7e5000)
Stack: 5c0f5a94 00005eac 00000058 a51100ff 5ec00050 00000001 530a0000 00000016
       00485c5f 08040000 cb7e5f30 c0110bc2 00000010 cb7e5f30 000000ff c13d0018
       00000018 ffffffff c01da511 000000ff ffffffff 00000292 c0110000 08040000
Call Trace: [<c0110bc2>] [<c01da511>] [<c0110000>] [<c0110d57>]
[<c0111a2e>] [<c01484f0>] [<c012fa06>]
       [<c010a88b>]
Code:  Bad EIP value.
 
>>EIP; 00003319 Before first symbol   <=====
Trace; c0110bc2 <apm_bios_call+3e/7c>
Trace; c01da511 <error_table+48d/5784>
Trace; c0110000 <pci_conf2_read_config_word+4/60>
Trace; c0110d57 <apm_get_power_status+3b/74>
Trace; c0111a2e <apm_get_info+3a/e8>
Trace; c01484f0 <proc_file_read+b4/1c8>
Trace; c012fa06 <sys_read+8e/c4>
Trace; c010a88b <system_call+33/38>
                                                                                

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
