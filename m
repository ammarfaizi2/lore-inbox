Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261230AbVGYL7b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261230AbVGYL7b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 07:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbVGYL73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 07:59:29 -0400
Received: from ip3e83f6c9.speed.planet.nl ([62.131.246.201]:60370 "EHLO
	mail.pronexus.nl") by vger.kernel.org with ESMTP id S261230AbVGYL7O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 07:59:14 -0400
Message-ID: <20050725135912.iixwh4snz4gsso88@intranet.pronexus.loc>
Date: Mon, 25 Jul 2005 13:59:12 +0200
From: msmulders@pronexus.nl
To: linux-kernel@vger.kernel.org
Subject: Re: help! kernel errors?
References: <20050725115015.zo345iawcqw0gws0@intranet.pronexus.loc>
	<42E4C6E7.4060806@namesys.com>
In-Reply-To: <42E4C6E7.4060806@namesys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) H3 (4.0.1)
X-VirusScanned-By: Pronexus BV
X-SpamScanned-By: Pronexus BV
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Beantwoorden "Vladimir V. Saveliev" <vs@namesys.com>:
> You may want to take a look at linux/Documentation/oops-tracing.txt

Does this get us any closer? Still gibberish to me?

~/ksymoops-2.4.9# ./ksymoops < err.txt
ksymoops 2.4.9 on i686 2.4.31.  Options used
      -V (default)
      -k /proc/ksyms (default)
      -l /proc/modules (default)
      -o /lib/modules/2.4.31/ (default)
      -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Jul 24 23:24:51 server kernel: Unable to handle kernel paging request 
at virtual
address 04003428
Jul 24 23:24:51 server kernel: c014f3e8
Jul 24 23:24:51 server kernel: *pde = 00000000
Jul 24 23:24:51 server kernel: Oops: 0000
Jul 24 23:24:51 server kernel: CPU:    0
Jul 24 23:24:51 server kernel: EIP:    0010:[<c014f3e8>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Jul 24 23:24:51 server kernel: EFLAGS: 00010213
Jul 24 23:24:51 server kernel: eax: 0015422f   ebx: 04003400   ecx: 0000000f
edx: c1440000
Jul 24 23:24:51 server kernel: esi: 00000000   edi: c1453fa8   ebp: 0015422e
esp: c329de34
Jul 24 23:24:51 server kernel: ds: 0018   es: 0018   ss: 0018
Jul 24 23:24:51 server kernel: Process rsync (pid: 29653, stackpage=c329d000)
Jul 24 23:24:51 server kernel: Stack: 000000e4 d8a18040 00000002 0015422e
00000002 cf313000 c99e0b00 c014f641
Jul 24 23:24:51 server kernel:        cf313000 0015422e c1453fa8 00000000
00000000 fffffff3 c99e0b00 c329de8c
Jul 24 23:24:51 server kernel:        d8a1147a cf313000 00000002 0001075a
0001075a 00000286 00000020 00000000
Jul 24 23:24:51 server kernel: Call Trace:    [<c014f641>] [<d8a1147a>]
[<c0143bc7>] [<c01444a8>] [<c01448f9>]
Jul 24 23:24:51 server kernel:   [<c0144d60>] [<c0138e63>] [<c0139213>]
[<c0108c87>]
Jul 24 23:24:51 server kernel: Code: 39 6b 28 89 de 75 f1 8b 44 24 20 39 83 a0
00 00 00 75 e5 8b


>> EIP; c014f3e8 <find_inode+28/80>   <=====

>> edx; c1440000 <_end+10672fc/1852635c>
>> edi; c1453fa8 <_end+107b2a4/1852635c>
>> esp; c329de34 <_end+2ec5130/1852635c>

Trace; c014f641 <iunique+71/80>
Trace; d8a1147a <END_OF_CODE+ccaf/????>
Trace; c0143bc7 <real_lookup+c7/f0>
Trace; c01444a8 <link_path_walk+788/a20>
Trace; c01448f9 <path_lookup+39/40>
Trace; c0144d60 <open_namei+70/5f0>
Trace; c0138e63 <filp_open+43/70>
Trace; c0139213 <sys_open+53/a0>
Trace; c0108c87 <system_call+33/38>

Code;  c014f3e8 <find_inode+28/80>
00000000 <_EIP>:
Code;  c014f3e8 <find_inode+28/80>   <=====
    0:   39 6b 28                  cmp    %ebp,0x28(%ebx)   <=====
Code;  c014f3eb <find_inode+2b/80>
    3:   89 de                     mov    %ebx,%esi
Code;  c014f3ed <find_inode+2d/80>
    5:   75 f1                     jne    fffffff8 <_EIP+0xfffffff8>
Code;  c014f3ef <find_inode+2f/80>
    7:   8b 44 24 20               mov    0x20(%esp,1),%eax
Code;  c014f3f3 <find_inode+33/80>
    b:   39 83 a0 00 00 00         cmp    %eax,0xa0(%ebx)
Code;  c014f3f9 <find_inode+39/80>
   11:   75 e5                     jne    fffffff8 <_EIP+0xfffffff8>
Code;  c014f3fb <find_inode+3b/80>
   13:   8b 00                     mov    (%eax),%eax


1 warning issued.  Results may not be reliable.


