Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317007AbSFWLlC>; Sun, 23 Jun 2002 07:41:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317008AbSFWLlB>; Sun, 23 Jun 2002 07:41:01 -0400
Received: from [200.181.158.69] ([200.181.158.69]:57862 "EHLO
	firewall.PolesApart.dhs.org") by vger.kernel.org with ESMTP
	id <S317007AbSFWLlA>; Sun, 23 Jun 2002 07:41:00 -0400
Date: Sun, 23 Jun 2002 08:40:54 -0300 (BRT)
From: Alexandre Pereira Nunes <alex@PolesApart.dhs.org>
To: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 2.4.19-pre10-ac2 bug in page_alloc.c:131
In-Reply-To: <20020623130725.7e0176a8.diegocg@teleline.es>
Message-ID: <Pine.LNX.4.44.0206230838150.276-100000@PolesApart.dhs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Jun 2002, Diego Calleja wrote:

>
> It'd be nice if you could pass this oops throught ksymoops....
>

Ok, here it is...

Cheers,

Alexandre

>---------------------------------------------------

ksymoops 2.4.5 on i686 2.4.19-pre10-ac2.  Options used
     -v /usr/src/linux-2.4.19-pre/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19-pre10-ac2/ (default)
     -m /usr/src/linux/System.map (default)

kernel BUG at page_alloc.c:131!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c014177e>]    Tainted: P
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: cba53f48   ebx: c144955c   ecx: c025f6dc   edx: 00000000
esi: 00000000   edi: 138de070   ebp: 00001000   esp: c41b7ec8
ds: 0018   es: 0018   ss: 0018
Process X (pid: 3924, stackpage=c41b7000)
Stack: c144955c c0142fca c02ba2a0 00000000 00000001 c144955c 00000000 138de070
       d38de070 00000000 138de070 00001000 c01351c6 c144955c 0000000e d2fca688
       0000000e 00000001 40400000 cd841404 4001d000 00000000 c013320b d5decd40
Call Trace: [<c0142fca>] [<c01351c6>] [<c013320b>] [<c01367a1>] [<c01368ca>]
   [<c010ba0f>]
Code: 0f 0b 83 00 53 b0 23 c0 8b 43 18 c6 43 24 05 89 f1 89 dd 83


>>EIP; c014177e <__free_pages_ok+be/2a0>   <=====

>>eax; cba53f48 <_end+b77b478/165f9530>
>>ebx; c144955c <_end+1170a8c/165f9530>
>>ecx; c025f6dc <contig_page_data+dc/3c0>
>>edi; 138de070 Before first symbol
>>ebp; 00001000 Before first symbol
>>esp; c41b7ec8 <_end+3edf3f8/165f9530>

Trace; c0142fca <remove_exclusive_swap_page+ba/120>
Trace; c01351c6 <zap_pte_range+106/260>
Trace; c013320b <zap_page_range+9b/120>
Trace; c01367a1 <do_munmap+221/300>
Trace; c01368ca <sys_munmap+4a/70>
Trace; c010ba0f <system_call+33/38>

Code;  c014177e <__free_pages_ok+be/2a0>
00000000 <_EIP>:
Code;  c014177e <__free_pages_ok+be/2a0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0141780 <__free_pages_ok+c0/2a0>
   2:   83 00 53                  addl   $0x53,(%eax)
Code;  c0141783 <__free_pages_ok+c3/2a0>
   5:   b0 23                     mov    $0x23,%al
Code;  c0141785 <__free_pages_ok+c5/2a0>
   7:   c0 8b 43 18 c6 43 24      rorb   $0x24,0x43c61843(%ebx)
Code;  c014178c <__free_pages_ok+cc/2a0>
   e:   05 89 f1 89 dd            add    $0xdd89f189,%eax
Code;  c0141791 <__free_pages_ok+d1/2a0>
  13:   83 00 00                  addl   $0x0,(%eax)

-- 
Life would be so much easier if we could just look at the source code.

