Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263049AbRFRVC5>; Mon, 18 Jun 2001 17:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263078AbRFRVCs>; Mon, 18 Jun 2001 17:02:48 -0400
Received: from dialin-194-29-41-63.frankfurt.gigabell.net ([194.29.41.63]:24324
	"EHLO server1.localnet") by vger.kernel.org with ESMTP
	id <S263049AbRFRVCk>; Mon, 18 Jun 2001 17:02:40 -0400
Date: Mon, 18 Jun 2001 23:01:49 +0200
From: =?ISO-8859-1?Q?Ren=E9?= Rebe <rene.rebe@gmx.net>
To: Paul Mundt <lethal@ChaoticDreams.ORG>
Cc: jsimmons@transvirtual.com, linux-kernel@vger.kernel.org,
        ademar@conectiva.com.br, rolf@sir-wum.de,
        linux-fbdev-devel@lists.sourceforge.net
Subject: Re: sis630 - help needed debugging in the kernel
Message-Id: <20010618230149.1a8ce074.rene.rebe@gmx.net>
In-Reply-To: <20010618122800.A10027@ChaoticDreams.ORG>
In-Reply-To: <20010616232740.092475e2.rene.rebe@gmx.net>
	<Pine.LNX.4.10.10106170652280.17509-100000@transvirtual.com>
	<20010618203203.35390ca8.rene.rebe@gmx.net>
	<20010618122800.A10027@ChaoticDreams.ORG>
Organization: FreeSourceCommunity ;-)
X-Mailer: Sylpheed version 0.4.99 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jun 2001 12:28:00 -0700
Paul Mundt <lethal@ChaoticDreams.ORG> wrote:

[...]

> Yep, in fbmem.c the name entry is "sisfb" as opposed to just "sis". Also, the
> driver requires that the mode is passed video a "mode:" argument as is
> outlined in the sisfb_setup(). Take a look at drivers/video/sis/sis_main.h,
> specifically sisbios_mode[] for a list of supported modes.
> 
> Something like:
> 
> video=sisfb:mode:640x480x32
> 
> should do the job.

It crashed, too.

Full boot-up messages:

Kernel command line: root=/dev/discs/disc0/part2 video=sisfb:mode:640x480x32 console=ttyS0,9600 console=tty0  mem=131008K
Initializing CPU#0
Detected 631.427 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1258.29 BogoMIPS
Memory: 126484k/131008k available (1159k kernel code, 4136k reserved, 325k data, 204k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Celeron (Coppermine) stepping 03
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfda38, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router SIS [1039/0008] at 00:01.0
PCI: Found IRQ 10 for device 00:03.0
PCI: The same IRQ used for device 00:01.4
PCI: The same IRQ used for device 00:01.6
  got res[10000000:10000fff] for resource 0 of O2 Micro, Inc. OZ6812 Cardbus Controller
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
PnP: PNP BIOS installation structure at 0xc00f70b0
PnP: PNP BIOS version 1.0, entry at f0000:5f34, dseg at f0000
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd v1.8
VFS: Diskquotas version dquot_6.5.0 initialized
devfs: v0.102 (20000622) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
sisfb: framebuffer at 0xe0000000, mapped to 0xc8800000, size 65536k
sisfb: MMIO at 0xefce0000, mapped to 0xcc801000, size 128k
sisfb: encountered LCD
sisfb: fall back to 1024x768
sisfb: mode is 640x480x32, linelength=2560
sisfb: before sisfb_pre_setmod
sisfb: before SISSetMode
sisfb: before sisfb_post_setmode
sisfb: before sisfb_crtc_to_var
sisfb: before sisfb_set_disp
sisfb: before sisfb_heap_init
sisfb: before vc_resize_con
sisfb: before register_framebuffer
Unable to handle kernel paging request at virtual address cc800600
 printing eip:
c01ba5c0
*pde = 07f82067
*pte = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c01ba5c0>]
EFLAGS: 00010246
eax: 00000000   ebx: 00000000   ecx: cc800600   edx: c02dc400
esi: 00000000   edi: c026d527   ebp: ffffffff   esp: c123de58
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 1, stackpage=c123d000)
Stack: c02c23e0 c02dc4c0 000006e4 00000000 00000a00 00000008 cc7fc000 c01ac77c 
       c1221000 c02dc4c0 c123f344 00000001 00000666 00000000 c123f342 c123f344 
       00000001 000006e4 c018150c c1221000 c123f342 00000001 000006e4 00000000 
