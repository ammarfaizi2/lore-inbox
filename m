Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263774AbRFCVpj>; Sun, 3 Jun 2001 17:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263775AbRFCVpa>; Sun, 3 Jun 2001 17:45:30 -0400
Received: from ohiper1-40.apex.net ([209.250.47.55]:19973 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S263774AbRFCVpR>; Sun, 3 Jun 2001 17:45:17 -0400
Date: Sun, 3 Jun 2001 16:45:13 -0500
From: Steven Walter <srwalter@yahoo.com>
To: linux-kernel@vger.kernel.org
Subject: [OOPS] in locks_remove_posix
Message-ID: <20010603164513.A4159@hapablap.dyn.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Uptime: 4:43pm  up  3:43,  1 user,  load average: 0.08, 0.09, 0.19
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just got this oops in 2.4.5-ac2.  Can't reproduce it as of yet; if I
find a way, I'll give notice.
-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell

ksymoops 2.3.4 on i586 2.4.5-ac2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.5-ac2/ (default)
     -m /boot/System.map-2.4.5-ac2 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): ksyms_base symbol __io_virt_debug_R__ver___io_virt_debug not found in System.map.  Ignoring ksyms_base entry
Unable to handle kernel paging request at virtual address ffffff14
c013ae26
*pde = 00001063
Oops: 0000
CPU:    0
EIP:    0010:[<c013ae26>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: ffffff0c   ebx: c66317e0   ecx: 00000000   edx: c66317e0
esi: 00000000   edi: 00000000   ebp: bffff5b8   esp: c1a9ff90
ds: 0018   es: 0018   ss: 0018
Process dnetc (pid: 227, stackpage=c1a9f000)
Stack: c012ad38 c66317e0 c1930200 00000000 c66317e0 00000000 c66317e0 080ed570 
       c012ad87 c66317e0 c1930200 c1a9e000 c0106aa3 00000005 40000000 00000000 
       080ed570 00000000 bffff5b8 00000006 0000002b 0000002b 00000006 0809a982 
Call Trace: [<c012ad38>] [<c012ad87>] [<c0106aa3>] 
Code: 8b 40 08 8b 40 08 8b 74 24 10 8b 90 a0 00 00 00 85 d2 74 4e 

>>EIP; c013ae26 <locks_remove_posix+6/6c>   <=====
Trace; c012ad38 <filp_close+58/64>
Trace; c012ad87 <sys_close+43/54>
Trace; c0106aa3 <system_call+33/40>
Code;  c013ae26 <locks_remove_posix+6/6c>
00000000 <_EIP>:
Code;  c013ae26 <locks_remove_posix+6/6c>   <=====
   0:   8b 40 08                  mov    0x8(%eax),%eax   <=====
Code;  c013ae29 <locks_remove_posix+9/6c>
   3:   8b 40 08                  mov    0x8(%eax),%eax
Code;  c013ae2c <locks_remove_posix+c/6c>
   6:   8b 74 24 10               mov    0x10(%esp,1),%esi
Code;  c013ae30 <locks_remove_posix+10/6c>
   a:   8b 90 a0 00 00 00         mov    0xa0(%eax),%edx
Code;  c013ae36 <locks_remove_posix+16/6c>
  10:   85 d2                     test   %edx,%edx
Code;  c013ae38 <locks_remove_posix+18/6c>
  12:   74 4e                     je     62 <_EIP+0x62> c013ae88 <locks_remove_posix+68/6c>


2 warnings issued.  Results may not be reliable.
