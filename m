Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293041AbSCWMPF>; Sat, 23 Mar 2002 07:15:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292968AbSCWMO4>; Sat, 23 Mar 2002 07:14:56 -0500
Received: from zeus.kernel.org ([204.152.189.113]:48074 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S292957AbSCWMOs>;
	Sat, 23 Mar 2002 07:14:48 -0500
Message-ID: <01af01c1d264$4f2609a0$e1de11cc@csihq.com>
Reply-To: "Mike Black" <mblack@csihq.com>
From: "Mike Black" <mblack@csihq.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>,
        "raid" <linux-raid@vger.kernel.org>
Cc: "John Graves" <jgraves@csihq.com>
In-Reply-To: <E16oRiv-0008Nc-00@the-village.bc.nu> <04f201c1d1bf$e2b25020$e1de11cc@csihq.com> <053501c1d1c2$ea59aa50$e1de11cc@csihq.com> <059401c1d1c9$23f2f040$e1de11cc@csihq.com> <062c01c1d1d5$d3812520$e1de11cc@csihq.com>
Subject: Re: 2.4.19-pre4 aic7xxx problems
Date: Sat, 23 Mar 2002 07:14:40 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Tried 2.4.16 -- similar (but not quite the same ) oops.  I'm now testing
2.4.19-pre4 again without the I2C modules loaded.  I'm about ready to
install NT (aarrghhh!!!).  If this fails I'm going to test 2.4.19-pre3-ac6.

ksymoops 2.4.5 on i686 2.4.16.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.16/ (default)
     -m System.map (specified)

Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base says
c01b7700, System.map says c0150ca0.  Ignoring ksyms_bas
e entry
Mar 22 16:39:47 yeti kernel: Unable to handle kernel paging request at
virtual address 06aebde0
Mar 22 16:39:47 yeti kernel: f88211a5
Mar 22 16:39:47 yeti kernel: *pde = 00000000
Mar 22 16:39:47 yeti kernel: Oops: 0000
Mar 22 16:39:47 yeti kernel: CPU:    0
Mar 22 16:39:47 yeti kernel: EIP:    0010:[<f88211a5>]    Tainted: P
Using defaults from ksymoops -t elf32-i386 -a i386
Mar 22 16:39:47 yeti kernel: EFLAGS: 00010a82
Mar 22 16:39:47 yeti kernel: eax: f7aebde0   ebx: e2c13000   ecx: 00000010
edx: 8005003b
Mar 22 16:39:47 yeti kernel: esi: e2c28000   edi: e2c12000   ebp: e2c3d000
esp: f7aebdcc
Mar 22 16:39:47 yeti kernel: ds: 0018   es: 0018   ss: 0018
Mar 22 16:39:47 yeti kernel: Process raid5d (pid: 5333, stackpage=f7aeb000)
Mar 22 16:39:47 yeti kernel: Stack: e2c12000 e2c12000 e2c3d000 e2c13000
00001000 00000000 00000000 00000000
Mar 22 16:39:47 yeti kernel:        00000000 00000000 00000000 00000000
00000000 00000000 00000000 00000000
Mar 22 16:39:47 yeti kernel:        00000000 00000000 00000000 00000000
00000000 f8821d0c 00001000 e2c3d000
Mar 22 16:39:47 yeti kernel: Call Trace: [<f8821d0c>] [<f882510c>]
[<f88262e1>] [<c01b0250>] [<c011a070>]
Mar 22 16:39:47 yeti kernel:    [<f88269c6>] [<c01bb5ac>] [<c0105594>]
Mar 22 16:39:47 yeti kernel: Code: 8b 90 00 00 00 0f 57 93 a0 00 00 00 0f 57
9b b0 00 00 00 0f


>>EIP; f88211a5 <[xor]xor_sse_4+205/334>   <=====

>>eax; f7aebde0 <_end+377c7b0c/384f8d2c>
>>ebx; e2c13000 <_end+228eed2c/384f8d2c>
>>edx; 8005003b Before first symbol
>>esi; e2c28000 <_end+22903d2c/384f8d2c>
>>edi; e2c12000 <_end+228edd2c/384f8d2c>
>>ebp; e2c3d000 <_end+22918d2c/384f8d2c>
>>esp; f7aebdcc <_end+377c7af8/384f8d2c>

Trace; f8821d0c <[xor]xor_block+70/94>
Trace; f882510c <[raid5]compute_block+c8/e4>
Trace; f88262e1 <[raid5]handle_stripe+ce5/f88>
Trace; c01b0250 <rw_intr+14c/154>
Trace; c011a070 <bh_action+4c/88>
Trace; f88269c6 <[raid5]raid5d+12a/158>
Trace; c01bb5ac <md_thread+14c/1b0>
Trace; c0105594 <kernel_thread+28/38>

Code;  f88211a5 <[xor]xor_sse_4+205/334>
00000000 <_EIP>:
Code;  f88211a5 <[xor]xor_sse_4+205/334>   <=====
   0:   8b 90 00 00 00 0f         mov    0xf000000(%eax),%edx   <=====
Code;  f88211ab <[xor]xor_sse_4+20b/334>
   6:   57                        push   %edi
Code;  f88211ac <[xor]xor_sse_4+20c/334>
   7:   93                        xchg   %eax,%ebx
Code;  f88211ad <[xor]xor_sse_4+20d/334>
   8:   a0 00 00 00 0f            mov    0xf000000,%al
Code;  f88211b2 <[xor]xor_sse_4+212/334>
   d:   57                        push   %edi
Code;  f88211b3 <[xor]xor_sse_4+213/334>
   e:   9b                        fwait
Code;  f88211b4 <[xor]xor_sse_4+214/334>
   f:   b0 00                     mov    $0x0,%al
Code;  f88211b6 <[xor]xor_sse_4+216/334>
  11:   00 00                     add    %al,(%eax)
Code;  f88211b8 <[xor]xor_sse_4+218/334>
  13:   0f 00 00                  sldt   (%eax)

________________________________________
Michael D. Black   Principal Engineer
mblack@csihq.com  321-676-2923,x203
http://www.csihq.com  Computer Science Innovations
http://www.csihq.com/~mike  My home page
FAX 321-676-2355
----- Original Message -----
From: "Mike Black" <mblack@csihq.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>; "raid"
<linux-raid@vger.kernel.org>
Cc: "John Graves" <jgraves@csihq.com>
Sent: Friday, March 22, 2002 2:14 PM
Subject: Re: 2.4.19-pre4 aic7xxx problems



Pick an oops...any oops...
Waited for md0 to finish resync....qla2x00 wasn't loaded....no NFS.  No
other resyncs going on.  Next I'm going to back to an ealier kernel and see
what happens.  Now got this oops:


