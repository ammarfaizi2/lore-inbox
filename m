Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263589AbSLJTVp>; Tue, 10 Dec 2002 14:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265437AbSLJTVo>; Tue, 10 Dec 2002 14:21:44 -0500
Received: from dhcp5.colorado-research.com ([65.171.192.245]:61826 "EHLO
	dhcp5.colorado-research.com") by vger.kernel.org with ESMTP
	id <S263589AbSLJTUo>; Tue, 10 Dec 2002 14:20:44 -0500
Message-ID: <3DF64054.2040602@cora.nwra.com>
Date: Tue, 10 Dec 2002 12:28:20 -0700
From: Orion Poplawski <orion@cora.nwra.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: overflow on linux-2.4.19
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the same system mentioned in an earlier email, now back to 
running 2.4.19.  This crash I got an "overflow: 0000" message, instead 
of "Oops:".  I also think I've gotton more of a handle on how to run 
ksymoops.  Any help would be greatly appreciated:

ksymoops 2.4.4 on i686 2.4.19.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19/ (default)
     -m /boot/System.map-2.4.19 (default)
     -i

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (map_ksym_to_module): cannot match loaded module ext3 to a 
unique module object.  Trace may not be reliable.
CPU:    0
EIP:    0010:[<e7cefffd>] Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00000896
eax: ef6dc66c   ebx: f76dc000   ecx: 0000000e   edx: 00000001
esi: 0000000e   edi: f76dc000   ebp: 00000286   esp: ea9e9efc
ds: 0018  es: 0018  ss: 0018
Process idl (pid: 2577, stackpage=ea9e9000)
Stack: c012594c 0000000e 0000000e 00000000 c0125a30 0000000e 00000001 
f76dc000
       f76dc000 c011fdc0 00000000 00000000 c011fdcf 0000000e 00000001 
f76dc000
       f76dc0e4 c0124b9c f76dc000 f626c000 ea9e9f54 00000086 ea9e9f54 
ea9e9f54
Call Trace:    [<c012594c>] [<c0125a30>] [<c011fdc0>] [<c011fdcf>] 
[<c0124b9c>] [<c0120d3b>] [<c0120c00>] [<c012099b>] [<c010abdc>] 
[<c010cd48>]
Code: 27 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

 >>EIP; e7cefffd <_end+279e28c9/384f28cc>   <=====
Trace; c012594c <deliver_signal+1c/80>
Trace; c0125a30 <send_sig_info+80/a0>
Trace; c011fdc0 <it_real_fn+0/50>
Trace; c011fdcf <it_real_fn+f/50>
Trace; c0124b9c <timer_bh+28c/3d0>
Trace; c0120d3b <bh_action+4b/80>
Trace; c0120c00 <tasklet_hi_action+60/90>
Trace; c012099b <do_softirq+7b/e0>
Trace; c010abdc <parse_hex_value+5c/90>
Trace; c010cd48 <call_do_IRQ+5/d>
Code;  e7cefffd <_end+279e28c9/384f28cc>
00000000 <_EIP>:
Code;  e7cefffd <_end+279e28c9/384f28cc>
   0:   27                        daa


2 warnings issued.  Results may not be reliable.


