Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265959AbUA1N7s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 08:59:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265960AbUA1N7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 08:59:48 -0500
Received: from maximus.kcore.de ([213.133.102.235]:55386 "EHLO
	maximus.kcore.de") by vger.kernel.org with ESMTP id S265959AbUA1N7l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 08:59:41 -0500
From: Oliver Feiler <kiza@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: 2.6.1-rc2 + aha152x still oopses
Date: Wed, 28 Jan 2004 14:58:46 +0100
User-Agent: KMail/1.5
Cc: "Randy.Dunlap" <rddunlap@osdl.org>
X-PGP-Key-Fingerprint: E9DD 32F1 FA8A 0945 6A74  07DE 3A98 9F65 561D 4FD2
X-PGP-Key: http://kiza.kcore.de/pgpkey
X-Species: Snow Leopard
X-Operating-System: Linux
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_XA8FAd+yUCIu3Fc"
Message-Id: <200401281458.47217.kiza@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_XA8FAd+yUCIu3Fc
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

this is related to my post from Jan 7th, see 
http://lkml.org/lkml/2004/1/6/202.

The Oops in the aha152x driver was supposed to be fixed in 2.6.1-rc1 from what 
I was told. I've been running 2.6.1-rc2 and indeed it didn't happen with that 
kernel. Today however I got a slightly different oops with the same kernel. I 
didn't see any changes to the driver since 2.6.1-rc2 so I didn't upgrade 
(takes a long time to compile on a 486).

I got two oopses which I attached to this mail. After that the system needed 
to be resetted. Is this a new problem or did I just miss changes to the 
driver and it is already fixed in 2.6.2-rc2?

Bye,
Oliver

-- 
Oliver Feiler  <kiza@(kcore.de|lionking.org|gmx[pro].net)>

--Boundary-00=_XA8FAd+yUCIu3Fc
Content-Type: text/plain;
  charset="us-ascii";
  name="ksymoops"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="ksymoops"

ksymoops 2.4.8 on i486 2.6.1-rc2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.1-rc2/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Jan 28 12:32:00 deekin kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
Jan 28 12:32:00 deekin kernel: c0207030
Jan 28 12:32:00 deekin kernel: *pde = 00000000
Jan 28 12:32:00 deekin kernel: Oops: 0000 [#1]
Jan 28 12:32:00 deekin kernel: CPU:    0
Jan 28 12:32:00 deekin kernel: EIP:    0060:[<c0207030>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Jan 28 12:32:00 deekin kernel: EFLAGS: 00010086
Jan 28 12:32:00 deekin kernel: eax: 00000000   ebx: c13ce000   ecx: c13dcc70   edx: c13e4b90
Jan 28 12:32:00 deekin kernel: esi: c13e5800   edi: 00000202   ebp: 00000002   esp: c13cff34
Jan 28 12:32:00 deekin kernel: ds: 007b   es: 007b   ss: 0068
Jan 28 12:32:00 deekin kernel: Stack: c13e5800 00000008 00000000 c13ce000 c0209643 c13e5800 001874c3 00000000 
Jan 28 12:32:00 deekin kernel:        c0316224 c0316220 c13fdc10 c0206da0 c13e5800 00000202 c0125fcd 00000000 
Jan 28 12:32:00 deekin kernel:        c13fdc28 c13fdc20 c13ce000 c13ce000 c13ce000 00000000 c0206d70 c13ce000 
Jan 28 12:32:00 deekin kernel: Call Trace:
Jan 28 12:32:00 deekin kernel:  [<c0209643>] is_complete+0x2b3/0x300
Jan 28 12:32:00 deekin kernel:  [<c0206da0>] run+0x30/0x40
Jan 28 12:32:00 deekin kernel:  [<c0125fcd>] worker_thread+0x1bd/0x2b0
Jan 28 12:32:00 deekin kernel:  [<c0206d70>] run+0x0/0x40
Jan 28 12:32:00 deekin kernel:  [<c0113e00>] default_wake_function+0x0/0x20
Jan 28 12:32:00 deekin kernel:  [<c0108ec6>] ret_from_fork+0x6/0x20
Jan 28 12:32:00 deekin kernel:  [<c0113e00>] default_wake_function+0x0/0x20
Jan 28 12:32:00 deekin kernel:  [<c0125e10>] worker_thread+0x0/0x2b0
Jan 28 12:32:00 deekin kernel:  [<c0107055>] kernel_thread_helper+0x5/0x10
Jan 28 12:32:00 deekin kernel: Code: 8b 00 89 86 a8 01 00 00 8b 82 28 01 00 00 c7 00 00 00 00 00 


>>EIP; c0207030 <busfree_run+1a0/4e0>   <=====

>>ebx; c13ce000 <__crc_bio_unmap_user+13f83d/148c66>
>>ecx; c13dcc70 <__crc_generic_file_write_nolock+5847/2ac2e>
>>edx; c13e4b90 <__crc_generic_file_write_nolock+d767/2ac2e>
>>esi; c13e5800 <__crc_generic_file_write_nolock+e3d7/2ac2e>
>>esp; c13cff34 <__crc_bio_unmap_user+141771/148c66>

Trace; c0209643 <is_complete+2b3/300>
Trace; c0206da0 <run+30/40>
Trace; c0125fcd <worker_thread+1bd/2b0>
Trace; c0206d70 <run+0/40>
Trace; c0113e00 <default_wake_function+0/20>
Trace; c0108ec6 <ret_from_fork+6/20>
Trace; c0113e00 <default_wake_function+0/20>
Trace; c0125e10 <worker_thread+0/2b0>
Trace; c0107055 <kernel_thread_helper+5/10>

Code;  c0207030 <busfree_run+1a0/4e0>
00000000 <_EIP>:
Code;  c0207030 <busfree_run+1a0/4e0>   <=====
   0:   8b 00                     mov    (%eax),%eax   <=====
Code;  c0207032 <busfree_run+1a2/4e0>
   2:   89 86 a8 01 00 00         mov    %eax,0x1a8(%esi)
Code;  c0207038 <busfree_run+1a8/4e0>
   8:   8b 82 28 01 00 00         mov    0x128(%edx),%eax
Code;  c020703e <busfree_run+1ae/4e0>
   e:   c7 00 00 00 00 00         movl   $0x0,(%eax)

Jan 28 12:32:30 deekin kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
Jan 28 12:32:30 deekin kernel: c02066e9
Jan 28 12:32:30 deekin kernel: *pde = 00000000
Jan 28 12:32:30 deekin kernel: Oops: 0000 [#2]
Jan 28 12:32:30 deekin kernel: CPU:    0
Jan 28 12:32:30 deekin kernel: EIP:    0060:[<c02066e9>]    Not tainted
Jan 28 12:32:30 deekin kernel: EFLAGS: 00010046
Jan 28 12:32:30 deekin kernel: eax: 00000000   ebx: c13e4b90   ecx: c13e4b90   edx: 00000000
Jan 28 12:32:30 deekin kernel: esi: c13e5800   edi: 00000086   ebp: c13e59a8   esp: c13e1f60
Jan 28 12:32:30 deekin kernel: ds: 007b   es: 007b   ss: 0068
Jan 28 12:32:30 deekin kernel: Stack: c13e0000 00000206 c13e1fb4 c13e1fac c020059f c13e4b90 c13e4b90 c13e1fb4 
Jan 28 12:32:30 deekin kernel:        c13e1fb4 c02006d6 c13e4b90 c13e5830 c13e0000 c13e1fb4 c13e1fac c020103b 
Jan 28 12:32:30 deekin kernel:        c13e1fb4 c13e1fac c13e1fb4 c13e1fac c13e1fac c13e4ba8 c13e4ba8 c13e5800 
Jan 28 12:32:30 deekin kernel: Call Trace:
Jan 28 12:32:30 deekin kernel:  [<c020059f>] scsi_try_to_abort_cmd+0x4f/0x70
Jan 28 12:32:30 deekin kernel:  [<c02006d6>] scsi_eh_abort_cmds+0x56/0x90
Jan 28 12:32:30 deekin kernel:  [<c020103b>] scsi_unjam_host+0xab/0xd0
Jan 28 12:32:30 deekin kernel:  [<c0201136>] scsi_error_handler+0xd6/0x110
Jan 28 12:32:30 deekin kernel:  [<c0201060>] scsi_error_handler+0x0/0x110
Jan 28 12:32:30 deekin kernel:  [<c0107055>] kernel_thread_helper+0x5/0x10
Jan 28 12:32:30 deekin kernel: Code: 8b 00 89 45 00 e9 13 ff ff ff 85 db 53 ba ff ff ff ff 74 06 


>>EIP; c02066e9 <aha152x_abort+159/1c0>   <=====

>>ebx; c13e4b90 <__crc_generic_file_write_nolock+d767/2ac2e>
>>ecx; c13e4b90 <__crc_generic_file_write_nolock+d767/2ac2e>
>>esi; c13e5800 <__crc_generic_file_write_nolock+e3d7/2ac2e>
>>ebp; c13e59a8 <__crc_generic_file_write_nolock+e57f/2ac2e>
>>esp; c13e1f60 <__crc_generic_file_write_nolock+ab37/2ac2e>

Trace; c020059f <scsi_try_to_abort_cmd+4f/70>
Trace; c02006d6 <scsi_eh_abort_cmds+56/90>
Trace; c020103b <scsi_unjam_host+ab/d0>
Trace; c0201136 <scsi_error_handler+d6/110>
Trace; c0201060 <scsi_error_handler+0/110>
Trace; c0107055 <kernel_thread_helper+5/10>

Code;  c02066e9 <aha152x_abort+159/1c0>
00000000 <_EIP>:
Code;  c02066e9 <aha152x_abort+159/1c0>   <=====
   0:   8b 00                     mov    (%eax),%eax   <=====
Code;  c02066eb <aha152x_abort+15b/1c0>
   2:   89 45 00                  mov    %eax,0x0(%ebp)
Code;  c02066ee <aha152x_abort+15e/1c0>
   5:   e9 13 ff ff ff            jmp    ffffff1d <_EIP+0xffffff1d>
Code;  c02066f3 <aha152x_abort+163/1c0>
   a:   85 db                     test   %ebx,%ebx
Code;  c02066f5 <aha152x_abort+165/1c0>
   c:   53                        push   %ebx
Code;  c02066f6 <aha152x_abort+166/1c0>
   d:   ba ff ff ff ff            mov    $0xffffffff,%edx
Code;  c02066fb <aha152x_abort+16b/1c0>
  12:   74 06                     je     1a <_EIP+0x1a>


1 warning and 1 error issued.  Results may not be reliable.

--Boundary-00=_XA8FAd+yUCIu3Fc--