Call Trace: [<cc7fc000>] [<c01ac77c>] [<c018150c>] [<c0181584>] [<c01adede>] 
   [<c0181f04>] [<c01856f9>] [<c01aaeb9>] [<c0105013>] [<c010542c>] 

Code: 89 01 88 d0 c0 e8 06 83 e0 01 f7 d8 21 d8 31 f0 89 41 04 88 
 <0>Kernel panic: Attempted to kill init!

ksymoops output:

ksymoops 2.3.7 on i686 2.4.4-ac5.  Options used
     -V (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -m /mnt/net/portable/usr/src/linux/System.map (specified)

Unable to handle kernel paging request at virtual address cc800180
c01b8f61
*pde = 0af2d067
Oops: 0002
CPU:    0
EIP:    0010:[<c01b8f61>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: 0f0f0f0f   ebx: c026e51c   ecx: 00000003   edx: 00000000
esi: cc800180   edi: c026f460   ebp: 0f0f0f0f   esp: c12fde50
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 1, stackpage=c12fd000)
Stack: c02c23e0 c02dc4c0 00000593 00000000 cc7fdc08 ffffffff 00000000 00000320 
       cc7fdc00 c01ac77c c12ee000 c02dc4c0 c12fe342 00000001 0000051e 00000000 
       c12fe340 c12fe342 00000001 00000593 c018150c c12ee000 c12fe340 00000001 
Call Trace: [<cc7fdc08>] [<cc7fdc00>] [<c01ac77c>] [<c018150c>] [<c0181584>] 
   [<c01adede>] [<c0181f04>] [<c01856f9>] [<c01aaeb9>] [<c0105013>] [<c010542c>] 
Code: 89 06 8a 03 24 0f 0f b6 d0 8b 44 24 18 23 04 97 31 e8 89 46 

>>EIP; c01b8f61 <fbcon_cfb8_putcs+1ad/2c8>   <=====
Trace; cc7fdc08 <END_OF_CODE+c51ad78/????>
Trace; cc7fdc00 <END_OF_CODE+c51ad70/????>
Trace; c01ac77c <fbcon_putcs+b8/d0>
Trace; c018150c <do_update_region+118/164>
Trace; c0181584 <update_region+2c/38>
Trace; c01adede <fbcon_switch+1aa/1bc>
Trace; c0181f04 <redraw_screen+e0/160>
Trace; c01856f9 <take_over_console+ed/188>
Trace; c01aaeb9 <register_framebuffer+f9/140>
Trace; c0105013 <init+7/114>
Trace; c010542c <kernel_thread+28/38>
Code;  c01b8f61 <fbcon_cfb8_putcs+1ad/2c8>
00000000 <_EIP>:
Code;  c01b8f61 <fbcon_cfb8_putcs+1ad/2c8>   <=====
   0:   89 06                     mov    %eax,(%esi)   <=====
Code;  c01b8f63 <fbcon_cfb8_putcs+1af/2c8>
   2:   8a 03                     mov    (%ebx),%al
Code;  c01b8f65 <fbcon_cfb8_putcs+1b1/2c8>
   4:   24 0f                     and    $0xf,%al
Code;  c01b8f67 <fbcon_cfb8_putcs+1b3/2c8>
   6:   0f b6 d0                  movzbl %al,%edx
Code;  c01b8f6a <fbcon_cfb8_putcs+1b6/2c8>
   9:   8b 44 24 18               mov    0x18(%esp,1),%eax
Code;  c01b8f6e <fbcon_cfb8_putcs+1ba/2c8>
   d:   23 04 97                  and    (%edi,%edx,4),%eax
Code;  c01b8f71 <fbcon_cfb8_putcs+1bd/2c8>
  10:   31 e8                     xor    %ebp,%eax
Code;  c01b8f73 <fbcon_cfb8_putcs+1bf/2c8>
  12:   89 46 00                  mov    %eax,0x0(%esi)

 <0>Kernel panic: Attempted to kill init!

Another prolem (which may be related) is that XFree's sis-drivers is also not working
(but only because the sis301's LCD port is not enabled correct ... - Without a special
hack of me and the VESA framebuffer I get simply a black screen (NO crash ...). Only the
latest revisions of the SIS chip are affected by this problems. Older ones seem to work
(at least in X). (I only have this new chip ...).

> Regards,
> 
> -- 
> Paul Mundt <lethal@chaoticdreams.org>
> 



k33p h4ck1n6 René

-- 
René Rebe (Registered Linux user: #127875)
http://www.rene.rebe.myokay.net/
-Germany-

Anyone sending unwanted advertising e-mail to this address will be charged
$25 for network traffic and computing time. By extracting my address from
this message or its header, you agree to these terms.
