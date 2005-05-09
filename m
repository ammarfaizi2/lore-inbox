Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261197AbVEIKEg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbVEIKEg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 06:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261209AbVEIKEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 06:04:36 -0400
Received: from tassadar.physics.auth.gr ([155.207.123.25]:6593 "EHLO
	tassadar.physics.auth.gr") by vger.kernel.org with ESMTP
	id S261197AbVEIKEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 06:04:12 -0400
Date: Mon, 9 May 2005 13:03:55 +0300 (EEST)
From: Dimitris Zilaskos <dzila@tassadar.physics.auth.gr>
To: Willy Tarreau <willy@w.ods.org>
cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, openafs-info@openafs.org,
       linux-kernel@vger.kernel.org
Subject: Re: Openafs 1.3.78 and kernel 2.4.29 oopses , same for 2.4.30 and
 openafs 1.3.82
In-Reply-To: <20050507120821.GA18710@alpha.home.local>
Message-ID: <Pine.LNX.4.62.0505091247070.6021@tassadar.physics.auth.gr>
References: <Pine.LNX.4.62.0505060209040.31479@tassadar.physics.auth.gr>
 <20050506052803.GE777@alpha.home.local> <20050506165033.GA2105@logos.cnet>
 <Pine.LNX.4.62.0505071245500.7641@tassadar.physics.auth.gr>
 <20050507100926.GA18418@alpha.home.local> <Pine.LNX.4.62.0505071449430.9934@tassadar.physics.auth.gr>
 <20050507120821.GA18710@alpha.home.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-AntiVirus: checked by AntiVir Milter (version: 1.1.0-4; AVE: 6.30.0.12; VDF: 6.30.0.162; host: tassadar)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



 	Hello ,

I have just completed 44 hours of uptime with 2.4.30 and openafs 1.3.78 . 
Two oops occured at night , but the system did not freeze :

a)

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
May  8 04:03:23 system kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000039
May  8 04:03:23 system kernel: c014d763
May  8 04:03:23 system kernel: *pde = 00000000
May  8 04:03:23 system kernel: Oops: 0000
May  8 04:03:23 system kernel: CPU:    0
May  8 04:03:23 system kernel: EIP:    0010:[<c014d763>]    Tainted: P
Using defaults from ksymoops -t elf32-i386 -a i386
May  8 04:03:23 system kernel: EFLAGS: 00010213
May  8 04:03:23 system kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000039
May  8 04:03:23 system kernel: c014d2c0
May  8 04:03:23 system kernel: *pde = 00000000
May  8 04:03:23 system kernel: eax: 00000001   ebx: 00000001   ecx: f0ab6664   edx: ee91bb40
May  8 04:03:23 system kernel: esi: e5559009   edi: 00000001   ebp: c9403f40   esp: c9403f28
May  8 04:03:23 system kernel: ds: 0018   es: 0018   ss: 0018
May  8 04:03:23 system kernel: Process rsync (pid: 25555, stackpage=c9403000)
May  8 04:03:23 system kernel: Stack: d66a1c40 c9403f40 00000008 00000008 c9403f98 00000001 e5559000 00000009
May  8 04:03:23 system kernel:        0fbf25c9 bfff7950 c9403f98 e5559000 00000000 00000008 c014de69 e5559000
May  8 04:03:23 system kernel:        e5559000 c9403f98 c014e1c9 bfff7950 c0152fa0 c9402000 c9403f98 bfff8960
May  8 04:03:23 system kernel: Call Trace:    [<c014de69>] [<c014e1c9>] [<c0152fa0>] [<c014a06f>] [<c0108ebb>]
May  8 04:03:23 system kernel: Code: 8b 7b 38 85 ff 0f 84 8e 00 00 00 f0 fe 0d e0 c9 41 c0 0f 88


>>EIP; c014d763 <link_path_walk+5c3/ac0>   <=====

>>edx; ee91bb40 <_end+2e4b3700/3042bc20>
>>esi; e5559009 <_end+250f0bc9/3042bc20>
>>ebp; c9403f40 <_end+8f9bb00/3042bc20>
>>esp; c9403f28 <_end+8f9bae8/3042bc20>

Trace; c014de69 <path_lookup+39/40>
Trace; c014e1c9 <__user_walk+49/60>
Trace; c0152fa0 <filldir64+0/130>
Trace; c014a06f <sys_lstat64+1f/90>
Trace; c0108ebb <system_call+33/38>

Code;  c014d763 <link_path_walk+5c3/ac0>
00000000 <_EIP>:
Code;  c014d763 <link_path_walk+5c3/ac0>   <=====
    0:   8b 7b 38                  mov    0x38(%ebx),%edi   <=====
Code;  c014d766 <link_path_walk+5c6/ac0>
    3:   85 ff                     test   %edi,%edi
Code;  c014d768 <link_path_walk+5c8/ac0>
    5:   0f 84 8e 00 00 00         je     99 <_EIP+0x99>
