Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278045AbRJOTUY>; Mon, 15 Oct 2001 15:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278046AbRJOTUO>; Mon, 15 Oct 2001 15:20:14 -0400
Received: from smtp1.vol.cz ([195.250.128.73]:41742 "EHLO smtp1.vol.cz")
	by vger.kernel.org with ESMTP id <S278045AbRJOTUC>;
	Mon, 15 Oct 2001 15:20:02 -0400
Message-ID: <3BCB370D.3000508@volny.cz>
Date: Mon, 15 Oct 2001 21:20:45 +0200
From: Petr Titera <owl@volny.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.10-ac2 i586; en-US; 0.7) Gecko/20010316
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.10 with ext3 Oops
Content-Type: multipart/mixed;
 boundary="------------060700050108050300020509"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060700050108050300020509
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This happened on kernel 2.4.10 patched with ext3-0.9.10 right after I 
killed some processes. I don't know if it is related to this oops.




--------------060700050108050300020509
Content-Type: text/plain;
 name="msg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="msg"

ksymoops 2.4.0 on i586 2.4.10-ac2.  Options used
     -V (default)
     -K (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.4.10-ac2/ (default)
     -m /boot/System.map-2.4.10 (specified)

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Oct 15 20:49:31 nevskij kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
Oct 15 20:49:31 nevskij kernel: 00000000
Oct 15 20:49:31 nevskij kernel: *pde = 00000000
Oct 15 20:49:31 nevskij kernel: Oops: 0000
Oct 15 20:49:31 nevskij kernel: CPU:    0
Oct 15 20:49:31 nevskij kernel: EIP:    0010:[<00000000>]
Using defaults from ksymoops -t elf32-i386 -a i386
Oct 15 20:49:31 nevskij kernel: EFLAGS: 00010286
Oct 15 20:49:31 nevskij kernel: eax: c423fba0   ebx: 00000000   ecx: 000000f0   edx: 00000014
Oct 15 20:49:31 nevskij kernel: esi: c98c2000   edi: cfd63180   ebp: c15fc800   esp: c98c3bc8
Oct 15 20:49:31 nevskij kernel: ds: 0018   es: 0018   ss: 0018
Oct 15 20:49:31 nevskij kernel: Process man (pid: 6223, stackpage=c98c3000)
Oct 15 20:49:31 nevskij kernel: Stack: c02011cc 00000014 000000f0 00000001 00000000 00000000 ffffffe2 cfd63180
Oct 15 20:49:31 nevskij kernel:        c423ffd2 c0152b26 c15fc800 00000001 00000000 c144e0e0 c423ffc5 e25dbf22
Oct 15 20:49:32 nevskij kernel:        cfd63180 c15fc600 00000001 c01431de cfd63180 c98c2000 cfc34240 cfd63180
Oct 15 20:49:32 nevskij kernel: Call Trace: [<c0152b26>] [<c01431de>] [<c01446fa>] [<c013b0e6>] [<c01249da>]
Oct 15 20:49:32 nevskij kernel:    [<c01248f0>] [<c0138d95>] [<c01460f3>] [<c0152a0a>] [<c015d26e>] [<c0158dd4>]
Oct 15 20:49:32 nevskij kernel:    [<c0152b62>] [<c01431de>] [<c01446fa>] [<c01246e5>] [<c0145e50>] [<c0139555>]
Oct 15 20:49:32 nevskij kernel:    [<c01397f0>] [<c013a6bf>] [<c0105940>] [<c0106cf3>]
Oct 15 20:49:32 nevskij kernel: Code:  Bad EIP value.

>>EIP; 00000000 Before first symbol
Trace; c0152b26 <ext3_dirty_inode+36/b0>
Trace; c01431de <__mark_inode_dirty+2e/90>
Trace; c01446fa <update_atime+4a/50>
Trace; c013b0e6 <path_walk+626/770>
Trace; c01249da <generic_file_read+8a/1c0>
Trace; c01248f0 <file_read_actor+0/60>
Trace; c0138d95 <open_exec+25/c0>
Trace; c01460f3 <load_elf_binary+2a3/a90>
Trace; c0152a0a <ext3_reserve_inode_write+3a/e0>
Trace; c015d26e <__jbd_kmalloc+1e/80>
Trace; c0158dd4 <journal_stop+194/1a0>
Trace; c0152b62 <ext3_dirty_inode+72/b0>
Trace; c01431de <__mark_inode_dirty+2e/90>
Trace; c01446fa <update_atime+4a/50>
Trace; c01246e5 <do_generic_file_read+4d5/4e0>
Trace; c0145e50 <load_elf_binary+0/a90>
Trace; c0139555 <search_binary_handler+65/180>
Trace; c01397f0 <do_execve+180/1e0>
Trace; c013a6bf <getname+5f/a0>
Trace; c0105940 <sys_execve+30/60>
Trace; c0106cf3 <system_call+33/40>



--------------060700050108050300020509--

