Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131205AbRDFEMX>; Fri, 6 Apr 2001 00:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131206AbRDFEME>; Fri, 6 Apr 2001 00:12:04 -0400
Received: from ohiper1-134.apex.net ([209.250.47.149]:10756 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S131205AbRDFEL6>; Fri, 6 Apr 2001 00:11:58 -0400
Date: Thu, 5 Apr 2001 23:10:25 -0500
From: Steven Walter <srwalter@yahoo.com>
To: linux-kernel@vger.kernel.org
Subject: Oopsen everywhere in open_namei, kernel 2.4.3
Message-ID: <20010405231025.A736@hapablap.dyn.dhs.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Uptime: 11:08pm  up 11 min,  1 user,  load average: 1.06, 1.03, 0.60
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Right after a boot, I got 5 oopsen within about 8 minutes.  There are
only two unique ones, which are attached.  Each one occured at least
twice.  Someone know what's going on?
-- 
-Steven
Freedom is the freedom to say that two plus two equals four.

--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=bug4a

ksymoops 2.3.4 on i586 2.4.3.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.3/ (default)
     -m /boot/System.map-2.4.3 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel paging request at virtual address 78e85047
c01378c3
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c01378c3>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010297
eax: 00000000   ebx: c3121460   ecx: 00000001   edx: 000003e8
esi: ffffffff   edi: 00000001   ebp: 00000001   esp: c4b43f4c
ds: 0018   es: 0018   ss: 0018
Process modemlights_app (pid: 301, stackpage=c4b43000)
Stack: 00000000 080be760 00000001 c72e4000 ffffffff 00000000 00000004 c47d0ac0 
       c012c87e c72e4000 00000001 000001b6 c4b43f84 00000010 c47d0ac0 c1241240 
       00000001 c72e4000 00000000 00000001 00000001 c012cb89 c72e4000 00000000 
Call Trace: [<c012c87e>] [<c012cb89>] [<c0106d73>] 
Code: ff 89 46 50 e8 78 3b ff ff 89 46 54 8b 4d e0 8b 7d 0c 89 4d 

>>EIP; c01378c3 <open_namei+3f7/590>   <=====
Trace; c012c87e <filp_open+2e/4c>
Trace; c012cb89 <sys_open+35/b4>
Trace; c0106d73 <system_call+33/40>
Code;  c01378c3 <open_namei+3f7/590>
00000000 <_EIP>:
Code;  c01378c3 <open_namei+3f7/590>   <=====
   0:   ff 89 46 50 e8 78         decl   0x78e85046(%ecx)   <=====
Code;  c01378c9 <open_namei+3fd/590>
   6:   3b ff                     cmp    %edi,%edi
Code;  c01378cb <open_namei+3ff/590>
   8:   ff 89 46 54 8b 4d         decl   0x4d8b5446(%ecx)
Code;  c01378d1 <open_namei+405/590>
   e:   e0 8b                     loopne ffffff9b <_EIP+0xffffff9b> c013785e <open_namei+392/590>
Code;  c01378d3 <open_namei+407/590>
  10:   7d 0c                     jge    1e <_EIP+0x1e> c01378e1 <open_namei+415/590>
Code;  c01378d5 <open_namei+409/590>
  12:   89 4d 00                  mov    %ecx,0x0(%ebp)


1 warning issued.  Results may not be reliable.

--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=bug5a

ksymoops 2.3.4 on i586 2.4.3.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.3/ (default)
     -m /boot/System.map-2.4.3 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel paging request at virtual address 78e8504a
c01378c3
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c01378c3>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00210293
eax: 00000000   ebx: c7f2f260   ecx: 00000004   edx: 00000000
esi: ffffffff   edi: 00000001   ebp: 00000001   esp: c317ff4c
ds: 0018   es: 0018   ss: 0018
Process gpm (pid: 462, stackpage=c317f000)
Stack: 00000000 08058240 00000001 c784b000 00200286 00000000 00000004 c76e1f40 
       c012c87e c784b000 00000001 00000001 c317ff84 00000002 c76e1f40 c1241240 
       00000001 c784b000 00000000 00000001 00000001 c012cb89 c784b000 00000000 
Call Trace: [<c012c87e>] [<c012cb89>] [<c0106d73>] 
Code: f6 75 77 f7 c5 00 02 00 00 74 5c 53 e8 ec ec ff ff 89 c6 83 

>>EIP; c01378c3 <open_namei+3f7/590>   <=====
Trace; c012c87e <filp_open+2e/4c>
Trace; c012cb89 <sys_open+35/b4>
Trace; c0106d73 <system_call+33/40>
Code;  c01378c3 <open_namei+3f7/590>
00000000 <_EIP>:
Code;  c01378c3 <open_namei+3f7/590>   <=====
   0:   f6 75 77                  div    0x77(%ebp),%al   <=====
Code;  c01378c6 <open_namei+3fa/590>
   3:   f7 c5 00 02 00 00         test   $0x200,%ebp
Code;  c01378cc <open_namei+400/590>
   9:   74 5c                     je     67 <_EIP+0x67> c013792a <open_namei+45e/590>
Code;  c01378ce <open_namei+402/590>
   b:   53                        push   %ebx
Code;  c01378cf <open_namei+403/590>
   c:   e8 ec ec ff ff            call   ffffecfd <_EIP+0xffffecfd> c01365c0 <get_write_access+0/20>
Code;  c01378d4 <open_namei+408/590>
  11:   89 c6                     mov    %eax,%esi
Code;  c01378d6 <open_namei+40a/590>
  13:   83 00 00                  addl   $0x0,(%eax)


1 warning issued.  Results may not be reliable.

--J2SCkAp4GZ/dPZZf--
