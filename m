Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316667AbSH0SHo>; Tue, 27 Aug 2002 14:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316673AbSH0SHo>; Tue, 27 Aug 2002 14:07:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:19389 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S316667AbSH0SHm>;
	Tue, 27 Aug 2002 14:07:42 -0400
From: Felix Seeger <felix.seeger@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: USB mouse problem, kernel panic on startup in 2.4.19
Date: Tue, 27 Aug 2002 20:11:48 +0200
User-Agent: KMail/1.4.6
Cc: Itai Nahshon <nahshon@actcom.co.il>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200208272011.51691.felix.seeger@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi

I have the problem that with plugged in mouse in my usb port I get a kernel 
panic.

If I use port 1 instead of usb port 2 it works I think.
Also having the mouse in the usb port of the MS keyboard works.

I have a Logitech MouseMan Wheel


Here is the output from ksymoops, I never used it and hope that it is ok:

bash-2.05b# ksymoops /home/hal/panic.txt
ksymoops 2.4.6 on i686 2.4.19.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19/ (default)
     -m /boot/System.map-2.4.19 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): ksyms_base symbol 
eighty_ninty_three_R__ver_eighty_ninty_three not found in System.map.  
Ignoring ksyms_base entry
Kernel BUG at usb-ohci.h:464!
Invalid operand: 0000
CPU: 0
EIP: 0010:[<c02105e0>] Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010046
eax: 00000000  ebx: d3ed7800  ecx: d3d7800  edx: 000ee4c0
esi:  04000001  edi:  00000000  ebp: c02e7fac esp: c02e7f30
ds: 0018  es: 0018 ss: 0018
Process swapper (pid:0,stackpage=c02e7000)
Stack: d3ed7800   04000001   d980f000   c02e7fac   00000246   00000000   
c021187b   d3ed7800
          d3e97d00   04000001   0000000a   c02e7fac  00000002   c0109a9f    
0000000a   d3ed7800
          c02e7fac    00000280   c0301b00   0000000a c02e7fa4    c0109c1e   
0000000a   c02e7fac
Call Trace: [<c021187b>]  [<c01109a9f>]  [<c0109c1>]  [<c0106c20>]  
[<c0106c20>]
[<c010beb8>]  [<c0106c20>]  [<c0106c20>]  [<c0106c43>]  [<0106cb2>]  
[<c0105000>]
[<c0105027>]
Code: 0f 0b d0 01 00 ab 28 c0 8b 38 89 fd 8b 07 c1 e8 1c 75 51 8b


>>EIP; c02105e0 <dl_reverse_done_list+60/f0>   <=====

>>ebx; d3ed7800 <_end+13b9fc50/194d9450>
>>ebp; c02e7fac <init_task_union+1fac/2000>
>>esp; c02e7f30 <init_task_union+1f30/2000>

Trace; c021187b <hc_interrupt+7b/130>
Trace; c01109a9f <END_OF_CODE+b2749b520/????>
Trace; 0c0109c1 Before first symbol
Trace; c0106c20 <default_idle+0/30>
Trace; c0106c20 <default_idle+0/30>
Trace; c010beb8 <call_do_IRQ+5/d>
Trace; c0106c20 <default_idle+0/30>
Trace; c0106c20 <default_idle+0/30>
Trace; c0106c43 <default_idle+23/30>
Trace; 00106cb2 Before first symbol
Trace; c0105000 <_stext+0/0>
Trace; c0105027 <rest_init+27/30>

Code;  c02105e0 <dl_reverse_done_list+60/f0>
00000000 <_EIP>:
Code;  c02105e0 <dl_reverse_done_list+60/f0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c02105e2 <dl_reverse_done_list+62/f0>
   2:   d0 01                     rolb   (%ecx)
Code;  c02105e4 <dl_reverse_done_list+64/f0>
   4:   00 ab 28 c0 8b 38         add    %ch,0x388bc028(%ebx)
Code;  c02105ea <dl_reverse_done_list+6a/f0>
   a:   89 fd                     mov    %edi,%ebp
Code;  c02105ec <dl_reverse_done_list+6c/f0>
   c:   8b 07                     mov    (%edi),%eax
Code;  c02105ee <dl_reverse_done_list+6e/f0>
   e:   c1 e8 1c                  shr    $0x1c,%eax
Code;  c02105f1 <dl_reverse_done_list+71/f0>
  11:   75 51                     jne    64 <_EIP+0x64> c0210644 
<dl_reverse_done_list+c4/f0>
Code;  c02105f3 <dl_reverse_done_list+73/f0>
  13:   8b 00                     mov    (%eax),%eax

<0> Kernel panic: Aiee, killing interrupt handler!

2 warnings issued.  Results may not be reliable.




The output from lspci -v (not everything):
00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-751 [Irongate] System 
Controller (rev 23)
        Flags: bus master, medium devsel, latency 64
        Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Memory at fc7ff000 (32-bit, prefetchable) [size=4K]
        I/O ports at fff4 [disabled] [size=4]
        Capabilities: [a0] AGP version 1.0

00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-756 [Viper] ISA (rev 01)
        Flags: bus master, medium devsel, latency 0

00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-756 [Viper] ACPI (rev 03)
        Flags: medium devsel

00:07.4 USB Controller: Advanced Micro Devices [AMD] AMD-756 [Viper] USB (rev 
06) (prog-if 10 [OHCI])
        Flags: bus master, medium devsel, latency 16, IRQ 10
        Memory at febff000 (32-bit, non-prefetchable) [size=4K]



hope that helps.

thanks
have fun
Felix


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9a8DnS0DOrvdnsewRAhMGAJ9KI+wLJhkxP0W5NRMYioCrI7I8YACfbPiq
fzsZ9AFLvEXIfrp8vfwJfv0=
=tBsT
-----END PGP SIGNATURE-----

