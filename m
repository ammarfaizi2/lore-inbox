Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267313AbTAVFEW>; Wed, 22 Jan 2003 00:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267318AbTAVFEW>; Wed, 22 Jan 2003 00:04:22 -0500
Received: from ns0.usq.edu.au ([139.86.2.5]:15942 "EHLO ns0.usq.edu.au")
	by vger.kernel.org with ESMTP id <S267313AbTAVFET> convert rfc822-to-8bit;
	Wed, 22 Jan 2003 00:04:19 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: 2650 - tg3 on 2.4.18-19.7.xsmp rh7.3 ... OOPS AGAIN
Date: Wed, 22 Jan 2003 15:13:14 +1000
Message-ID: <08D7835AE15D6F4BABB5C46427F018DF0E6088@babbage.usq.edu.au>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2650 - tg3 on 2.4.18-19.7.xsmp rh7.3
Thread-Index: AcK8//dIDpz9hLR6S3ep9XmSYhYs1AAJm5AgASAvwOA=
From: "Jacek Radajewski" <jacek@usq.edu.au>
To: <linux-poweredge@dell.com>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 22 Jan 2003 05:13:14.0581 (UTC) FILETIME=[F7497850:01C2C1D4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Since installing Red Hat Linux 7.3 on our 5 DELL PowerEdge 2600 servers we had constant crashing problems (total of about 12 in 4 weeks).  I've installed all the latest patches (including kernel) but this has not helped.  I was told that the tg3 ethernet driver was the problem so Ive changed the drivers to bcm5700 on all machines except for one (hopping to catch the oops)  Well, that box did oops and I did manage to catch it and post it to the poweredge mailing list on 16/jan/2003 (see bottom of this email).  Well, since then the box running the tg3 driver crashed again but it did not dump the oops on the console ... it dumped :

mtrr: type mismatch for fd000000,800000 old: uncachable new: write-combining
mtrr: type mismatch for fd000000,800000 old: uncachable new: write-combining

but I dont think this is related cos Ive seen this before without a crash.

A far worse event was a crash of a machine running the bcm5700 driver, so tg3 could not have been the problem.  I was not able to catch the oops as I'm not running a serial console on that box.

I've been running Linux on dell hardware for almost 5 years now and never had any problems.  The number of crashes I've experienced recently makes our boxes unfit for production and therefore worthless.

Any help would be appreciated.

Jacek Radajewski

Manager, Software Development Team
Distance Education Centre
University of Southern Queensland
Toowoomba, Australia
email:  jacek@usq.edu.au
phone: +61 7 46312889

PS. was the oops I posted actually useful to anyone???

(I'm not subscribed to the kernel list so pls CC replies to jacek@usq.edu.au)


---------------- output from scripts/ver_linux -----------------------
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux cray.dec.usq.edu.au 2.4.18-19.7.xsmp #1 SMP Thu Dec 12 07:56:58 EST 2002 i686 unknown
 
Gnu C                  2.96
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.18
e2fsprogs              1.27
reiserfsprogs          3.x.0j
pcmcia-cs              3.1.22
PPP                    2.4.1
isdn4k-utils           3.1pre1
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.3.3
Sh-utils               2.0.11
Modules Loaded         autofs tg3 usb-ohci usbcore ext3 jbd aacraid sd_mod scsi_mod



-----Original Message-----
From: Jacek Radajewski 
Sent: Thursday, 16 January 2003 4:34 PM
To: linux-poweredge@dell.com
Subject: RE: 2650 - tg3 on 2.4.18-19.7.xsmp rh7.3 ... OOPS


Hi,

Just had an oops (again) on my PE2600 box running RHL 7.3 + kernel 2.4.18-19.7.  There was a lot of activity at the time between an oracle 8i client running on the box that crashed and an oracle server.  I pumped the opps through ksysoops but got some errors and warnings.  I don't know much about the kernel code, but it seems that tg3 might not be the problem in this case.  Any help will be appreciated.


details:
red hat linux 7.3 + most patches
2 GB RAM
3 x 36gb disks in raid 5 + 1 36gb in volume
2 x 2.4gb p iv

running samba, apache, weblogic 7.0, oracle 8i client


------------------ cut -------------------------------------------

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
f894451d
*pde = 00000000
Oops: 0002
CPU:    1
EIP:    0010:[<f894451d>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: dcfb0a00   ebx: 00000000   ecx: ffffffff   edx: c03fdc04
esi: c03fdc04   edi: 00000000   ebp: ca79b89c   esp: c36b7ed0
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c36b7000)
Stack: c01ac741 c03fdc04 ca79b89c 00000000 00000000 c03fdbc0 00000000 c03fdc04 
       c03fdbc0 ca79b89c c03fdc04 0000000e c01acacc c03fdc04 ca79b89c c3684e80 
       c03fdc04 00000286 c03fdbc0 c01acf99 c3684e80 0000000e f89442f0 c36b0d60 
Call Trace: [<c01ac741>] start_request [kernel] 0x1a1 (0xc36b7ed0))
[<c01acacc>] ide_do_request [kernel] 0x29c (0xc36b7f00))
[<c01acf99>] ide_intr [kernel] 0x129 (0xc36b7f1c))
[<f89442f0>] cdrom_pc_intr [ide-cd] 0x0 (0xc36b7f28))
[<c010a61e>] handle_IRQ_event [kernel] 0x5e (0xc36b7f3c))
[<c010a852>] do_IRQ [kernel] 0xc2 (0xc36b7f5c))
[<c0106e60>] default_idle [kernel] 0x0 (0xc36b7f74))
[<c010d058>] call_do_IRQ [kernel] 0x5 (0xc36b7f80))
[<c0106e60>] default_idle [kernel] 0x0 (0xc36b7f90))
[<c0106e8c>] default_idle [kernel] 0x2c (0xc36b7fac))
[<c0106ef4>] cpu_idle [kernel] 0x24 (0xc36b7fb8))
[<c011db4b>] call_console_drivers [kernel] 0xeb (0xc36b7fd0))
[<c011dcf9>] printk [kernel] 0x129 (0xc36b7ffc))
Code: c7 41 08 00 00 00 00 68 b0 44 94 f8 8b 41 04 50 52 e8 8d f2 

