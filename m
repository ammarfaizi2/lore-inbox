Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262747AbSI1Imh>; Sat, 28 Sep 2002 04:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262748AbSI1Imh>; Sat, 28 Sep 2002 04:42:37 -0400
Received: from pool-151-197-234-248.phil.east.verizon.net ([151.197.234.248]:35566
	"EHLO ingchai.lan") by vger.kernel.org with ESMTP
	id <S262747AbSI1Imf>; Sat, 28 Sep 2002 04:42:35 -0400
Date: Sat, 28 Sep 2002 04:48:35 -0500
From: Steve Lion <s.lion@verizon.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.20-pre7-ac3+preempt Oops
Message-ID: <20020928094835.GA570@localnet.sytes.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Got this Oops while ripping a cd.  I've attached the Oops ran though
ksymoops.  If any other info is needed, let me know and I will give it.

-SL

--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=Oops

ksymoops 2.4.6 on i586 2.4.20-pre7-ac3.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20-pre7-ac3/ (default)
     -m /boot/System.map-2.4.20-pre7-ac3 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel paging request at virtual address 2a3af4db
c0117250
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0117250>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: ffa29829   ebx: 00000000   ecx: c0238000   edx: c0238000
esi: d2318001   edi: 000001b2   ebp: c0238000   esp: d2319edc
ds: 0018   es: 0018   ss: 0018
Process bash (pid: 360, stackpage=d2319000)
Stack: d2318000 c14ec220 d2319f40 d2318000 c0117577 d2318000 d2318000 d2319f40 
       00000001 c011c1c1 00000001 00000001 d52b2084 00000001 d2319fc4 c0106b5f 
       00000001 00000001 d2319f40 d2318000 00000000 ffffffff bffffa7c d2319f40 
Call Trace:    [<c0117577>] [<c011c1c1>] [<c0106b5f>] [<c0144dc9>] [<c011d9af>]
  [<c01061a7>] [<c0106d04>]
Code: ff 85 db 74 17 6a 01 6a 01 57 e8 dd 58 00 00 6a 01 6a 12 57 


>>EIP; c0117250 <exit_notify+260/2ac>   <=====

>>ecx; c0238000 <init_task_union+0/2000>
>>edx; c0238000 <init_task_union+0/2000>
>>esi; d2318001 <_end+1207cb6d/18575bcc>
>>ebp; c0238000 <init_task_union+0/2000>
>>esp; d2319edc <_end+1207ea48/18575bcc>

Trace; c0117577 <do_exit+2db/2f0>
Trace; c011c1c1 <sig_exit+a9/ac>
Trace; c0106b5f <do_signal+20b/27c>
Trace; c0144dc9 <dput+19/184>
Trace; c011d9af <sys_rt_sigaction+8f/ec>
Trace; c01061a7 <sys_sigreturn+cb/f4>
Trace; c0106d04 <signal_return+14/20>

Code;  c0117250 <exit_notify+260/2ac>
00000000 <_EIP>:
Code;  c0117250 <exit_notify+260/2ac>   <=====
   0:   ff 85 db 74 17 6a         incl   0x6a1774db(%ebp)   <=====
Code;  c0117256 <exit_notify+266/2ac>
   6:   01 6a 01                  add    %ebp,0x1(%edx)
Code;  c0117259 <exit_notify+269/2ac>
   9:   57                        push   %edi
Code;  c011725a <exit_notify+26a/2ac>
   a:   e8 dd 58 00 00            call   58ec <_EIP+0x58ec> c011cb3c <kill_pg+0/20>
Code;  c011725f <exit_notify+26f/2ac>
   f:   6a 01                     push   $0x1
Code;  c0117261 <exit_notify+271/2ac>
  11:   6a 12                     push   $0x12
Code;  c0117263 <exit_notify+273/2ac>
  13:   57                        push   %edi


1 warning issued.  Results may not be reliable.

--gBBFr7Ir9EOA20Yy--
