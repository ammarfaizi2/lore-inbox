Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132226AbQLLQ7G>; Tue, 12 Dec 2000 11:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132248AbQLLQ64>; Tue, 12 Dec 2000 11:58:56 -0500
Received: from hermes.mixx.net ([212.84.196.2]:17417 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S132226AbQLLQ6y>;
	Tue, 12 Dec 2000 11:58:54 -0500
Date: Tue, 12 Dec 2000 17:28:07 +0100 (CET)
From: Thilo Mezger <thilo@innominate.com>
Reply-To: <thilo.mezger@innominate.com>
To: <linux-kernel@vger.kernel.org>
Subject: OOPS on i586 2.4.0-test9
Message-ID: <Pine.LNX.4.30.0012121727001.13072-100000@lurchi.bln.innominate.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

i've just discovered this oops in my logs.  it's a plain red hat
linux 7 system with all updates applied (incl. glibc 2.2).  the
kernel running is a stock 2.4.0-test9.

i have no idea what could have caused this oops but i'm running an
onstream di-30 tape streamer with the ide-tape.c driver.  could that
be it...?!

Thilo


PS: this is my first posting so please bear with me... ;-)

-------------------------------------------------------------------
ksymoops 2.3.4 on i586 2.4.0-test9.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0-test9/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel paging request at virtual address c8854040
c012c22b
*pde = 012fa063
Oops: 0000
CPU:    0
EIP:    0010:[get_chrfops+51/232]
EFLAGS: 00010282
eax: c8854040   ebx: ffffffed   ecx: c7a6a320   edx: 00000080
esi: 00000128   edi: c0269e04   ebp: 00000025   esp: c54c1f14
ds: 0018   es: 0018   ss: 0018
Process mt (pid: 29519, stackpage=c54c1000)
Stack: ffffffed c7a6a320 c2a131e0 c1292720 00000128 ffffffeb c2a131e0 00000001
       c57c8000 c54c0000 c012c3f4 00000025 00000080 c7a6a320 c2a131e0 ffffffe9
       c012b5be c2a131e0 c7a6a320 00000000 00000003 0804b888 c57c8000 c012b4ef
Call Trace: [chrdev_open+40/76] [dentry_open+198/340] [filp_open+71/80] [sys_open+56/180] [system_call+51/64]
Code: 8b 00 85 c0 74 0d 50 e8 59 9b fe ff 83 c4 04 85 c0 74 46 8b
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 00                     mov    (%eax),%eax
Code;  00000002 Before first symbol
   2:   85 c0                     test   %eax,%eax
Code;  00000004 Before first symbol
   4:   74 0d                     je     13 <_EIP+0x13> 00000013 Before first symbol
Code;  00000006 Before first symbol
   6:   50                        push   %eax
Code;  00000007 Before first symbol
   7:   e8 59 9b fe ff            call   fffe9b65 <_EIP+0xfffe9b65> fffe9b65 <END_OF_CODE+377a13a6/???
Code;  0000000c Before first symbol
   c:   83 c4 04                  add    $0x4,%esp
Code;  0000000f Before first symbol
   f:   85 c0                     test   %eax,%eax
Code;  00000011 Before first symbol
  11:   74 46                     je     59 <_EIP+0x59> 00000059 Before first symbol
Code;  00000013 Before first symbol
  13:   8b 00                     mov    (%eax),%eax


1 warning issued.  Results may not be reliable.




-- 
thilo.mezger@innominate.com
e-business manager                                      innominate AG
                                                 the linux architects
tel: +49-30-308806-0    fax: -77                   www.innominate.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
