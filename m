Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129867AbRAVODS>; Mon, 22 Jan 2001 09:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130431AbRAVODI>; Mon, 22 Jan 2001 09:03:08 -0500
Received: from cr545978-a.nmkt1.on.wave.home.com ([24.112.25.43]:39184 "HELO
	saturn.tlug.org") by vger.kernel.org with SMTP id <S129867AbRAVODB>;
	Mon, 22 Jan 2001 09:03:01 -0500
Date: Mon, 22 Jan 2001 09:03:04 -0500 (EST)
From: Mike Frisch <mfrisch@saturn.tlug.org>
To: <linux-kernel@vger.kernel.org>
Subject: Oops in 2.2.19pre7
Message-ID: <Pine.LNX.4.30.0101220901570.4674-100000@gateway.saturn.tlug.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Unable to handle kernel paging request at virtual address 813de1c0
current->tss.cr3 = 015fa000, %cr3 = 015fa000
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c09ef0e8>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010283
eax: c09ef0e0   ebx: c7fff740   ecx: 0000000f   edx: c09ef0e0
esi: 00000800   edi: 00000005   ebp: 00000400   esp: c4153cbc
ds: 0018   es: 0018   ss: 0018
Process dump (pid: 4001, process nr: 83, stackpage=c4153000)
Stack: 00000000 00000400 00000400 c5752000 00000801 c4153cdc c4153cdc
c4152000
       c4152000 00000000 c0125dc1 c5752000 00000400 00000000 00000000
00000400
                       00000004 00000801 c0124ff6 00000400 c01251aa
00000400 00000034 00000000
                            Call Trace: [<c0125dc1>] [<c0124ff6>]
[<c01251aa>] [<c0128265>] [<c0147bfd>] [<c010f0b7>] [<c0123559>]
                                   [<c0123712>] [<c01079cc>]
                                   Code: 00 04 00 00 ff ff 00 00 00 00 00
00 00 00 00 00 00 00 00 00

>>EIP; c09ef0e8 <_end+7d8f00/85fae18>   <=====
Trace; c0125dc1 <grow_buffers+55/fc>
Trace; c0124ff6 <refill_freelist+a/38>
Trace; c01251aa <getblk+11e/144>
Trace; c0128265 <block_read+2c1/4f4>
Trace; c0147bfd <alloc_skb+71/dc>
Trace; c010f0b7 <schedule+157/284>
Trace; c0123559 <sys_lseek+99/b4>
Trace; c0123712 <sys_read+ae/c4>
Trace; c01079cc <system_call+34/38>
Code;  c09ef0e8 <_end+7d8f00/85fae18>
00000000 <_EIP>:
Code;  c09ef0e8 <_end+7d8f00/85fae18>   <=====
   0:   00 04 00                  add    %al,(%eax,%eax,1)   <=====
Code;  c09ef0eb <_end+7d8f03/85fae18>
   3:   00 ff                     add    %bh,%bh
Code;  c09ef0ed <_end+7d8f05/85fae18>
   5:   ff 00                     incl   (%eax)


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
