Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315113AbSDWIzG>; Tue, 23 Apr 2002 04:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315117AbSDWIzG>; Tue, 23 Apr 2002 04:55:06 -0400
Received: from moria.linuxis.net ([64.71.162.80]:59565 "HELO moria.linuxis.net")
	by vger.kernel.org with SMTP id <S315113AbSDWIzF>;
	Tue, 23 Apr 2002 04:55:05 -0400
Date: Tue, 23 Apr 2002 01:49:33 -0700
To: linux-kernel@vger.kernel.org
Subject: oops in 2.4.14-xfs (xfs release 1.0.2)
Message-ID: <20020423084933.GN11866@flounder.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Adam McKenna <adam-dated-1019983774.633d6e@flounder.net>
X-Delivery-Agent: TMDA/0.51 (Python 2.1.2 on Linux/i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Found a few references to a problem in do_check_pgt_cache but none for 2.4.14
-- has this issue been fixed in a later release?

Thanks,

--Adam

Unable to handle kernel NULL pointer dereference at virtual address 00000010
c011361f
*pde = 298bf001
Oops: 0000
CPU:    0
EIP:    0010:[<c011361f>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010006
eax: 00000010   ebx: e587003c   ecx: 00000019   edx: 00000010
esi: e5870000   edi: c0308000   ebp: c0309fc4   esp: c0309f8c
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c0309000)
Stack: c01053b0 c0308000 c01053b0 00000001 00000010 e5c94000 00000000
0008e000
       00000000 f3ba7660 00000001 0000002e 00000000 c0344840 0008e000
c010544e
       000fa000 0009b800 c0105000 c0105043 c030a8f1 c029da40 000fa000
000fa000
Call Trace: [<c01053b0>] [<c01053b0>] [<c010544e>] [<c0105000>] [<c0105043>] 
Code: 8b 02 0f 18 00 81 fa 20 e6 2e c0 0f 85 76 ff ff ff 83 7d f4 


>>EIP; c011361f <do_check_pgt_cache+8f/10c>   <=====

>>ebx; e587003c <END_OF_CODE+4fab3c5/????>
>>esi; e5870000 <END_OF_CODE+4fab389/????>
>>edi; c0308000 <__devicestr_104cac53+0/23>
>>ebp; c0309fc4 <__devicestr_10b75950+5/19>
>>esp; c0309f8c <__devicestr_10b75900+c/20>

Trace; c01053b0 <disable_hlt+0/8>
Trace; c01053b0 <disable_hlt+0/8>
Trace; c010544e <cpu_idle+3a/54>
Trace; c0105000 <_stext+0/0>
Trace; c0105043 <rest_init+43/44>

Code;  c011361f <do_check_pgt_cache+8f/10c>
00000000 <_EIP>:
Code;  c011361f <do_check_pgt_cache+8f/10c>   <=====
   0:   8b 02                     mov    (%edx),%eax   <=====
Code;  c0113621 <do_check_pgt_cache+91/10c>
   2:   0f 18 00                  prefetchnta (%eax)
Code;  c0113624 <do_check_pgt_cache+94/10c>
   5:   81 fa 20 e6 2e c0         cmp    $0xc02ee620,%edx
Code;  c011362a <do_check_pgt_cache+9a/10c>
   b:   0f 85 76 ff ff ff         jne    ffffff87 <_EIP+0xffffff87> c01135a6
<do_check_pgt_cache+16/10c>
Code;  c0113630 <do_check_pgt_cache+a0/10c>
  11:   83 7d f4 00               cmpl   $0x0,0xfffffff4(%ebp)

-- 
Adam McKenna <adam@flounder.net>   | GPG: 17A4 11F7 5E7E C2E7 08AA
http://flounder.net/publickey.html |      38B0 05D0 8BF7 2C6D 110A

