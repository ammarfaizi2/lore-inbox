Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261936AbTIPOI0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 10:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbTIPOIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 10:08:25 -0400
Received: from fep04.tuttopmi.it ([212.131.248.107]:4009 "EHLO
	fep04-svc.flexmail.it") by vger.kernel.org with ESMTP
	id S261936AbTIPOHq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 10:07:46 -0400
From: Frederik Nosi <fredi@e-salute.it>
To: linux-kernel@vger.kernel.org
Subject: [2.4.22-pre10] Kernel BUG at vmscan.c:358!
Date: Tue, 16 Sep 2003 16:02:11 +0000
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309161602.12131.fredi@e-salute.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi to all,
I know this kernel is a bit outdated (2.4.22-pre10) but just in case it is
interesting for somenoe I'm mailing the ksymoops output. Note that in the
logs there are various consecutive oopses and in this email I'm attaching
just the first one for not wasting bandwith. Of course if you need the full
log (~500 lines) just ask.
And please CC me as I'm not subscribed in the ML.

decoded oops follows,
Bye
fredi

ksymoops 2.4.8 on i686 2.4.22-pre10.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.22-pre10/ (default)
     -m /boot/System.map-2.4.22-pre10 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Sep 16 15:27:16 carcass kernel: kernel BUG at vmscan.c:358!
Sep 16 15:27:16 carcass kernel: invalid operand: 0000
Sep 16 15:27:16 carcass kernel: CPU:    0
Sep 16 15:27:16 carcass kernel: EIP:    0010:[shrink_cache+733/768]    Not tainted
Sep 16 15:27:16 carcass kernel: EIP:    0010:[<c012f8fd>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Sep 16 15:27:16 carcass kernel: EFLAGS: 00013202
Sep 16 15:27:16 carcass kernel: eax: 00000040   ebx: 00000000   ecx: c100063c   edx: 00000000
Sep 16 15:27:16 carcass kernel: esi: c1000620   edi: 000010a2   ebp: c026b650   esp: c1173f40
Sep 16 15:27:16 carcass kernel: ds: 0018   es: 0018   ss: 0018
Sep 16 15:27:16 carcass kernel: Process kswapd (pid: 5, stackpage=c1173000)
Sep 16 15:27:16 carcass kernel: Stack: c1055d64 c7396000 c1172000 0000011a 000001d0 00000013 00000011 000001d0
Sep 16 15:27:16 carcass kernel:        00000013 00000003 c012fa71 00000003 000001d0 c026b650 00000003 000001d0
Sep 16 15:27:16 carcass kernel:        c026b650 00000000 c012fae6 00000013 c026b650 c1172000 c026b5a0 c012fc14
Sep 16 15:27:16 carcass kernel: Call Trace:    [shrink_caches+97/160] [try_to_free_pages_zone+54/96] [kswapd_balance_pgdat+8
Sep 16 15:27:16 carcass kernel: Call Trace:    [<c012fa71>] [<c012fae6>] [<c012fc14>] [<c012fc79>] [<c012fdad>]
Sep 16 15:27:16 carcass kernel:   [<c0105000>] [<c010577e>] [<c012fd10>]
Sep 16 15:27:16 carcass kernel: Code: 0f 0b 66 01 b8 4c 24 c0 e9 a8 fd ff ff c7 00 00 00 00 00 e8


>>EIP; c012f8fd <shrink_cache+2dd/300>   <=====

>>ecx; c100063c <_end+d08624/a5d4048>
>>esi; c1000620 <_end+d08608/a5d4048>
>>ebp; c026b650 <contig_page_data+b0/340>
>>esp; c1173f40 <_end+e7bf28/a5d4048>

Trace; c012fa71 <shrink_caches+61/a0>
Trace; c012fae6 <try_to_free_pages_zone+36/60>
Trace; c012fc14 <kswapd_balance_pgdat+54/a0>
Trace; c012fc79 <kswapd_balance+19/30>
Trace; c012fdad <kswapd+9d/c0>
Trace; c0105000 <_stext+0/0>
Trace; c010577e <arch_kernel_thread+2e/40>
Trace; c012fd10 <kswapd+0/c0>

Code;  c012f8fd <shrink_cache+2dd/300>
00000000 <_EIP>:
Code;  c012f8fd <shrink_cache+2dd/300>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012f8ff <shrink_cache+2df/300>
   2:   66 01 b8 4c 24 c0 e9      add    %di,0xe9c0244c(%eax)
Code;  c012f906 <shrink_cache+2e6/300>
   9:   a8 fd                     test   $0xfd,%al
Code;  c012f908 <shrink_cache+2e8/300>
   b:   ff                        (bad)
Code;  c012f909 <shrink_cache+2e9/300>
   c:   ff c7                     inc    %edi
Code;  c012f90b <shrink_cache+2eb/300>
   e:   00 00                     add    %al,(%eax)
Code;  c012f90d <shrink_cache+2ed/300>
  10:   00 00                     add    %al,(%eax)
Code;  c012f90f <shrink_cache+2ef/300>
  12:   00 e8                     add    %ch,%al