>>EIP; f894451d <[autofs].data.end+d79a/e27d>   <=====
Trace; c01ac741 <start_request+1a1/210>
Trace; c01acacc <ide_do_request+29c/2f0>
Trace; c01acf99 <ide_intr+129/160>
Trace; f89442f0 <[autofs].data.end+d56d/e27d>
Trace; c010a61e <handle_IRQ_event+5e/90>
Trace; c010a852 <do_IRQ+c2/110>
Trace; c0106e60 <default_idle+0/40>
Trace; c010d058 <call_do_IRQ+5/d>
Trace; c0106e60 <default_idle+0/40>
Trace; c0106e8c <default_idle+2c/40>
Trace; c0106ef4 <cpu_idle+24/30>
Trace; c011db4b <call_console_drivers+eb/100>
Trace; c011dcf9 <printk+129/140>
Code;  f894451d <[autofs].data.end+d79a/e27d>
00000000 <_EIP>:
Code;  f894451d <[autofs].data.end+d79a/e27d>   <=====
   0:   c7 41 08 00 00 00 00      movl   $0x0,0x8(%ecx)   <=====
Code;  f8944524 <[autofs].data.end+d7a1/e27d>
   7:   68 b0 44 94 f8            push   $0xf89444b0
Code;  f8944529 <[autofs].data.end+d7a6/e27d>
   c:   8b 41 04                  mov    0x4(%ecx),%eax
Code;  f894452c <[autofs].data.end+d7a9/e27d>
   f:   50                        push   %eax
Code;  f894452d <[autofs].data.end+d7aa/e27d>
  10:   52                        push   %edx
Code;  f894452e <[autofs].data.end+d7ab/e27d>
  11:   e8 8d f2 00 00            call   f2a3 <_EIP+0xf2a3> f89537c0 <.data.end+3021/????>

 <0>Kernel panic: Aiee, killing interrupt handler!

3 warnings and 5 errors issued.  Results may not be reliable.


-------------------- original oops message --------------------
Unable to handle kernel NULL pointer dereference at virtual address 00000007
 printing eip:
f894451d
*pde = 00000000
Oops: 0002
nls_iso8859-1 ide-cd cdrom soundcore autofs tg3 usb-ohci usbcore ext3 jbd aacraid sd_mod scsi_mod  
CPU:    1
EIP:    0010:[<f894451d>]    Not tainted
EFLAGS: 00010246

EIP is at cdrom_do_packet_command [ide-cd] 0x2d (2.4.18-19.7.xsmp)
eax: dcfb0a00   ebx: 00000000   ecx: ffffffff   edx: c03fdc04
esi: c03fdc04   edi: 00000000   ebp: ca79b89c   esp: c36b7ed0
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c36b7000)
Stack: c01ac741 c03fdc04 ca79b89c 00000000 00000000 c03fdbc0 00000000 c03fdc04 
       c03fdbc0 ca79b89c c03fdc04 0000000e c01acacc c03fdc04 ca79b89c c3684e80 
       c03fdc04 00000286 c03fdbc0 c01acf99 c3684e80 0000000e f89442f0 c36b0d60 
Call Trace: [<c01ac741>] start_request [kernel] 0x1a1 (0xc36b7ed0))
[<c01acacc>] ide_do_request [kernel] 0x29c (0xc36b7f00))
[<c01acf99>] ide_intr [kernel] 0x129 (0xc36b7f1c))
[<f89442f0>] cdrom_pc_intr [ide-cd] 0x0 (0xc36b7f28))
[<c010a61e>] handle_IRQ_event [kernel] 0x5e (0xc36b7f3c))
[<c010a852>] do_IRQ [kernel] 0xc2 (0xc36b7f5c))
[<c0106e60>] default_idle [kernel] 0x0 (0xc36b7f74))
[<c010d058>] call_do_IRQ [kernel] 0x5 (0xc36b7f80))
[<c0106e60>] default_idle [kernel] 0x0 (0xc36b7f90))
[<c0106e8c>] default_idle [kernel] 0x2c (0xc36b7fac))
[<c0106ef4>] cpu_idle [kernel] 0x24 (0xc36b7fb8))
[<c011db4b>] call_console_drivers [kernel] 0xeb (0xc36b7fd0))
[<c011dcf9>] printk [kernel] 0x129 (0xc36b7ffc))


Code: c7 41 08 00 00 00 00 68 b0 44 94 f8 8b 41 04 50 52 e8 8d f2 
 <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing
