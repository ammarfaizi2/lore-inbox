Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264970AbSJPI3j>; Wed, 16 Oct 2002 04:29:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264972AbSJPI3j>; Wed, 16 Oct 2002 04:29:39 -0400
Received: from barclay.balt.net ([195.14.162.78]:62894 "EHLO barclay.balt.net")
	by vger.kernel.org with ESMTP id <S264970AbSJPI3h>;
	Wed, 16 Oct 2002 04:29:37 -0400
Date: Wed, 16 Oct 2002 10:32:29 +0200
From: Zilvinas Valinskas <zilvinas@gemtek.lt>
To: linux-kernel@vger.kernel.org
Subject: DRI oops 
Message-ID: <20021016083229.GA393@gemtek.lt>
Reply-To: Zilvinas Valinskas <zilvinas@gemtek.lt>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Attribution: Zilvinas
X-Url: http://www.gemtek.lt/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I have installed XFree 4.2.1 (Debian unstable), kernel 2.5.42.
I get the same oops everytime X server is restarted or on shutdown.

--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=logas

ksymoops 2.4.6 on i686 2.5.41.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.41/ (default)
     -m /boot/System.map-2.5.41 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

e100: eth0: Intel(R) PRO/100 VE Network Connection
e100: eth0 NIC Link is Up 100 Mbps Full duplex
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
kernel BUG at mm/page_alloc.c:95!
invalid operand: 0000
CPU:    0
EIP:    0060:[<c012e946>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00013202
eax: 01000001   ebx: c11d2360   ecx: 00000000   edx: 00000001
esi: cba7c000   edi: 00000000   ebp: 00000000   esp: cd047ea8
ds: 0068   es: 0068   ss: 0068
Stack: c11d2360 cba7c000 ce691800 00000000 ce691800 00000000 00003286 cba7d400 
       d07d5000 ce691800 00000000 c0110a7f cba7d400 c012f401 c012f434 d0240301 
       c11d2360 ce4de2a0 ce51a800 d0240347 ce691800 cba7c000 cd047f2c bffffc2c 
Call Trace: [<c0110a7f>]  [<c012f401>]  [<c012f434>]  [<d0240301>]  [<d0240347>]  [<d024092f>]  [<d0240880>]  [<d023bfe6>]  [<c0147ee9>]  [<c010714d>]  [<c0106fcb>] 
Code: 0f 0b 5f 00 ae 1d 28 c0 89 f6 8b 03 a8 40 74 0a 0f 0b 60 00 


>>EIP; c012e946 <__free_pages_ok+66/2e8>   <=====

>>ebx; c11d2360 <_end+e56044/fdf5d44>
>>esi; cba7c000 <_end+b6ffce4/fdf5d44>
>>esp; cd047ea8 <_end+cccbb8c/fdf5d44>

Trace; c0110a7f <iounmap+7f/90>
Trace; c012f401 <__free_pages+29/2c>
Trace; c012f434 <free_pages+30/34>
Trace; d0240301 <[i830]i830_free_page+55/5c>
Trace; d0240347 <[i830]i830_dma_cleanup+3f/a4>
Trace; d024092f <[i830]i830_dma_init+af/cc>
Trace; d0240880 <[i830]i830_dma_init+0/cc>
Trace; d023bfe6 <[i830]i830_ioctl+da/e8>
Trace; c0147ee9 <sys_ioctl+27d/2d4>
Trace; c010714d <error_code+2d/38>
Trace; c0106fcb <syscall_call+7/b>

Code;  c012e946 <__free_pages_ok+66/2e8>
00000000 <_EIP>:
Code;  c012e946 <__free_pages_ok+66/2e8>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012e948 <__free_pages_ok+68/2e8>
   2:   5f                        pop    %edi
Code;  c012e949 <__free_pages_ok+69/2e8>
   3:   00 ae 1d 28 c0 89         add    %ch,0x89c0281d(%esi)
Code;  c012e94f <__free_pages_ok+6f/2e8>
   9:   f6 8b 03 a8 40 74         (bad)  0x7440a803(%ebx)
Code;  c012e955 <__free_pages_ok+75/2e8>
   f:   0a 0f                     or     (%edi),%cl
Code;  c012e957 <__free_pages_ok+77/2e8>
  11:   0b 60 00                  or     0x0(%eax),%esp


1 warning issued.  Results may not be reliable.

--M9NhX3UHpAaciwkO--
