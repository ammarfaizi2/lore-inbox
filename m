Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263929AbRFRLfu>; Mon, 18 Jun 2001 07:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263930AbRFRLfk>; Mon, 18 Jun 2001 07:35:40 -0400
Received: from [203.167.224.51] ([203.167.224.51]:59913 "HELO
	metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S263929AbRFRLfe>; Mon, 18 Jun 2001 07:35:34 -0400
Date: Mon, 18 Jun 2001 23:35:02 +1200
From: Chris Wedgwood <cw@f00f.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: oopsen; 2.4.6-pre3 & dosemu
Message-ID: <20010618233501.A15523@metastasis.f00f.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Smells like a bug with dosemu to me, perhaps the LTD scribling DOSEMU
does causes grief?

I can't pretend I understand how any of this works (pointers would be
most appreciated) and perhaps someone else seens this?





  --cw

ksymoops 2.4.1 on i686 2.4.6-pre3.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.6-pre3/ (default)
     -m /boot/System.map-2.4.6-pre3 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(shmem_file_setup) not found in System.map.  Ignoring ksyms_base entry
invalid operand: 0000
CPU:    0
EIP:    0450:[<0000e819>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00030246
eax: 00001108   ebx: 00000000   ecx: 00000004   edx: 00000000
esi: 00000000   edi: 00000177   ebp: 00000824   esp: cce79f34
ds: 0000   es: 0000   ss: 0018
Process dosemu.bin (pid: 14869, stackpage=cce79000)
Stack: 00000806 000000ed 000000ed 000000ed 00000000 00000000 00000000 0f00ffff 
       00000003 00000000 00088108 00000000 00100000 00000000 00000000 00000000 
       000000c0 00000000 00001000 00000000 00000000 00000000 00000000 00000000 
Call Trace: [<c0106a7b>] [<fff8eff1>] 
Code:  Bad EIP value.

>>EIP; 0000e819 Before first symbol   <=====
Trace; c0106a7b <system_call+33/38>
Trace; fff8eff1 <END_OF_CODE+2f765217/????>


2 warnings issued.  Results may not be reliable.
