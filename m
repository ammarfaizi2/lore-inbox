Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261500AbVETRbw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbVETRbw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 13:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261518AbVETRbw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 13:31:52 -0400
Received: from tassadar.physics.auth.gr ([155.207.123.25]:55680 "EHLO
	tassadar.physics.auth.gr") by vger.kernel.org with ESMTP
	id S261503AbVETRbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 13:31:39 -0400
Date: Fri, 20 May 2005 19:17:17 +0300 (EEST)
From: Dimitris Zilaskos <dzila@tassadar.physics.auth.gr>
To: ted creedon <tcreedon@easystreet.com>
cc: openafs-info@openafs.org, linux-kernel@vger.kernel.org
Subject: RE: [OpenAFS] Re: Openafs 1.3.78 and kernel 2.4.29 oopses , same
 for 2.4.30 and openafs 1.3.82
In-Reply-To: <20050519131517.B0079B01C@smtpauth.easystreet.com>
Message-ID: <Pine.LNX.4.62.0505201915320.5473@tassadar.physics.auth.gr>
References: <20050519131517.B0079B01C@smtpauth.easystreet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-AntiVirus: checked by AntiVir Milter (version: 1.1.0-4; AVE: 6.30.0.12; VDF: 6.30.0.188; host: tassadar)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 	Unfortunately , it seems our conclusions were premature:

ksymoops 2.4.11 on i686 2.4.30.  Options used
      -V (default)
      -k /proc/ksyms (default)
      -l /proc/modules (default)
      -o /lib/modules/2.4.30/ (default)
      -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): libafs-2.4.30.mp symbol kallsyms_address_to_symbol not found in /usr/local/lib/openafs/libafs-2.4.30.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.30.mp.o entry
Warning (compare_maps): libafs-2.4.30.mp symbol kallsyms_symbol_to_address not found in /usr/local/lib/openafs/libafs-2.4.30.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.30.mp.o entry
Warning (compare_maps): libafs-2.4.30.mp symbol sys_chdir not found in /usr/local/lib/openafs/libafs-2.4.30.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.30.mp.o entry
Warning (compare_maps): libafs-2.4.30.mp symbol sys_exit not found in /usr/local/lib/openafs/libafs-2.4.30.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.30.mp.o entry
Warning (compare_maps): libafs-2.4.30.mp symbol sys_ioctl not found in /usr/local/lib/openafs/libafs-2.4.30.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.30.mp.o entry
Warning (compare_maps): libafs-2.4.30.mp symbol sys_open not found in /usr/local/lib/openafs/libafs-2.4.30.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.30.mp.o entry
Warning (compare_maps): libafs-2.4.30.mp symbol sys_wait4 not found in /usr/local/lib/openafs/libafs-2.4.30.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.30.mp.o entry
Warning (compare_maps): libafs-2.4.30.mp symbol sys_write not found in /usr/local/lib/openafs/libafs-2.4.30.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.30.mp.o entry
May 20 15:31:15 system kernel: dcache hc<1>Unable to handle kernel paging request at virtual address ffffffff
May 20 15:31:15 system kernel: f09de170
May 20 15:31:15 system kernel: *pde = 00004063
May 20 15:31:15 system kernel: Oops: 0002
May 20 15:31:15 system kernel: CPU:    1
May 20 15:31:15 system kernel: EIP:    0010:[<f09de170>]    Tainted: P
Using defaults from ksymoops -t elf32-i386 -a i386
May 20 15:31:15 system kernel: EFLAGS: 00010282
May 20 15:31:15 system kernel: eax: 00000009   ebx: 000a93f4   ecx: 00000082   edx: ef0c7f84
May 20 15:31:15 system kernel: esi: f1e0f5f8   edi: f0ae2000   ebp: 00000001   esp: c8d15dd4
May 20 15:31:15 system kernel: ds: 0018   es: 0018   ss: 0018
May 20 15:31:15 system kernel: Process afs_cachetrim (pid: 938, stackpage=c8d15000)
May 20 15:31:15 system kernel: Stack: f0a03fe1 f099fc43 00000010 f1e0f66c f1e0f5f8 0000000f 00000001 f099fc0f
May 20 15:31:15 system kernel:        f0a03fe1 f099fc43 00000010 f1e0f66c 00528f57 f1e0f5f8 0000000f f099f897
May 20 15:31:15 system kernel:        f1e0f5f8 00000000 00000000 000003aa ecf4a7f0 00000000 00000000 c8d14000
May 20 15:31:15 system kernel: Call Trace:    [<f0a03fe1>] [<f099fc43>] [<f099fc0f>] [<f0a03fe1>] [<f099fc43>]
May 20 15:31:15 system kernel:   [<f099f897>] [<f099ef5e>] [<f0a0caa0>] [<f0a0caa0>] [<f09efe39>] [<f0a0509c>]
May 20 15:31:15 system kernel:   [<c010740e>] [<f09efad0>]
May 20 15:31:15 system kernel: Code: c6 05 ff ff ff ff 2a 83 c4 1c c3 90 8d 74 26 00 b8 f9 4a a0


