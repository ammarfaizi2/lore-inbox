Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317887AbSGVWrc>; Mon, 22 Jul 2002 18:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317888AbSGVWrc>; Mon, 22 Jul 2002 18:47:32 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:41096 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317887AbSGVWr1>;
	Mon, 22 Jul 2002 18:47:27 -0400
Subject: Re: [OOPS] 2.5.27 - __free_pages_ok()
From: Paul Larson <plars@austin.ibm.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       haveblue@us.ibm.com
In-Reply-To: <Pine.LNX.4.44L.0207221704120.3086-100000@imladris.surriel.com>
References: <Pine.LNX.4.44L.0207221704120.3086-100000@imladris.surriel.com>
Content-Type: multipart/mixed; boundary="=-vyR+XEgE404CcDXECdrx"
X-Mailer: Ximian Evolution 1.0.5 
Date: 22 Jul 2002 17:37:48 -0500
Message-Id: <1027377468.5170.40.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-vyR+XEgE404CcDXECdrx
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

New and improved version with the attachment this time.



--=-vyR+XEgE404CcDXECdrx
Content-Disposition: attachment; filename=rmap2.out
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=rmap2.out; charset=ISO-8859-1

ksymoops 2.4.5 on i686 2.4.18-mts.  Options used
     -V (default)
     -K (specified)
     -L (specified)
     -O (specified)
     -m System.map (specified)

15488MB HIGHMEM available.
WARNING: MP table in the EBDA can be UNSAFE, contact linux-smp@vger.kernel.=
org if you experience SMP problems!
cpu: 0, clocks: 99988, slice: 3029
cpu: 5, clocks: 99988, slice: 3029
cpu: 7, clocks: 99988, slice: 3029
cpu: 6, clocks: 99988, slice: 3029
cpu: 3, clocks: 99988, slice: 3029
cpu: 4, clocks: 99988, slice: 3029
cpu: 1, clocks: 99988, slice: 3029
cpu: 2, clocks: 99988, slice: 3029
ds: no socket drivers loaded!
kernel BUG at rmap.c:106!
invalid operand: 0000
CPU:    2
EIP:    0010:[<c013a444>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: c1aff9ec   ebx: c393dd0c   ecx: eff34067   edx: 000eff34
esi: fffdcff8   edi: cc0dc000   ebp: c393dd0c   esp: cc0ddc0c
ds: 0018   es: 0018   ss: 0018
Stack: fffdcff8 00000000 c0143e6f cc0ddf44 0000001f cc0dc000 bffff000 eff34=
025=20
       00000000 c0143fc2 cc0e2ce0 c393dd0c bffff000 0000457f cc0e2ce0 c02eb=
c52=20
       c02ebc4e c393dd0c c0365f64 f7954ee0 c015ae30 cc0dde48 c036b6f8 c015a=
7fc=20
Call Trace: [<c0143e6f>] [<c0143fc2>] [<c015ae30>] [<c015a7fc>] [<c02363d5>=
]=20
   [<c023c3ec>] [<c0144a8e>] [<c0144d5e>] [<c0144d75>] [<c0105b27>] [<c0106=
e6b>]=20
   [<c0110018>] [<c010516a>] [<c01056ab>]=20
Code: 0f 0b 6a 00 2c 91 2e c0 3b 15 c0 ef 40 c0 0f 83 ef 00 00 00=20


>>EIP; c013a444 <page_add_rmap+48/150>   <=3D=3D=3D=3D=3D

>>eax; c1aff9ec <END_OF_CODE+16b7070/????>
>>ebx; c393dd0c <END_OF_CODE+34f5390/????>
>>ecx; eff34067 <END_OF_CODE+2faeb6eb/????>
>>edx; 000eff34 Before first symbol
>>esi; fffdcff8 <END_OF_CODE+3fb9467c/????>
>>edi; cc0dc000 <END_OF_CODE+bc93684/????>
>>ebp; c393dd0c <END_OF_CODE+34f5390/????>
>>esp; cc0ddc0c <END_OF_CODE+bc95290/????>

Trace; c0143e6f <put_dirty_page+c7/100>
Trace; c0143fc2 <setup_arg_pages+11a/15c>
Trace; c015ae30 <load_elf_binary+634/f64>
Trace; c015a7fc <load_elf_binary+0/f64>
Trace; c02363d5 <scsi_dispatch_cmd+f5/188>
Trace; c023c3ec <scsi_request_fn+390/3b4>
Trace; c0144a8e <search_binary_handler+a2/1c8>
Trace; c0144d5e <do_execve+1aa/258>
Trace; c0144d75 <do_execve+1c1/258>
Trace; c0105b27 <sys_execve+2f/60>
Trace; c0106e6b <syscall_call+7/b>
Trace; c0110018 <mtrr_ioctl+634/6e8>
Trace; c010516a <init+122/1c8>
Trace; c01056ab <kernel_thread+23/30>

Code;  c013a444 <page_add_rmap+48/150>
00000000 <_EIP>:
Code;  c013a444 <page_add_rmap+48/150>   <=3D=3D=3D=3D=3D
   0:   0f 0b                     ud2a      <=3D=3D=3D=3D=3D
Code;  c013a446 <page_add_rmap+4a/150>
   2:   6a 00                     push   $0x0
Code;  c013a448 <page_add_rmap+4c/150>
   4:   2c 91                     sub    $0x91,%al
Code;  c013a44a <page_add_rmap+4e/150>
   6:   2e c0 3b 15               sarb   $0x15,%cs:(%ebx)
Code;  c013a44e <page_add_rmap+52/150>
   a:   c0 ef 40                  shr    $0x40,%bh
Code;  c013a451 <page_add_rmap+55/150>
   d:   c0 0f 83                  rorb   $0x83,(%edi)
Code;  c013a454 <page_add_rmap+58/150>
  10:   ef                        out    %eax,(%dx)

 <0>Kernel panic: Attempted to kill init!

--=-vyR+XEgE404CcDXECdrx--

