Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282893AbRLBO6p>; Sun, 2 Dec 2001 09:58:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282891AbRLBO6f>; Sun, 2 Dec 2001 09:58:35 -0500
Received: from mailhost.teleline.es ([195.235.113.141]:5144 "EHLO
	tsmtp5.mail.isp") by vger.kernel.org with ESMTP id <S282892AbRLBO61>;
	Sun, 2 Dec 2001 09:58:27 -0500
Date: Sun, 2 Dec 2001 15:59:36 +0100
From: Diego Calleja <grundig@teleline.es>
To: linux-kernel@vger.kernel.org
Cc: bunk@fs.tum.de
Subject: Re: perhaps a bug in 2.4.17-pre2??
Message-ID: <20011202155936.A1040@diego>
In-Reply-To: <20011202131631.A741@diego> <Pine.NEB.4.43.0112021401330.5782-100000@mimas.fachschaften.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.NEB.4.43.0112021401330.5782-100000@mimas.fachschaften.tu-muenchen.de>; from bunk@fs.tum.de on Sun, Dec 02, 2001 at 14:03:21 +0100
X-Mailer: Balsa 1.0.pre5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Which modules were loaded at this time (nvidia?)?

Modules loaded: (no nvidia, i use 3dfx voodoo 3 3000 PCI)

Module                  Size  Used by    Tainted: PF
nls_iso8859-1           2880   1  (autoclean)
nls_cp850               3616   1  (autoclean)
vfat                    9276   1  (autoclean)
fat                    29304   0  (autoclean) [vfat]
tdfx                   32440   1 
ppp_async               6080   1  (autoclean)
ppp_generic            13832   3  (autoclean) [ppp_async]
slhc                    4480   1  (autoclean) [ppp_generic]
serial                 43968   2  (autoclean)

> 
> Could you run this Oops through ksymoops and send the output?


ksymoops 2.4.3 on i686 2.4.17-pre2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.17-pre2/ (default)
     -m /boot/System.map-2.4.17-pre2 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Dec  1 18:22:38 diego kernel: Unable to handle kernel NULL pointer
dereference at virtual address 0000008e
Dec  1 18:22:38 diego kernel: c0138078
Dec  1 18:22:38 diego kernel: *pde = 00000000
Dec  1 18:22:38 diego kernel: Oops: 0000
Dec  1 18:22:38 diego kernel: CPU:    0
Dec  1 18:22:38 diego kernel: EIP:    0010:[sys_select+0/1156]    Tainted:
PF
Dec  1 18:22:38 diego kernel: EFLAGS: 00010287
Dec  1 18:22:38 diego kernel: eax: 0000008e   ebx: c0cc2000   ecx: bffff3b4
  edx: 00000018
Dec  1 18:22:38 diego kernel: esi: bffff2b4   edi: bffff2ac   ebp: 085a5530
  esp: c0cc3fc0
Dec  1 18:22:38 diego kernel: ds: 0018   es: 0018   ss: 0018
Dec  1 18:22:38 diego kernel: Process opera (pid: 2473, stackpage=c0cc3000)
Dec  1 18:22:38 diego kernel: Stack: c0106b63 0000001a bffff3b4 bffff334
bffff2b4 bffff2ac 085a5530 0000008e
Dec  1 18:22:38 diego kernel:        c010002b 0000002b 0000008e 406e5e1e
00000023 00000203 bffff244 0000002b
Dec  1 18:22:38 diego kernel: Call Trace: [system_call+51/64]
Dec  1 18:22:38 diego kernel: Code: 00 00 00 00 00 00 00 00 20 00 00 00 20
00 00 00 00 00 00 00
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000008 Before first symbol
   8:   20 00                     and    %al,(%eax)
Code;  0000000a Before first symbol
   a:   00 00                     add    %al,(%eax)
Code;  0000000c Before first symbol
   c:   20 00                     and    %al,(%eax)


1 warning issued.  Results may not be reliable.

-----------------------------------------------------------------



