Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129846AbRAVNMN>; Mon, 22 Jan 2001 08:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130154AbRAVNME>; Mon, 22 Jan 2001 08:12:04 -0500
Received: from web11607.mail.yahoo.com ([216.136.172.59]:32018 "HELO
	web11607.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S129846AbRAVNLq>; Mon, 22 Jan 2001 08:11:46 -0500
Message-ID: <20010122131145.46874.qmail@web11607.mail.yahoo.com>
Date: Mon, 22 Jan 2001 05:11:45 -0800 (PST)
From: Tom <freyason@yahoo.com>
Subject: Proper OOPS report
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My apologies for not running it through ksymoops.
No specific bit of code was referenced in the OOPS so I am assuming
it is in the kernel itself.

Tom

Jan 21 22:02:36 hrafn kernel: c0108f75
Jan 21 22:02:36 hrafn kernel: Oops: 0000
Jan 21 22:02:36 hrafn kernel: CPU:    0
Jan 21 22:02:36 hrafn kernel: EIP:   
0010:[coprocessor_segment_overrun+5/16]
Jan 21 22:02:36 hrafn kernel: EFLAGS: 00010297
Jan 21 22:02:36 hrafn kernel: eax: 58060001   ebx: c0193a0c   ecx:
0009b932   edx: 00000010
Jan 21 22:02:36 hrafn kernel: esi: 08dd9800   edi: 08dd9000   ebp:
40001c26   esp: c4a23fe8
Jan 21 22:02:36 hrafn kernel: ds: 002b   es: 002b   ss: 0018
Jan 21 22:02:36 hrafn kernel: Process netscape (pid: 4856,
stackpage=c4a23000)
Jan 21 22:02:36 hrafn kernel: Stack: c0108f68 4010ada2 00000023
00010202 bfffe3c8 0000002b
Jan 21 22:02:36 hrafn kernel: Call Trace: [invalid_op+8/16]
Jan 21 22:02:36 hrafn kernel: Code: 8b 10 ff 75 10 ff 75 0c 50 8b 42 68
9c 95 10 c0 e9 c6 fe ff
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 10                     mov    (%eax),%edx
Code;  00000002 Before first symbol
   2:   ff 75 10                  pushl  0x10(%ebp)
Code;  00000005 Before first symbol
   5:   ff 75 0c                  pushl  0xc(%ebp)
Code;  00000008 Before first symbol
   8:   50                        push   %eax
Code;  00000009 Before first symbol
   9:   8b 42 68                  mov    0x68(%edx),%eax
Code;  0000000c Before first symbol
   c:   9c                        pushf
Code;  0000000d Before first symbol
   d:   95                        xchg   %eax,%ebp
Code;  0000000e Before first symbol
   e:   10 c0                     adc    %al,%al
Code;  00000010 Before first symbol
  10:   e9 c6 fe ff 00            jmp    fffedb <_EIP+0xfffedb>
00fffedb Before first symbol
Jan 21 22:02:36 hrafn kernel: c0108f75
Jan 21 22:02:36 hrafn kernel: Oops: 0000
Jan 21 22:02:36 hrafn kernel: CPU:    0
Jan 21 22:02:36 hrafn kernel: EIP:   
0010:[coprocessor_segment_overrun+5/16]
Jan 21 22:02:36 hrafn kernel: EFLAGS: 00210297
Jan 21 22:02:36 hrafn kernel: eax: 00000000   ebx: c0193a0c   ecx:
081f27f8   edx: 0000004c
Jan 21 22:02:36 hrafn kernel: esi: 08143440   edi: 08142f00   ebp:
400007ca   esp: c545ffe8
Jan 21 22:02:36 hrafn kernel: ds: 002b   es: 002b   ss: 0018
Jan 21 22:02:36 hrafn kernel: Process xmms (pid: 5694,
stackpage=c545f000)
Jan 21 22:02:36 hrafn kernel: Stack: c0108f68 4021eda2 00000023
00210206 bffff824 0000002b
Jan 21 22:02:36 hrafn kernel: Call Trace: [invalid_op+8/16]
Jan 21 22:02:36 hrafn kernel: Code: 8b 10 ff 75 10 ff 75 0c 50 8b 42 68
9c 95 10 c0 e9 c6 fe ff

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 10                     mov    (%eax),%edx
Code;  00000002 Before first symbol
   2:   ff 75 10                  pushl  0x10(%ebp)
Code;  00000005 Before first symbol
   5:   ff 75 0c                  pushl  0xc(%ebp)
Code;  00000008 Before first symbol
   8:   50                        push   %eax
Code;  00000009 Before first symbol
   9:   8b 42 68                  mov    0x68(%edx),%eax
Code;  0000000c Before first symbol
   c:   9c                        pushf
Code;  0000000d Before first symbol
   d:   95                        xchg   %eax,%ebp
Code;  0000000e Before first symbol
   e:   10 c0                     adc    %al,%al
Code;  00000010 Before first symbol
  10:   e9 c6 fe ff 00            jmp    fffedb <_EIP+0xfffedb>
00fffedb Before first symbol





__________________________________________________
Do You Yahoo!?
Yahoo! Auctions - Buy the things you want at great prices. 
http://auctions.yahoo.com/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
