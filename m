Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131499AbQL1Sjr>; Thu, 28 Dec 2000 13:39:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131523AbQL1Sj1>; Thu, 28 Dec 2000 13:39:27 -0500
Received: from server0011.freedom2surf.net ([194.106.56.14]:13436 "EHLO
	server0011.freedom2surf.net") by vger.kernel.org with ESMTP
	id <S131499AbQL1SjY>; Thu, 28 Dec 2000 13:39:24 -0500
From: chris@freedom2surf.net
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Repeatable Oops in 2.4t13p4ac2
Message-ID: <978026911.3a4b819f71050@www.freedom2surf.net>
Date: Thu, 28 Dec 2000 18:08:31 +0000 (GMT)
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, chris@freedom2surf.net,
        linux-kernel@vger.kernel.org
In-Reply-To: <E14BghF-0003wu-00@the-village.bc.nu>
In-Reply-To: <E14BghF-0003wu-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.1
X-Originating-IP: 194.106.48.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > 
> > > > Do you remember if the reports you've got always oopsed the same
> > > > address (0040000) ? 
> > > 

Hi - Here's another Oops from the same machine. It looks to be in a totally 
different place in the code which probably means it's a memory problem? I'll 
try installing on another box to confirm.

Thank you for your help!

Chris

Unable to handle kernel NULL pointer dereference at virtual address 00000120
c0145914
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0145914>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010207
eax: 00000000   ebx: 00000100   ecx: 0000001e   edx: 00000c0c
esi: 00000100   edi: 00000000   ebp: 0025dbb1   esp: c333fe5c
ds: 0018   es: 0018   ss: 0018
Process nfsd (pid: 194, stackpage=c333f000)
Stack: 00041182 dff86060 0025dbb1 c18ee000 c0145d3e c18ee000 0025dbb1 dff86060
       00000000 00000000 00041182 c337a200 c3345ec0 c93da800 c0167b01 c18ee000
       0025dbb1 00000000 00000000 00000003 c337a200 c0167f41 c18ee000 0025dbb1
Call Trace: [<c0145d3e>] [<c0167b01>] [<c0167f41>] [<c01eaef6>] [<c01684b0>] 
[<c0168a3a>] [<c0166d39
       [<c01666c3>] [<c01f8715>] [<c01664ed>] [<c0107480>]
Code: 39 6e 20 75 ef 8b 44 24 14 39 86 90 00 00 00 75 e3 85 ff 74

>>EIP; c0145914 <find_inode+1c/48>   <=====
Trace; c0145d3e <iget4+52/e8>
Trace; c0167b01 <nfsd_iget+19/f0>
Trace; c0167f41 <find_fh_dentry+21/324>
Trace; c01eaef6 <inet_sendmsg+3e/44>
Trace; c01684b0 <fh_verify+26c/48c>
Trace; c0168a3a <nfsd_lookup+6a/4f8>
Trace; c01666c3 <nfsd_dispatch+cb/168>
Trace; c01f8715 <svc_process+28d/4c8>
Trace; c01664ed <nfsd+215/320>
Trace; c0107480 <kernel_thread+28/38>
Code;  c0145914 <find_inode+1c/48>
00000000 <_EIP>:
Code;  c0145914 <find_inode+1c/48>   <=====
   0:   39 6e 20                  cmp    %ebp,0x20(%esi)   <=====
Code;  c0145917 <find_inode+1f/48>
   3:   75 ef                     jne    fffffff4 <_EIP+0xfffffff4> c0145908 
<find_inode+10/48>
Code;  c0145919 <find_inode+21/48>
   5:   8b 44 24 14               mov    0x14(%esp,1),%eax
Code;  c014591d <find_inode+25/48>
   9:   39 86 90 00 00 00         cmp    %eax,0x90(%esi)
Code;  c0145923 <find_inode+2b/48>
   f:   75 e3                     jne    fffffff4 <_EIP+0xfffffff4> c0145908 
<find_inode+10/48>
Code;  c0145925 <find_inode+2d/48>
  11:   85 ff                     test   %edi,%edi
Code;  c0145927 <find_inode+2f/48>
  13:   74 00                     je     15 <_EIP+0x15> c0145929 
<find_inode+31/48>


-------------------------------------------------
Everyone should have http://www.freedom2surf.net/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
