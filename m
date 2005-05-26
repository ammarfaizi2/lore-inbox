Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261249AbVEZHnd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbVEZHnd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 03:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbVEZHnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 03:43:33 -0400
Received: from smtp05.auna.com ([62.81.186.15]:15809 "EHLO smtp05.retemail.es")
	by vger.kernel.org with ESMTP id S261249AbVEZHnW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 03:43:22 -0400
Date: Thu, 26 May 2005 07:43:12 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: 2.6.12-rc5-mm1
To: Andrew Morton <akpm@osdl.org>
Cc: Ed Tomlinson <tomlins@cam.org>, linux-kernel@vger.kernel.org,
       alsa-devel@lists.sourceforge.net
References: <20050525134933.5c22234a.akpm@osdl.org>
	<200505252243.21092.tomlins@cam.org>
	<20050525204107.722504bd.akpm@osdl.org>
In-Reply-To: <20050525204107.722504bd.akpm@osdl.org> (from akpm@osdl.org on
	Thu May 26 05:41:07 2005)
X-Mailer: Balsa 2.3.2
Message-Id: <1117093392l.17165l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Auth-Info: Auth:LOGIN IP:[83.138.219.120] Login:jamagallon@able.es Fecha:Thu, 26 May 2005 09:43:12 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 05.26, Andrew Morton wrote:
> 
> (Added alsa-devel to cc)
> 
> Ed Tomlinson <tomlins@cam.org> wrote:
> > 
> > Got the following when I tried to use sound.  Anyone else see problems in alsa land?
> > 

Me too. As beep-media-player ends playing a mp3 track, oops !
Decoded below, for if it gives additional info:

ksymoops 2.4.9 on i686 2.6.11-jam20.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.11-jam20/ (default)
     -m /boot/System.map-2.6.11-jam20 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