>>EIP; f09de170 <[libafs-2.4.30.mp]osi_Panic+20/40>   <=====

>>edx; ef0c7f84 <_end+2ec5fb44/3042bc20>
>>esp; c8d15dd4 <_end+88ad994/3042bc20>

Trace; f0a03fe1 <[libafs-2.4.30.mp].rodata.end+60e6/e545>
Trace; f099fc43 <[libafs-2.4.30.mp]afs_HashOutDCache+b3/120>
Trace; f099fc0f <[libafs-2.4.30.mp]afs_HashOutDCache+7f/120>
Trace; f0a03fe1 <[libafs-2.4.30.mp].rodata.end+60e6/e545>
Trace; f099fc43 <[libafs-2.4.30.mp]afs_HashOutDCache+b3/120>
Trace; f099f897 <[libafs-2.4.30.mp]afs_GetDownD+567/860>
Trace; f099ef5e <[libafs-2.4.30.mp]afs_CacheTruncateDaemon+10e/460>
Trace; f0a0caa0 <[libafs-2.4.30.mp]afs_global_lock+0/20>
Trace; f0a0caa0 <[libafs-2.4.30.mp]afs_global_lock+0/20>
Trace; f09efe39 <[libafs-2.4.30.mp]afsd_thread+369/5d0>
Trace; f0a0509c <[libafs-2.4.30.mp].rodata.end+71a1/e545>
Trace; c010740e <arch_kernel_thread+2e/40>
Trace; f09efad0 <[libafs-2.4.30.mp]afsd_thread+0/5d0>

Code;  f09de170 <[libafs-2.4.30.mp]osi_Panic+20/40>
00000000 <_EIP>:
Code;  f09de170 <[libafs-2.4.30.mp]osi_Panic+20/40>   <=====
    0:   c6 05 ff ff ff ff 2a      movb   $0x2a,0xffffffff   <=====
Code;  f09de177 <[libafs-2.4.30.mp]osi_Panic+27/40>
    7:   83 c4 1c                  add    $0x1c,%esp
Code;  f09de17a <[libafs-2.4.30.mp]osi_Panic+2a/40>
    a:   c3                        ret 
Code;  f09de17b <[libafs-2.4.30.mp]osi_Panic+2b/40>
    b:   90                        nop 
Code;  f09de17c <[libafs-2.4.30.mp]osi_Panic+2c/40>
    c:   8d 74 26 00               lea    0x0(%esi),%esi
Code;  f09de180 <[libafs-2.4.30.mp]osi_Panic+30/40>
   10:   b8 f9 4a a0 00            mov    $0xa04af9,%eax


9 warnings issued.  Results may not be reliable.


--
=============================================================================

Dimitris Zilaskos

Department of Physics @ Aristotle University of Thessaloniki , Greece
PGP key : http://tassadar.physics.auth.gr/~dzila/pgp_public_key.asc
 	  http://egnatia.ee.auth.gr/~dzila/pgp_public_key.asc
MD5sum  : de2bd8f73d545f0e4caf3096894ad83f  pgp_public_key.asc
=============================================================================

