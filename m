Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129053AbQJ3RwI>; Mon, 30 Oct 2000 12:52:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129055AbQJ3Rvs>; Mon, 30 Oct 2000 12:51:48 -0500
Received: from getafix.lostland.net ([216.29.29.27]:5463 "EHLO
	getafix.lostland.net") by vger.kernel.org with ESMTP
	id <S129053AbQJ3Rvl>; Mon, 30 Oct 2000 12:51:41 -0500
Date: Mon, 30 Oct 2000 12:50:18 -0500 (EST)
From: adrian <jimbud@lostland.net>
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: 2.2.18pre15 oops in find_buffer()
In-Reply-To: <200010301715.SAA16699@harpo.it.uu.se>
Message-ID: <Pine.BSO.4.21.0010301246470.8860-100000@getafix.lostland.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I also just got this Oops, but with 2.2.18pre18.

Note: vmware was not loaded :)


Unable to handle kernel paging request at virtual address 009e0000
current->tss.cr3 = 108e5000, %cr3 = 108e5000
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0125f1c>]
EFLAGS: 00010206
eax: 009e0000   ebx: 00000007   ecx: 000189d0   edx: 009e0000
esi: 0000000d   edi: 00000307   ebp: 002a00a9   esp: c7a97e60
ds: 0018   es: 0018   ss: 0018
Process enlightenment (pid: 5551, process nr: 75, stackpage=c7a97000)
Stack: 00000004 c3885860 000189d0 c0125f5b 00000307 002a00a9 00000400 c0126c50 
       00000307 002a00a9 00000400 00000000 c7a97f18 00000004 c6330288 c7a97ea4 
       c7a97ed8 d0ebd000 00000307 00000000 c3885860 00000010 c01431df c6330288 
Call Trace: [<c0125f5b>] [<c0126c50>] [<c01431df>] [<c0126f45>] [<c011cb20>] [<c011cc8f>] [<c011cbdc>] 
       [<c0124a66>] [<c0109044>] 
Code: 8b 00 39 6a 04 75 15 8b 4c 24 20 39 4a 08 75 0c 66 39 7a 0c 

>>EIP; c0125f1c <find_buffer+68/90>   <=====
Trace; c0125f5b <get_hash_table+17/24>
Trace; c0126c50 <brw_page+14c/36c>
Trace; c01431df <ext2_bmap+1b/84>
Trace; c0126f45 <generic_readpage+81/90>
Trace; c011cb20 <do_generic_file_read+52c/5e8>
Trace; c011cc8f <generic_file_read+63/7c>
Trace; c011cbdc <file_read_actor+0/50>
Trace; c0124a66 <sys_read+ae/c4>
Trace; c0109044 <system_call+34/38>
Code;  c0125f1c <find_buffer+68/90>
00000000 <_EIP>:
Code;  c0125f1c <find_buffer+68/90>   <=====
   0:   8b 00                     mov    (%eax),%eax   <=====
Code;  c0125f1e <find_buffer+6a/90>
   2:   39 6a 04                  cmp    %ebp,0x4(%edx)
Code;  c0125f21 <find_buffer+6d/90>
   5:   75 15                     jne    1c <_EIP+0x1c> c0125f38 <find_buffer+84/90>
Code;  c0125f23 <find_buffer+6f/90>
   7:   8b 4c 24 20               mov    0x20(%esp,1),%ecx
Code;  c0125f27 <find_buffer+73/90>
   b:   39 4a 08                  cmp    %ecx,0x8(%edx)
Code;  c0125f2a <find_buffer+76/90>
   e:   75 0c                     jne    1c <_EIP+0x1c> c0125f38 <find_buffer+84/90>
Code;  c0125f2c <find_buffer+78/90>
  10:   66 39 7a 0c               cmp    %di,0xc(%edx)

On Mon, 30 Oct 2000, Mikael Pettersson wrote:

> Is there any known bug in 2.2.18pre15 that could cause the
> following oops in fs/buffer.c:find_buffer() ?
> 


Regards,
Adrian


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
