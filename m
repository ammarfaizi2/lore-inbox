Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263524AbTJaSi1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 13:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263525AbTJaSi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 13:38:27 -0500
Received: from [200.32.106.149] ([200.32.106.149]:56581 "EHLO superhijitus")
	by vger.kernel.org with ESMTP id S263524AbTJaSiX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 13:38:23 -0500
Date: Fri, 31 Oct 2003 15:38:15 -0300
To: linux-kernel@vger.kernel.org
Subject: Computone and 2.4.22 OOPS
Message-ID: <20031031183815.GA30715@superhijitus.linux.org.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: diegows@linux.org.ar (Diego Woitasen (Lanux))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Summary: I 'm having problems with Linux 2.4.22 and PCI Computone Intelliport II EX. When I load the module with poll_only option and run getty (/sbin/getty ttyF0 19200 wy150) , I get a kernel oops and the system freeze.

Here is the info:


/proc/cpuinfo:
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 15
model		: 2
model name	: Intel(R) Pentium(R) 4 CPU 2.66GHz
stepping	: 7
cpu MHz		: 2657.872
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips	: 5308.41

/proc/version:
Linux version 2.4.22-xfs (root@sucursales) (gcc version 2.95.4 20011002 (Debian prerelease)) #2 Fri Oct 31 14:50:53 ART 2003

ver_linux output:
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux sucursales 2.4.22-xfs #2 Fri Oct 31 14:50:53 ART 2003 i686 unknown
 
Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.15
e2fsprogs              1.27
PPP                    2.4.1
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         ip2 ip2main e100

oops output:
Unable to handle kernel NULL pointer dereference at virtual address 00000004
 printing eip:
c011e465
*pde = 00000000
Oops: 0002
ip2 ip2main e100  
CPU:    0
EIP:    0010:[<c011e465>]    Not tainted
EFLAGS: 00010006
eax: f7c2b3f0   ebx: 00000006   ecx: 00000000   edx: 00000000
esi: f7c2b3f0   edi: f794042e   ebp: 0000015a   esp: f6a15e90
ds: 0018   es: 0018   ss: 0018
Process getty (pid: 198, stackpage=f6a15000)
Stack: 0000000a 00000000 f88a5048 f7c2b3f0 00000008 00000000 00000001 00000002 
       000c0046 000003e6 00000086 000003e6 00010002 000003e7 0001b000 f88a4a63 
       f7c2b000 00000292 00000008 00000001 f7940000 015a0207 f6a14000 0000000a 
Call Trace: [<f88a5048>]  [<f88a4a63>]  [<f88a6f2b>]  [<c02547d2>]  [<c025052a>]  [<c0254624>]  [<c0133e06>]  [<c0108683>] 
Code: 89 72 04 89 16 89 46 04 89 30 53 9d eb 14 53 9d 8b 44 24 08 

ksymoops output:
ksymoops 2.4.9 on i686 2.4.22-xfs.  Options used
     -V (default)
     -k /proc/ksyms (specified)
     -l /proc/modules (specified)
     -o /lib/modules/2.4.22-xfs/ (specified)
     -m /boot/System.map (specified)

Unable to handle kernel NULL pointer dereference at virtual address 00000004
c011e465
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c011e465>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010006
eax: f7c2b3f0   ebx: 00000006   ecx: 00000000   edx: 00000000
esi: f7c2b3f0   edi: f794042e   ebp: 0000015a   esp: f6a15e90
ds: 0018   es: 0018   ss: 0018
Process getty (pid: 198, stackpage=f6a15000)
Stack: 0000000a 00000000 f88a5048 f7c2b3f0 00000008 00000000 00000001 00000002 
       000c0046 000003e6 00000086 000003e6 00010002 000003e7 0001b000 f88a4a63 
       f7c2b000 00000292 00000008 00000001 f7940000 015a0207 f6a14000 0000000a 
Call Trace: [<f88a5048>]  [<f88a4a63>]  [<f88a6f2b>]  [<c02547d2>]  [<c025052a>]  [<c0254624>]  [<c0133e06>]  [<c0108683>] 
Code: 89 72 04 89 16 89 46 04 89 30 53 9d eb 14 53 9d 8b 44 24 08 


>>EIP; c011e465 <add_timer+b5/dc>   <=====

>>eax; f7c2b3f0 <_end+378353b4/38499fc4>
>>esi; f7c2b3f0 <_end+378353b4/38499fc4>
>>edi; f794042e <_end+3754a3f2/38499fc4>
>>esp; f6a15e90 <_end+3661fe54/38499fc4>

Trace; f88a5048 <[ip2main]serviceOutgoingFifo+350/370>
Trace; f88a4a63 <[ip2main]i2Output+26b/284>
Trace; f88a6f2b <[ip2main]ip2_write+2f/44>
Trace; c02547d2 <write_chan+1ae/208>
Trace; c025052a <tty_write+1c2/230>
Trace; c0254624 <write_chan+0/208>
Trace; c0133e06 <sys_write+96/f0>
Trace; c0108683 <system_call+33/38>

Code;  c011e465 <add_timer+b5/dc>
00000000 <_EIP>:
Code;  c011e465 <add_timer+b5/dc>   <=====
   0:   89 72 04                  mov    %esi,0x4(%edx)   <=====
Code;  c011e468 <add_timer+b8/dc>
   3:   89 16                     mov    %edx,(%esi)
Code;  c011e46a <add_timer+ba/dc>
   5:   89 46 04                  mov    %eax,0x4(%esi)
Code;  c011e46d <add_timer+bd/dc>
   8:   89 30                     mov    %esi,(%eax)
Code;  c011e46f <add_timer+bf/dc>
   a:   53                        push   %ebx
Code;  c011e470 <add_timer+c0/dc>
   b:   9d                        popf   
Code;  c011e471 <add_timer+c1/dc>
   c:   eb 14                     jmp    22 <_EIP+0x22> c011e487 <add_timer+d7/dc>
Code;  c011e473 <add_timer+c3/dc>
   e:   53                        push   %ebx
Code;  c011e474 <add_timer+c4/dc>
   f:   9d                        popf   
Code;  c011e475 <add_timer+c5/dc>
  10:   8b 44 24 08               mov    0x8(%esp,1),%eax

