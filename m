Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262011AbTIWPk1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 11:40:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262041AbTIWPk1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 11:40:27 -0400
Received: from main.gmane.org ([80.91.224.249]:26772 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262011AbTIWPkH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 11:40:07 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Orion Poplawski <orion@cora.nwra.com>
Subject: oops on redhat 9 kernel 2.4.20-20.9
Date: Tue, 23 Sep 2003 09:40:02 -0600
Message-ID: <bkppgj$2oc$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

System is basically stock & updated redhat 9.  Kernel is tainted by the 
nvidia driver, but I hope that is not counted too heavily against me.

ksymoops 2.4.5 on i686 2.4.20-20.9.  Options used
      -V (default)
      -k /proc/ksyms (default)
      -l /proc/modules (default)
      -o /lib/modules/2.4.20-20.9/ (default)
      -m /boot/System.map-2.4.20-20.9 (default)
      -i

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Sep 22 23:39:49 traveler kernel: Unable to handle kernel paging request 
at virtual address a5b55045
Sep 22 23:39:49 traveler kernel: c013a4ec
Sep 22 23:39:49 traveler kernel: *pde = 00000000
Sep 22 23:39:49 traveler kernel: Oops: 0002
Sep 22 23:39:49 traveler kernel: CPU:    0
Sep 22 23:39:49 traveler kernel: EIP:    0060:[<c013a4ec>]    Tainted: P
Using defaults from ksymoops -t elf32-i386 -a i386
Sep 22 23:39:49 traveler kernel: EFLAGS: 00010002
Sep 22 23:39:49 traveler kernel: eax: c25a4e90   ebx: c25a4e88   ecx: 
d6272000   edx: a5b55041
Sep 22 23:39:49 traveler kernel: esi: c25a4e80   edi: 00000246   ebp: 
000000f0   esp: c393bd8c
Sep 22 23:39:49 traveler kernel: ds: 0068   es: 0068   ss: 0068
Sep 22 23:39:49 traveler kernel: Process idl (pid: 5277, stackpage=c393b000)
Sep 22 23:39:49 traveler kernel: Stack: d6bf3f18 00000292 d75de680 
c393be24 dbcb6880 c393bdf8 e1c4bf10 c25a4e80
Sep 22 23:39:49 traveler kernel:        000000f0 00000000 00000001 
d22e1f90 d22e1f80 00000001 c393be24 e1c4a30c
Sep 22 23:39:49 traveler kernel:        d22e1f80 c393bdf8 d22e1f80 
00000000 c393be24 00000001 c393bdf8 e1c4c0b0
Sep 22 23:39:49 traveler kernel: Call Trace:   [<e1c4bf10>] 
nfs_pagein_one [nfs] 0x30 (0xc393bda4))
Sep 22 23:39:49 traveler kernel: [<e1c4a30c>] nfs_coalesce_requests 
[nfs] 0x7c (0xc393bdc8))
Sep 22 23:39:49 traveler kernel: [<e1c4c0b0>] nfs_pagein_list [nfs] 0x60 
(0xc393bde8))
Sep 22 23:39:49 traveler kernel: [<e1c4c28a>] nfs_pagein_inode [nfs] 
0x7a (0xc393be10))
Sep 22 23:39:49 traveler kernel: [<e1c4bcb6>] nfs_readpage_async [nfs] 
0x116 (0xc393be3c))
Sep 22 23:39:49 traveler kernel: [<e1c4c652>] nfs_readpage [nfs] 0xb2 
(0xc393be64))
Sep 22 23:39:49 traveler kernel: [<c0133880>] page_cache_read [kernel] 
0xc0 (0xc393be8c))
Sep 22 23:39:49 traveler kernel: [<c013408b>] generic_file_readahead 
[kernel] 0xdb (0xc393beb4))
Sep 22 23:39:49 traveler kernel: [<c0134541>] do_generic_file_read 
[kernel] 0x371 (0xc393bee4))
Sep 22 23:39:49 traveler kernel: [<c0134960>] file_read_actor [kernel] 
0x0 (0xc393bf10))
Sep 22 23:39:49 traveler kernel: [<c0134af0>] generic_file_read [kernel] 
0xb0 (0xc393bf30))
Sep 22 23:39:49 traveler kernel: [<c0134960>] file_read_actor [kernel] 
0x0 (0xc393bf40))
Sep 22 23:39:49 traveler kernel: [<e1c46018>] nfs_file_read [nfs] 0x98 
(0xc393bf6c))
Sep 22 23:39:49 traveler kernel: [<c0147513>] sys_read [kernel] 0xa3 
(0xc393bf94))
Sep 22 23:39:49 traveler kernel: [<c010953f>] system_call [kernel] 0x33 
(0xc393bfc0))
Sep 22 23:39:49 traveler kernel: Code: 89 42 04 8b 46 08 89 48 04 89 01 
89 59 04 89 4e 08 eb 83 57


 >>EIP; c013a4ec <__kmem_cache_alloc+ac/100>   <=====

 >>eax; c25a4e90 <_end+21c5d10/2042dee0>
 >>ebx; c25a4e88 <_end+21c5d08/2042dee0>
 >>ecx; d6272000 <_end+15e92e80/2042dee0>
 >>edx; a5b55041 Before first symbol
 >>esi; c25a4e80 <_end+21c5d00/2042dee0>
 >>esp; c393bd8c <_end+355cc0c/2042dee0>

Trace; e1c4bf10 <[nfs]nfs_pagein_one+30/170>
Trace; e1c4a30c <[nfs]nfs_coalesce_requests+7c/c0>
Trace; e1c4c0b0 <[nfs]nfs_pagein_list+60/90>
Trace; e1c4c28a <[nfs]nfs_pagein_inode+7a/80>
Trace; e1c4bcb6 <[nfs]nfs_readpage_async+116/130>
Trace; e1c4c652 <[nfs]nfs_readpage+b2/f0>
Trace; c0133880 <page_cache_read+c0/e0>
Trace; c013408b <generic_file_readahead+db/1a0>
Trace; c0134541 <do_generic_file_read+371/4f0>
Trace; c0134960 <file_read_actor+0/e0>
Trace; c0134af0 <generic_file_read+b0/160>
Trace; c0134960 <file_read_actor+0/e0>
Trace; e1c46018 <[nfs]nfs_file_read+98/f0>
Trace; c0147513 <sys_read+a3/140>
Trace; c010953f <system_call+33/38>

Code;  c013a4ec <__kmem_cache_alloc+ac/100>
00000000 <_EIP>:
Code;  c013a4ec <__kmem_cache_alloc+ac/100>   <=====
    0:   89 42 04                  mov    %eax,0x4(%edx)   <=====
Code;  c013a4ef <__kmem_cache_alloc+af/100>
    3:   8b 46 08                  mov    0x8(%esi),%eax
Code;  c013a4f2 <__kmem_cache_alloc+b2/100>
    6:   89 48 04                  mov    %ecx,0x4(%eax)
Code;  c013a4f5 <__kmem_cache_alloc+b5/100>
    9:   89 01                     mov    %eax,(%ecx)
Code;  c013a4f7 <__kmem_cache_alloc+b7/100>
    b:   89 59 04                  mov    %ebx,0x4(%ecx)
Code;  c013a4fa <__kmem_cache_alloc+ba/100>
    e:   89 4e 08                  mov    %ecx,0x8(%esi)
Code;  c013a4fd <__kmem_cache_alloc+bd/100>
   11:   eb 83                     jmp    ffffff96 <_EIP+0xffffff96>
Code;  c013a4ff <__kmem_cache_alloc+bf/100>
   13:   57                        push   %edi


1 warning issued.  Results may not be reliable.

Module                  Size  Used by    Tainted: P
maestro3               30960   1  (autoclean)
ac97_codec             14568   0  (autoclean) [maestro3]
soundcore               6404   2  (autoclean) [maestro3]
nfs                    81336   2  (autoclean)
agpgart                48128   3  (autoclean)
nvidia               1764992  12  (autoclean)
parport_pc             19076   1  (autoclean)
lp                      8996   0  (autoclean)
parport                37056   1  (autoclean) [parport_pc lp]
nfsd                   80176   8  (autoclean)
lockd                  58704   1  (autoclean) [nfs nfsd]
sunrpc                 81564   1  (autoclean) [nfs nfsd lockd]
iptable_filter          2412   0  (autoclean) (unused)
ip_tables              15096   1  [iptable_filter]
autofs                 13268   5  (autoclean)
ds                      8680   2
yenta_socket           13504   2
pcmcia_core            57216   0  [ds yenta_socket]
3c59x                  30736   1
ohci1394               20168   0  (unused)
ieee1394               48780   0  [ohci1394]
nls_iso8859-1           3516   1  (autoclean)
nls_cp437               5148   1  (autoclean)
vfat                   13004   1  (autoclean)
fat                    38808   0  (autoclean) [vfat]
keybdev                 2976   0  (unused)
mousedev                5556   1
hid                    22244   0  (unused)
input                   5856   0  [keybdev mousedev hid]
usb-uhci               26412   0  (unused)
usbcore                79040   1  [hid usb-uhci]
ext3                   70784   4
jbd                    51924   4  [ext3]


