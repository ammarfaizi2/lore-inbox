Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264631AbTAVXSp>; Wed, 22 Jan 2003 18:18:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264644AbTAVXSp>; Wed, 22 Jan 2003 18:18:45 -0500
Received: from ns0.usq.edu.au ([139.86.2.5]:47409 "EHLO ns0.usq.edu.au")
	by vger.kernel.org with ESMTP id <S264631AbTAVXSn> convert rfc822-to-8bit;
	Wed, 22 Jan 2003 18:18:43 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: 2650 - tg3 on 2.4.18-19.7.xsmp rh7.3 ... OOPS YET AGAIN
Date: Thu, 23 Jan 2003 09:27:40 +1000
Message-ID: <08D7835AE15D6F4BABB5C46427F018DF0E608E@babbage.usq.edu.au>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2650 - tg3 on 2.4.18-19.7.xsmp rh7.3 ... OOPS AGAIN
Thread-Index: AcLB+7CNJGv2/uZ3S7ePOpA6o3suWwAcDoqA
From: "Jacek Radajewski" <jacek@usq.edu.au>
To: "Seth Mos" <knuffie@xs4all.nl>
Cc: <linux-poweredge@dell.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 22 Jan 2003 23:27:41.0098 (UTC) FILETIME=[DB94C8A0:01C2C26D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

is the network card really the problem ?  I don't want to be replacing all my network cards if the problem is elsewhere .... if you can understand the oops message please, please, please let me know where the problem is ...


another oops:
---------------------- cut ----------------------------------------------------------------

ksymoops 2.4.4 on i686 2.4.18-19.7.xsmp.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18-19.7.xsmp/ (default)
     -m /boot/System.map-2.4.18-19.7.xsmp (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (expand_objects): cannot stat(/lib/ext3.o) for ext3
Error (expand_objects): cannot stat(/lib/jbd.o) for jbd
Error (expand_objects): cannot stat(/lib/aacraid.o) for aacraid
Error (expand_objects): cannot stat(/lib/sd_mod.o) for sd_mod
Error (expand_objects): cannot stat(/lib/scsi_mod.o) for scsi_mod
Warning (map_ksym_to_module): cannot match loaded module ext3 to a unique module object.  Trace may not be reliable.
Warning (map_ksym_to_module): cannot match loaded module aacraid to a unique module object.  Trace may not be reliable.
Unable to handle kernel NULL pointer dereference at virtual address 00000007
f897f51d
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<f897f51d>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: f6a2dc00   ebx: 00000000   ecx: ffffffff   edx: c03fdc04
esi: c03fdc04   edi: 00000000   ebp: dd70b89c   esp: c0349ee4
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c0349000)
Stack: c01ac741 c03fdc04 dd70b89c 00000000 00000000 c03fdbc0 00000000 c03fdc04 
       c03fdbc0 dd70b89c c03fdc04 0000000e c01acacc c03fdc04 dd70b89c c3684e80 
       c03fdc04 00000296 c03fdbc0 c01acf99 c3684e80 0000000e f897f2f0 c36b0d60 
Call Trace: [<c01ac741>] start_request [kernel] 0x1a1 (0xc0349ee4))
[<c01acacc>] ide_do_request [kernel] 0x29c (0xc0349f14))
[<c01acf99>] ide_intr [kernel] 0x129 (0xc0349f30))
[<f897f2f0>] cdrom_pc_intr [ide-cd] 0x0 (0xc0349f3c))
[<c010a61e>] handle_IRQ_event [kernel] 0x5e (0xc0349f50))
[<c010a852>] do_IRQ [kernel] 0xc2 (0xc0349f70))
[<c0106e60>] default_idle [kernel] 0x0 (0xc0349f88))
[<c0105000>] stext [kernel] 0x0 (0xc0349f8c))
[<c010d058>] call_do_IRQ [kernel] 0x5 (0xc0349f94))
[<c0106e60>] default_idle [kernel] 0x0 (0xc0349fa4))
[<c0105000>] stext [kernel] 0x0 (0xc0349fa8))
[<c0106e8c>] default_idle [kernel] 0x2c (0xc0349fc0))
[<c0106ef4>] cpu_idle [kernel] 0x24 (0xc0349fcc))
Code: c7 41 08 00 00 00 00 68 b0 f4 97 f8 8b 41 04 50 52 e8 8d f2 

>>EIP; f897f51d <.data.end+6f1e/????>   <=====
Trace; c01ac741 <start_request+1a1/210>
Trace; c01acacc <ide_do_request+29c/2f0>
Trace; c01acf99 <ide_intr+129/160>
Trace; f897f2f0 <.data.end+6cf1/????>
Trace; c010a61e <handle_IRQ_event+5e/90>
Trace; c010a852 <do_IRQ+c2/110>
Trace; c0106e60 <default_idle+0/40>
Trace; c0105000 <_stext+0/0>
Trace; c010d058 <call_do_IRQ+5/d>
Trace; c0106e60 <default_idle+0/40>
Trace; c0105000 <_stext+0/0>
Trace; c0106e8c <default_idle+2c/40>
Trace; c0106ef4 <cpu_idle+24/30>
Code;  f897f51d <.data.end+6f1e/????>
00000000 <_EIP>:
Code;  f897f51d <.data.end+6f1e/????>   <=====
   0:   c7 41 08 00 00 00 00      movl   $0x0,0x8(%ecx)   <=====
Code;  f897f524 <.data.end+6f25/????>
   7:   68 b0 f4 97 f8            push   $0xf897f4b0
Code;  f897f529 <.data.end+6f2a/????>
   c:   8b 41 04                  mov    0x4(%ecx),%eax
Code;  f897f52c <.data.end+6f2d/????>
   f:   50                        push   %eax
Code;  f897f52d <.data.end+6f2e/????>
  10:   52                        push   %edx
Code;  f897f52e <.data.end+6f2f/????>
  11:   e8 8d f2 00 00            call   f2a3 <_EIP+0xf2a3> f898e7c0 <END_OF_CODE+161c1/????>

 <0>Kernel panic: Aiee, killing interrupt handler!

3 warnings and 5 errors issued.  Results may not be reliable.


-----Original Message-----
From: Seth Mos [mailto:knuffie@xs4all.nl]
Sent: Wednesday, 22 January 2003 7:50 PM
To: Jacek Radajewski
Cc: linux-poweredge@dell.com
Subject: RE: 2650 - tg3 on 2.4.18-19.7.xsmp rh7.3 ... OOPS AGAIN


At 15:13 22-1-2003 +1000, you wrote:
>Hi all,
>
>I've been running Linux on dell hardware for almost 5 years now and never 
>had any problems.  The number of crashes I've experienced recently makes 
>our boxes unfit for production and therefore worthless.

After a relatively short period (3 months) we replaced the broadcom cards 
with Intel e1000 cards. We disabled the onboard cards as well and stuck a 
e1000 in there. We have 0 network related crashes since then. I have just 
my testbox left that actually has a broadcom card in it.

I do have 1 e1000 (out of 5) card that seems to have some network errors 
which happen during the nightly NFS backup. I suspect a cabling issue.

10:47am  up 65 days, 22:15, 38 users
eth0 - Intel(R) PRO/1000 Network Driver - version 4.3.2-k1 NAPI (020618)
RX packets:950232292 errors:56443 dropped:56443 overruns:68 frame:0
TX packets:357551335 errors:0 dropped:0 overruns:0 carrier:0

The thing is connected to a 3com 6 port gigabit switch and is _not_ using 
jumbo frames.

Cheers

--
Seth
It might just be your lucky day, if you only knew.