May 26 09:35:15 werewolf kernel:  <1>Unable to handle kernel paging request at virtual address a5a5c060
May 26 09:35:15 werewolf kernel: f0a08f70
May 26 09:35:15 werewolf kernel: *pde = 0295d067
May 26 09:35:15 werewolf kernel: Oops: 0000 [#2]
May 26 09:35:15 werewolf kernel: CPU:    0
May 26 09:35:15 werewolf kernel: EIP:    0060:[pg0+1079750512/1337656320]    Tainted: P      VLI
May 26 09:35:15 werewolf kernel: EIP:    0060:[<f0a08f70>]    Tainted: P      VLI
Using defaults from ksymoops -t elf32-i386 -a i386
May 26 09:35:15 werewolf kernel: EFLAGS: 00210282   (2.6.11-jam20) 
May 26 09:35:15 werewolf kernel: eax: a5a5c000   ebx: eebba67c   ecx: b2101f08   edx: f0a08f6d
May 26 09:35:15 werewolf kernel: esi: eebba6a4   edi: b26b7c78   ebp: c6da6680   esp: b2d50f6c
May 26 09:35:15 werewolf kernel: ds: 007b   es: 007b   ss: 0068
May 26 09:35:15 werewolf kernel: Stack: b0147ce3 00000000 eec3d580 b26b7c78 a5a5c000 b0149469 a5a4c000 eec3d580 
May 26 09:35:15 werewolf kernel:        b01497ce a5a4c000 a5a5c000 be93d120 eec3d580 eec3d5b0 00000002 b2d50000 
May 26 09:35:15 werewolf kernel:        b014983a a5a4c000 000000b8 b0102b0b a5a4c000 00010000 a6d131b4 000000b8 
May 26 09:35:15 werewolf kernel: Call Trace:
May 26 09:35:15 werewolf kernel:  [<b0147ce3>] remove_vm_struct+0x46/0x68
May 26 09:35:15 werewolf kernel:  [<b0149469>] unmap_vma_list+0xe/0x17
May 26 09:35:15 werewolf kernel:  [<b01497ce>] do_munmap+0xcb/0xff
May 26 09:35:15 werewolf kernel:  [<b014983a>] sys_munmap+0x38/0x50
May 26 09:35:15 werewolf kernel:  [<b0102b0b>] sysenter_past_esp+0x54/0x75
May 26 09:35:15 werewolf kernel: Code: e1 05 03 0d b0 c4 43 b0 eb c9 c7 42 44 9c 4d a1 f0 89 42 50 81 4a 14 00 00 08 00 8b 40 60 f0 ff 80 a4 00 00 00 31 c0 c3 8b 40 50 <8b> 40 60 f0 ff 88 a4 00 00 00 c3 8b 40 50 8b 40 60 f0 ff 80 a4 


>>EIP; f0a08f70 <pg0+405baf70/4fbb0400>   <=====

>>eax; a5a5c000 <phys_startup_32+a595c000/b0000000>
>>ebx; eebba67c <pg0+3e76c67c/4fbb0400>
>>ecx; b2101f08 <pg0+1cb3f08/4fbb0400>
>>edx; f0a08f6d <pg0+405baf6d/4fbb0400>
>>esi; eebba6a4 <pg0+3e76c6a4/4fbb0400>
>>edi; b26b7c78 <pg0+2269c78/4fbb0400>
>>ebp; c6da6680 <pg0+16958680/4fbb0400>
>>esp; b2d50f6c <pg0+2902f6c/4fbb0400>

Trace; b0147ce3 <remove_vm_struct+46/68>
Trace; b0149469 <unmap_vma_list+e/17>
Trace; b01497ce <do_munmap+cb/ff>
Trace; b014983a <sys_munmap+38/50>
Trace; b0102b0b <sysenter_past_esp+54/75>

This architecture has variable length instructions, decoding before eip
is unreliable, take these instructions with a pinch of salt.

Code;  f0a08f45 <pg0+405baf45/4fbb0400>
00000000 <_EIP>:
Code;  f0a08f45 <pg0+405baf45/4fbb0400>
   0:   e1 05                     loope  7 <_EIP+0x7>
Code;  f0a08f47 <pg0+405baf47/4fbb0400>
   2:   03 0d b0 c4 43 b0         add    0xb043c4b0,%ecx
Code;  f0a08f4d <pg0+405baf4d/4fbb0400>
   8:   eb c9                     jmp    ffffffd3 <_EIP+0xffffffd3>
Code;  f0a08f4f <pg0+405baf4f/4fbb0400>
   a:   c7 42 44 9c 4d a1 f0      movl   $0xf0a14d9c,0x44(%edx)
Code;  f0a08f56 <pg0+405baf56/4fbb0400>
  11:   89 42 50                  mov    %eax,0x50(%edx)
Code;  f0a08f59 <pg0+405baf59/4fbb0400>
  14:   81 4a 14 00 00 08 00      orl    $0x80000,0x14(%edx)
Code;  f0a08f60 <pg0+405baf60/4fbb0400>
  1b:   8b 40 60                  mov    0x60(%eax),%eax
Code;  f0a08f63 <pg0+405baf63/4fbb0400>
  1e:   f0 ff 80 a4 00 00 00      lock incl 0xa4(%eax)
Code;  f0a08f6a <pg0+405baf6a/4fbb0400>
  25:   31 c0                     xor    %eax,%eax
Code;  f0a08f6c <pg0+405baf6c/4fbb0400>
  27:   c3                        ret    
Code;  f0a08f6d <pg0+405baf6d/4fbb0400>
  28:   8b 40 50                  mov    0x50(%eax),%eax

This decode from eip onwards should be reliable

Code;  f0a08f70 <pg0+405baf70/4fbb0400>
00000000 <_EIP>:
Code;  f0a08f70 <pg0+405baf70/4fbb0400>   <=====
   0:   8b 40 60                  mov    0x60(%eax),%eax   <=====
Code;  f0a08f73 <pg0+405baf73/4fbb0400>
   3:   f0 ff 88 a4 00 00 00      lock decl 0xa4(%eax)
Code;  f0a08f7a <pg0+405baf7a/4fbb0400>
   a:   c3                        ret    
Code;  f0a08f7b <pg0+405baf7b/4fbb0400>
   b:   8b 40 50                  mov    0x50(%eax),%eax
Code;  f0a08f7e <pg0+405baf7e/4fbb0400>
   e:   8b 40 60                  mov    0x60(%eax),%eax
Code;  f0a08f81 <pg0+405baf81/4fbb0400>
  11:   f0                        lock
Code;  f0a08f82 <pg0+405baf82/4fbb0400>
  12:   ff                        .byte 0xff
Code;  f0a08f83 <pg0+405baf83/4fbb0400>
  13:   80                        .byte 0x80
Code;  f0a08f84 <pg0+405baf84/4fbb0400>
  14:   a4                        movsb  %ds:(%esi),%es:(%edi)


1 warning and 1 error issued.  Results may not be reliable.

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandriva Linux release 2006.0 (Cooker) for i586
Linux 2.6.11-jam20 (gcc 4.0.0 (4.0.0-3mdk for Mandriva Linux release 2006.0))


