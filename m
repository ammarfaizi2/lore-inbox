Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131630AbRDFPpv>; Fri, 6 Apr 2001 11:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131733AbRDFPpl>; Fri, 6 Apr 2001 11:45:41 -0400
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:48139 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id <S131630AbRDFPpa>; Fri, 6 Apr 2001 11:45:30 -0400
From: Norbert Preining <preining@logic.at>
Date: Fri, 6 Apr 2001 17:44:42 +0200
To: linux-kernel@vger.kernel.org
Subject: gcc oopses with 2.4.3
Message-ID: <20010406174442.A19874@alpha.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I get frequent `internal compiler error', killed with Sig 4  or Sig 11
and sometimes Ooops from compiling X or kernel. 

System: 2.4.3-vanilla, reiserfs, glibc-2.1.3
[~] gcc -v
Reading specs from /usr/lib/gcc-lib/i486-suse-linux/2.95.2/specs
gcc version 2.95.2 19991024 (release)


Here a decoded Ooops:

ksymoops 0.7c on i586 2.4.3.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.3/ (default)
     -m /boot/System.map-2.4.3 (specified)

Unable to handle kernel NULL pointer dereference at virtual address 00000000
c0145e41
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[ext2_new_block+317/1808]
EFLAGS: 00010282
eax: 00000000   ebx: c7261de8   ecx: 00000000   edx: 00000000
esi: c6dab000   edi: 00000000   ebp: c7261dec   esp: c7261d9c
ds: 0018   es: 0018   ss: 0018
Process cc1 (pid: 20767, stackpage=c7261000)
Stack: c2f280e0 00000001 c7261e3c 00000001 c01675d0 00000000 00000000 c6dab038 
       c6dab034 c7261e7c c7261e94 c020e91c 00000001 00000009 00000008 c7cc7c00 
       c1265800 00000000 c473c9e0 c1264120 c7261e40 c014755c c2f280e0 00000001 
Call Trace: [search_by_key+2028/3140] [ext2_alloc_block+120/128] [ext2_alloc_branch+41/456] [ext2_get_block+695/1152] [create_empty_buffers+23/108] [__block_prepare_write+234/560] [block_prepare_write+29/52] 
Code: 74 04 31 d2 eb 52 83 be c8 00 00 00 08 77 20 8d 04 bd 00 00 
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   74 04                     je     6 <_EIP+0x6> 00000006 Before first symbol
Code;  00000002 Before first symbol
   2:   31 d2                     xor    %edx,%edx
Code;  00000004 Before first symbol
   4:   eb 52                     jmp    58 <_EIP+0x58> 00000058 Before first symbol
Code;  00000006 Before first symbol
   6:   83 be c8 00 00 00 08      cmpl   $0x8,0xc8(%esi)
Code;  0000000d Before first symbol
   d:   77 20                     ja     2f <_EIP+0x2f> 0000002f Before first symbol
Code;  0000000f Before first symbol
   f:   8d 04 bd 00 00 00 00      lea    0x0(,%edi,4),%eax


I hope it helps a bit, but it doesn't look like ;-)

Please Cc: me any answers, thanks!

Best wishes

Norbert


-- 
ciao
norb

+-------------------------------------------------------------------+
| Norbert Preining              http://www.logic.at/people/preining |
| University of Technology Vienna, Austria        preining@logic.at |
| DSA: 0x09C5B094 (RSA: 0xCF1FA165) mail subject: get [DSA|RSA]-key |
+-------------------------------------------------------------------+
