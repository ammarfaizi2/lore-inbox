Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136421AbRAHXaX>; Mon, 8 Jan 2001 18:30:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129387AbRAHXaE>; Mon, 8 Jan 2001 18:30:04 -0500
Received: from cr545978-a.nmkt1.on.wave.home.com ([24.112.25.43]:26884 "HELO
	saturn.tlug.org") by vger.kernel.org with SMTP id <S129226AbRAHX3z>;
	Mon, 8 Jan 2001 18:29:55 -0500
Date: Mon, 8 Jan 2001 18:29:53 -0500 (EST)
From: Mike Frisch <mfrisch@saturn.tlug.org>
To: <linux-kernel@vger.kernel.org>
Subject: Oops in stock 2.2.18
Message-ID: <Pine.LNX.4.30.0101081828570.1466-100000@gateway.saturn.tlug.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Can anybody shed some light on this?

Thanks,

--- cut here ---

Unable to handle kernel paging request at virtual address e6d94ba1
current->tss.cr3 = 07211000, %cr3 = 07211000
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c016faa5>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: c72e1b0a   ebx: c72e1b80   ecx: c15d0000   edx: 00000000
esi: c731e000   edi: 00000024   ebp: 00000000   esp: c731ff2c
ds: 0018   es: 0018   ss: 0018
Process master (pid: 465, process nr: 32, stackpage=c731f000)
Stack: c70c6d80 c72060a0 c15d0000 00000001 c012d31f c70c6d80 c15d0000 00000000
       00000002 c163af30 00000000 00000010 00000145 c731e000 00001770 c15d0000
       c15d0000 c012d785 0000003b c731ffa8 c731ffa4 c731e000 bffffb54 bffffb4c
Call Trace: [<c012d31f>] [<c012d785>] [<c0107b68>]
Code: 8b 43 6c 2b 43 50 3d ff 07 00 00 7e 06 81 ca 04 03 00 00 89

>>EIP; c016faa5 <unix_poll+61/78>   <=====
Trace; c012d31f <do_select+10f/204>
Trace; c012d785 <sys_select+371/498>
Trace; c0107b68 <system_call+34/38>
Code;  c016faa5 <unix_poll+61/78>
00000000 <_EIP>:
Code;  c016faa5 <unix_poll+61/78>   <=====
   0:   8b 43 6c          movl   0x6c(%ebx),%eax   <=====
Code;  c016faa8 <unix_poll+64/78>
   3:   2b 43 50          subl   0x50(%ebx),%eax
Code;  c016faab <unix_poll+67/78>
   6:   3d ff 07 00 00    cmpl   $0x7ff,%eax
Code;  c016fab0 <unix_poll+6c/78>
   b:   7e 06             jle    13 <_EIP+0x13> c016fab8 <unix_poll+74/78>
Code;  c016fab2 <unix_poll+6e/78>
   d:   81 ca 04 03 00    orl    $0x304,%edx
Code;  c016fab7 <unix_poll+73/78>
  12:   00
Code;  c016fab8 <unix_poll+74/78>
  13:   89 00             movl   %eax,(%eax)


6 warnings issued.  Results may not be reliable.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
