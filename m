Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291645AbSBNNll>; Thu, 14 Feb 2002 08:41:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291649AbSBNNlc>; Thu, 14 Feb 2002 08:41:32 -0500
Received: from sol.wh-hms.uni-ulm.de ([134.60.220.1]:23308 "EHLO
	sol.wh-hms.uni-ulm.de") by vger.kernel.org with ESMTP
	id <S291645AbSBNNlU>; Thu, 14 Feb 2002 08:41:20 -0500
X-Sieve: cmu-sieve 2.0
Date: Thu, 14 Feb 2002 14:33:58 +0100
From: Markus Schaber <markus.schaber@student.uni-ulm.de> (by way of
	Markus Schaber <markus.schaber@student.uni-ulm.de>)
Subject: Opses
Message-Id: <20020214143358.301201f9.markus.schaber@student.uni-ulm.de>
Organization: Uni Ulm
X-Mailer: Sylpheed version 0.7.0claws57 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: Nx5T&>Nj$VrVPv}sC3IL&)TqHHOKCz/|)R$i"*r@w0{*I6w;UNU_hdl1J4NI_m{IMztq=>cmM}1gCLbAF+9\#CGkG8}Y{x%SuQ>1#t:;Z(|\qdd[i]HStki~#w1$TPF}:0w-7"S\Ev|_a$K<GcL?@F\BY,ut6tC0P<$eV&ypzvlZ~R00!A
X-message-flag: Warning! Outlook and Outlook Express are braindead! Please use correct software!
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

[I subscribed to the list, so no Cc:s are necessary.]

After some days of uptime, I always get an Oops in the kswapd. After that, there are some other Oopses (mostly "cannot handle Kernel page request", but also some other oopses). But as far as I can see, the kswapd is always the first Oops after the reboot.

This is what ksymoops tells me:

***
multimedia:/var/log# ksymoops <messages 
ksymoops 2.4.3 on i686 2.4.17.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.17/ (default)
     -m /boot/System.map-2.4.17 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Feb 14 09:08:04 multimedia kernel: c0140a17
Feb 14 09:08:04 multimedia kernel: Oops: 0002
Feb 14 09:08:04 multimedia kernel: CPU:    0
Feb 14 09:08:04 multimedia kernel: EIP:    0010:[prune_icache+103/208]    Not tainted
Feb 14 09:08:04 multimedia kernel: EFLAGS: 00010246
Feb 14 09:08:04 multimedia kernel: eax: fd22c080   ebx: c3129648   ecx: 00000000   edx: cd0207cf
Feb 14 09:08:04 multimedia kernel: esi: c3129640   edi: c3129848   ebp: c1435f64   esp: c1435f4c
Feb 14 09:08:04 multimedia kernel: ds: 0018   es: 0018   ss: 0018
Feb 14 09:08:04 multimedia kernel: Process kswapd (pid: 5, stackpage=c1435000)
Feb 14 09:08:04 multimedia kernel: Stack: 0000000f 000001d0 00000020 00001757 c3129448 c78dfcc8 00000006 c0140a9b 
Feb 14 09:08:04 multimedia kernel:        00001559 c012968d 00000006 000001d0 00000006 000001d0 00000006 000001d0 
Feb 14 09:08:04 multimedia kernel:        c021b5c8 00000000 c021b5c8 c01296dc 00000020 c021b5c8 00000001 c1434000 
Feb 14 09:08:04 multimedia kernel: Call Trace: [shrink_icache_memory+27/64] [shrink_caches+109/128] [try_to_free_pages+60/96] [kswapd_balance_pgdat+67/144] [kswapd_balance+22/48] 
Feb 14 09:08:04 multimedia kernel: Code: 89 50 04 89 02 89 73 f8 89 73 fc 8b 45 f8 89 58 04 89 03 8d 
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   89 50 04                  mov    %edx,0x4(%eax)
Code;  00000002 Before first symbol
   3:   89 02                     mov    %eax,(%edx)
Code;  00000004 Before first symbol
   5:   89 73 f8                  mov    %esi,0xfffffff8(%ebx)
Code;  00000008 Before first symbol
   8:   89 73 fc                  mov    %esi,0xfffffffc(%ebx)
Code;  0000000a Before first symbol
   b:   8b 45 f8                  mov    0xfffffff8(%ebp),%eax
Code;  0000000e Before first symbol
   e:   89 58 04                  mov    %ebx,0x4(%eax)
Code;  00000010 Before first symbol
  11:   89 03                     mov    %eax,(%ebx)
Code;  00000012 Before first symbol
  13:   8d 00                     lea    (%eax),%eax


1 warning issued.  Results may not be reliable.
***

It happened using 2.4.14, 2.4.27 and one or two 2.4 versions I don't remember now. 

Does anybody know what this means?

If you need more diagnostics, tell me, and I'll try my best.

Thanks a lot,
Markus Schaber
-- 
"GPL software is not free - the cost is cooperation"


