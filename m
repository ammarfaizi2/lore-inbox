Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132570AbRAPT24>; Tue, 16 Jan 2001 14:28:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132442AbRAPT2r>; Tue, 16 Jan 2001 14:28:47 -0500
Received: from cx879306-a.pv1.ca.home.com ([24.5.157.48]:31214 "EHLO
	siamese.dhis.twinsun.com") by vger.kernel.org with ESMTP
	id <S132570AbRAPT2e>; Tue, 16 Jan 2001 14:28:34 -0500
From: junio@siamese.dhis.twinsun.com
To: linux-kernel@vger.kernel.org
Subject: 2.4.1-pre7 raid5syncd oops
Date: 16 Jan 2001 11:28:28 -0800
Message-ID: <7vzogr47qb.fsf@siamese.dhis.twinsun.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Unable to handle kernel NULL pointer dereference at virtual address 00000003
c01ccf91
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c01ccf91>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010086
eax: ffffffff   ebx: c1490400   ecx: cfdeb000   edx: cfeed13c
esi: cfdeb000   edi: 00001e29   ebp: 00000013   esp: cfba7e80
ds: 0018   es: 0018   ss: 0018
Process raid5syncd (pid: 9, stackpage=cfba7000)
Stack: c01ccfe0 cfdeb000 c1490400 00000000 c01cd430 c1490400 c1490400 0003c53c 
       00001e29 00000013 00000000 00000000 cfba6000 00001000 00000000 00000000 
       00000000 c1490400 c01cf2a8 c1490400 00078a78 00000000 00000000 cfba6000 
Call Trace: [<c01ccfe0>] [<c01cd430>] [<c01cf2a8>] [<c01d708b>] [<c01cf40f>] [<c01d63cd>] [<c01074b8>] 
Code: 89 50 04 8b 51 04 8b 01 89 02 c7 41 04 00 00 00 00 c3 8d b6 

>>EIP; c01ccf91 <remove_hash+11/30>   <=====
Trace; c01ccfe0 <get_free_stripe+30/50>
Trace; c01cd430 <get_active_stripe+260/520>
Trace; c01cf2a8 <raid5_sync_request+48/e0>
Trace; c01d708b <md_do_sync+1fb/470>
Trace; c01cf40f <raid5syncd+2f/70>
Trace; c01d63cd <md_thread+fd/170>
Trace; c01074b8 <kernel_thread+28/40>
Code;  c01ccf91 <remove_hash+11/30>
00000000 <_EIP>:
Code;  c01ccf91 <remove_hash+11/30>   <=====
   0:   89 50 04                  mov    %edx,0x4(%eax)   <=====
Code;  c01ccf94 <remove_hash+14/30>
   3:   8b 51 04                  mov    0x4(%ecx),%edx
Code;  c01ccf97 <remove_hash+17/30>
   6:   8b 01                     mov    (%ecx),%eax
Code;  c01ccf99 <remove_hash+19/30>
   8:   89 02                     mov    %eax,(%edx)
Code;  c01ccf9b <remove_hash+1b/30>
   a:   c7 41 04 00 00 00 00      movl   $0x0,0x4(%ecx)
Code;  c01ccfa2 <remove_hash+22/30>
  11:   c3                        ret    
Code;  c01ccfa3 <remove_hash+23/30>
  12:   8d b6 00 00 00 00         lea    0x0(%esi),%esi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
