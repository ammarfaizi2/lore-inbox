Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263887AbRFYK4X>; Mon, 25 Jun 2001 06:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263748AbRFYK4O>; Mon, 25 Jun 2001 06:56:14 -0400
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:39439 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S263745AbRFYK4G>; Mon, 25 Jun 2001 06:56:06 -0400
Message-ID: <3B3718C3.5BE353CB@delusion.de>
Date: Mon, 25 Jun 2001 12:56:03 +0200
From: "Udo A. Steinberg" <reality@delusion.de>
Organization: Disorganized
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-ac17 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: kraxel@bytesex.org
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Tvmixer Oops
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

Attached is the trace of an oops which seems to be caused by the
tvmixer code. Tvmixer is compiled monolithically into the kernel,
the rest of bttv is compiled as modules.

Kernel is 2.4.5-ac17, compiled with gcc-3.0.

Regards,
Udo.


ksymoops 2.4.1 on i686 2.4.5-ac17.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.5-ac17/ (default)
     -m /boot/System.map-2.4.5-ac17 (specified)
 
Unable to handle kernel NULL pointer dereference at virtual address 00000030
c01bd8d0
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01bd8d0>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 00000000   ebx: c86d1e40   ecx: c86d1e40   edx: c01bd8c0
esi: c14e92c0   edi: cf2e31c0   ebp: cbd0bc40   esp: c9665edc
ds: 0018   es: 0018   ss: 0018
Process kdeinit (pid: 11670, stackpage=c9665000)
Stack: c01311b9 cf2e31c0 c86d1e40 c01209c0 00000000 40afea15 00000282 c86d1e40
       00000000 00000001 0000000a c01301de c86d1e40 c4749580 00000000 c86d1e40
       00000000 00000001 c4749580 c011759e c86d1e40 c4749580 cc8ffc40 c9664000
Call Trace: [<c01311b9>] [<c01209c0>] [<c01301de>] [<c011759e>] [<c0117b7a>]
   [<c01306d3>] [<c0112bad>] [<c0117cde>] [<c0106cfb>]
Code: 8b 50 30 85 d2 74 04 50 ff d2 58 31 c0 c3 89 f6 b8 ed ff ff

>>EIP; c01bd8d0 <tvmixer_release+10/30>   <=====
Trace; c01311b9 <fput+39/c0>
Trace; c01209c0 <clear_page_tables+60/90>
Trace; c01301de <filp_close+3e/60>
Trace; c011759e <put_files_struct+4e/c0>
Trace; c0117b7a <do_exit+8a/1c0>
Trace; c01306d3 <sys_write+83/d0>
Trace; c0112bad <schedule+1fd/3c0>
Trace; c0117cde <sys_exit+e/10>
Trace; c0106cfb <system_call+33/38>
Code;  c01bd8d0 <tvmixer_release+10/30>
00000000 <_EIP>:
Code;  c01bd8d0 <tvmixer_release+10/30>   <=====
   0:   8b 50 30                  mov    0x30(%eax),%edx   <=====
Code;  c01bd8d3 <tvmixer_release+13/30>
   3:   85 d2                     test   %edx,%edx
Code;  c01bd8d5 <tvmixer_release+15/30>
   5:   74 04                     je     b <_EIP+0xb> c01bd8db <tvmixer_release+1b/30>
Code;  c01bd8d7 <tvmixer_release+17/30>
   7:   50                        push   %eax
Code;  c01bd8d8 <tvmixer_release+18/30>
   8:   ff d2                     call   *%edx
Code;  c01bd8da <tvmixer_release+1a/30>
   a:   58                        pop    %eax
Code;  c01bd8db <tvmixer_release+1b/30>
   b:   31 c0                     xor    %eax,%eax
Code;  c01bd8dd <tvmixer_release+1d/30>
   d:   c3                        ret
Code;  c01bd8de <tvmixer_release+1e/30>
   e:   89 f6                     mov    %esi,%esi
Code;  c01bd8e0 <tvmixer_release+20/30>
  10:   b8 ed ff ff 00            mov    $0xffffed,%eax
