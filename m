Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129260AbQLNQn5>; Thu, 14 Dec 2000 11:43:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129267AbQLNQnr>; Thu, 14 Dec 2000 11:43:47 -0500
Received: from [213.8.185.192] ([213.8.185.192]:54532 "EHLO callisto.yi.org")
	by vger.kernel.org with ESMTP id <S129260AbQLNQn1>;
	Thu, 14 Dec 2000 11:43:27 -0500
Date: Thu, 14 Dec 2000 18:04:49 +0200 (IST)
From: Dan Aloni <karrde@callisto.yi.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [OOPS] test12 - bdflush
Message-ID: <Pine.LNX.4.21.0012141741270.14240-100000@callisto.yi.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


While running the test12 kernel with the test11 arch/i386, I've trapped an
Oops message in my log. I'm not sure if it has something to do with using
the arch/i386 code from test11, but it seems necessary to post it since
test12 introduces changes to kswapd-bdflush.

I am currently running test11 since test12 gave problems later on
following this Oops.

ksymoops 2.3.5 on i686 2.4.0-test11.  Options used
     -v vmlinux (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -m System.map (specified)

Unable to handle kernel NULL pointer dereference at virtual address 0000000c
c012949e
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[page_launder+1038/1824]
EFLAGS: 00010202
eax: 00000000   ebx: c12095c0   ecx: 00001b1e   edx: c012ae37
esi: c12095dc   edi: 00000000   ebp: 00000d5d   esp: c12e3fb4
ds: 0018   es: 0018   ss: 0018
Process bdflush (pid: 6, stackpage=c12e3000)
Stack: 00203206 00000000 c12e2000 0008e000 00000001 00000000 00000000 00000018
       00000000 c0131dcf 00000003 00000000 00010f00 c1229f88 c1229fc4 c0108904
       c1229fc4 00000078 c1229fc4
Call Trace: [add_vfsmnt+295/544] [kernel_thread+40/56]
Code: 8b 40 0c 8b 10 85 d2 0f 84 ba 04 00 00 83 7c 24 14 00 75 73

Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 40 0c                  mov    0xc(%eax),%eax
Code;  00000003 Before first symbol
   3:   8b 10                     mov    (%eax),%edx
Code;  00000005 Before first symbol
   5:   85 d2                     test   %edx,%edx
Code;  00000007 Before first symbol
   7:   0f 84 ba 04 00 00         je     4c7 <_EIP+0x4c7> 000004c7 Before first symbol
Code;  0000000d Before first symbol
   d:   83 7c 24 14 00            cmpl   $0x0,0x14(%esp,1)
Code;  00000012 Before first symbol
  12:   75 73                     jne    87 <_EIP+0x87> 00000087 Before first symbol

Linux callisto.yi.org 2.4.0-test11 #1 Tue Dec 12 20:08:57 IST 2000 i686
unknown
Kernel modules         2.3.13
Gnu C                  2.95.2
Gnu Make               3.79.1
Binutils               2.10
Linux C Library        2.1.3
Dynamic linker         ldd (GNU libc) 2.1.3
Procps                 2.0.4
Mount                  2.9u
Net-tools              permitted
Console-tools          1999.03.02
Sh-utils               2.0

-- 
Dan Aloni 
dax@karrde.org

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