Code;  c014d76e <link_path_walk+5ce/ac0>
    b:   f0 fe 0d e0 c9 41 c0      lock decb 0xc041c9e0
Code;  c014d775 <link_path_walk+5d5/ac0>
   12:   0f 88 00 00 00 00         js     18 <_EIP+0x18>


9 warnings issued.  Results may not be reliable.


b)

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
May  8 04:03:23 system kernel:  Oops: 0000
May  8 04:03:23 system kernel: CPU:    1
May  8 04:03:23 system kernel: EIP:    0010:[<c014d2c0>]    Tainted: P
Using defaults from ksymoops -t elf32-i386 -a i386
May  8 04:03:23 system kernel: EFLAGS: 00010213
May  8 04:03:23 system kernel: eax: 00000001   ebx: 00000001   ecx: f0ad16d0   edx: ee91bb40
May  8 04:03:23 system kernel: esi: d06da04b   edi: 00000001   ebp: c9ccdf40   esp: c9ccdf28
May  8 04:03:23 system kernel: ds: 0018   es: 0018   ss: 0018
May  8 04:03:23 system kernel: Process lftp (pid: 24957, stackpage=c9ccd000)
May  8 04:03:23 system kernel: Stack: d091c0e0 c9ccdf40 00000004 00000009 c9ccdf98 00000001 d06da047 00000003
May  8 04:03:23 system kernel:        0012238c 08390ea8 c9ccdf98 d06da000 00000000 00000009 c014de69 d06da000
May  8 04:03:23 system kernel:        d06da000 c9ccdf98 c014e1c9 08390ea8 fffffffb c9ccc000 c9ccdf98 bffffb50
May  8 04:03:23 system kernel: Call Trace:    [<c014de69>] [<c014e1c9>] [<c0149fdf>] [<c0108ebb>]
May  8 04:03:23 system kernel: Code: 8b 43 38 85 c0 0f 84 8e 00 00 00 f0 fe 0d e0 c9 41 c0 0f 88


>>EIP; c014d2c0 <link_path_walk+120/ac0>   <=====

>>edx; ee91bb40 <_end+2e4b3700/3042bc20>
>>esi; d06da04b <_end+10271c0b/3042bc20>
>>ebp; c9ccdf40 <_end+9865b00/3042bc20>
>>esp; c9ccdf28 <_end+9865ae8/3042bc20>

Trace; c014de69 <path_lookup+39/40>
Trace; c014e1c9 <__user_walk+49/60>
Trace; c0149fdf <sys_stat64+1f/90>
Trace; c0108ebb <system_call+33/38>

Code;  c014d2c0 <link_path_walk+120/ac0>
00000000 <_EIP>:
Code;  c014d2c0 <link_path_walk+120/ac0>   <=====
    0:   8b 43 38                  mov    0x38(%ebx),%eax   <=====
Code;  c014d2c3 <link_path_walk+123/ac0>
    3:   85 c0                     test   %eax,%eax
Code;  c014d2c5 <link_path_walk+125/ac0>
    5:   0f 84 8e 00 00 00         je     99 <_EIP+0x99>
Code;  c014d2cb <link_path_walk+12b/ac0>
    b:   f0 fe 0d e0 c9 41 c0      lock decb 0xc041c9e0
Code;  c014d2d2 <link_path_walk+132/ac0>
   12:   0f 88 00 00 00 00         js     18 <_EIP+0x18>


9 warnings issued.  Results may not be reliable.


Again that happened at the time my afs server restarts . Just before the 
oops :

May  8 04:03:20 system kernel: afs: Lost contact with file server 
1.2.3.4 in cell cell.gr (all multi-homed ip
  addresses down for the server)
May  8 04:03:20 system kernel: afs: Lost contact with file server 
1.2.3.4 in cell cell.gr (all multi-homed ip
  addresses down for the server)
May  8 04:03:21 system kernel: afs: failed to store file (110)


 	Looks like identical behaviour as in 2.4.29 with 1.3.78. From what 
I have observed it seems that those oopses eventually will lead to all 
processes accesing AFS entering D state ,till the system freezes. 
Something in openafs 1.3.82 seems to accelarate this process. I am 
thinking of running a cron job that checks for D state processes and kills 
eveyrthing apart from the absolutetely essential processes if say more 
than 50 enter D state, in an attemp to prevent total system freeze , and 
give 2.4.30 and 1.3.82 another try. Unless you guys have a better 
suggestion:)


   Regards ,

--
=============================================================================

Dimitris Zilaskos

Department of Physics @ Aristotle University of Thessaloniki , Greece
PGP key : http://tassadar.physics.auth.gr/~dzila/pgp_public_key.asc
 	  http://egnatia.ee.auth.gr/~dzila/pgp_public_key.asc
MD5sum  : de2bd8f73d545f0e4caf3096894ad83f  pgp_public_key.asc
=============================================================================
