Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267873AbUHXOjU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267873AbUHXOjU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 10:39:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267891AbUHXOjT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 10:39:19 -0400
Received: from bay2-f16.bay2.hotmail.com ([65.54.247.16]:54021 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S267873AbUHXOjF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 10:39:05 -0400
X-Originating-IP: [212.93.96.73]
X-Originating-Email: [ktototam1@hotmail.com]
From: "J. Dub" <ktototam1@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.26 on alpha: oops while writing to SCSI tape
Date: Tue, 24 Aug 2004 14:39:04 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY2-F16SHmFssIhJPa0006ff84@hotmail.com>
X-OriginalArrivalTime: 24 Aug 2004 14:39:04.0987 (UTC) FILETIME=[1AE54EB0:01C489E8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have two identical well-performing Alpha800 servers (kernel 2.4.26, 128 MB 
RAM, 256 MB swap).

However, running backup on local DDS2 tape crached both the systems!

Command:
tar --create --verbose --file=/dev/tape / --exclude /proc |tee backup.log

Processes run on both servers and crashed on copying regular files. Small 
files can be put on the tape without problems.
Please be tolerant since it's my first oops report. :-)

BR,
Dub




****************************************************************************************************************************

st0: Block limits 1 - 16777215 bytes.
Unable to handle kernel paging request at virtual address 0000000000000240
swapper(0): Oops 1
pc = [<fffffc0000444804>] ra = [<fffffc0000444804>] ps = 0007 Not tainted
v0 = 0000000000000000 t0 = 0000000000000000 t1 = ffffffffffe030d8
t2 = 0000000000000000 t3 = fffffc0007f125d0 t4 = 0000000000000011
t5 = fffffffffffffc18 t6 = 0000000000000006 t7 = fffffc00005ac000
s0 = 0000000000000000 s1 = 0000000000000002 s2 = fffffc0007f12400
s3 = fffffc0007f124c0 s4 = fffffc00005f2b50 s5 = 0000000000000002
s6 = fffffc00005f7cc0
a0 = fffffc0007ed6040 a1 = 0000000000007000 a2 = fffffc00005afed8
a3 = 0000000000000000 a4 = 0000000000000000 a5 = fffffc00005b2080
t8 = 000000000000001f t9 = 00000000f3a457d6 t10= 0000000000000000
t11= 0000000000000010 pv = fffffc00003233a0 at = 0000000000000000
gp = fffffc0000641908 sp = fffffc00005afdf8
Trace:fffffc000044442c fffffc0000318b2c fffffc00003195b0 fffffc000032b0d4 
fffffc0000319be4 fffffc00003137b8 fffffc0000315090 fffffc000032cf60 
fffffc000037b7b4 fffffc0000315070 fffffc000037b7b4 fffffc00003100c0 
fffffc000031001c
Code: b26901e4 a0300000 443ff001 402075a1 e4200004 d3400049 <b0090240> 
c3e00003
Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing


**************************************************************************
ksymoops 2.4.5 on alpha 2.4.26.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.26/ (default)
     -m /boot/System.map-2.4.26 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod 
file?
pc = [<fffffc0000444804>] ra = [<fffffc0000444804>] ps = 0007 Not tainted
Using defaults from ksymoops -t elf64-alpha -a alpha
v0 = 0000000000000000 t0 = 0000000000000000 t1 = ffffffffffe030d8
t2 = 0000000000000000 t3 = fffffc0007f125d0 t4 = 0000000000000011
t5 = fffffffffffffc18 t6 = 0000000000000006 t7 = fffffc00005ac000
s0 = 0000000000000000 s1 = 0000000000000002 s2 = fffffc0007f12400
s3 = fffffc0007f124c0 s4 = fffffc00005f2b50 s5 = 0000000000000002
s6 = fffffc00005f7cc0
a0 = fffffc0007ed6040 a1 = 0000000000007000 a2 = fffffc00005afed8
a3 = 0000000000000000 a4 = 0000000000000000 a5 = fffffc00005b2080
t8 = 000000000000001f t9 = 00000000f3a457d6 t10= 0000000000000000
t11= 0000000000000010 pv = fffffc00003233a0 at = 0000000000000000
gp = fffffc0000641908 sp = fffffc00005afdf8
Trace:fffffc000044442c fffffc0000318b2c fffffc00003195b0 fffffc000032b0d4 
fffffc0000319be4 fffffc00003137b8 fffffc0000315090 fffffc000032cf60 
fffffc000037b7b4 fffffc0000315070 fffffc000037b7b4 fffffc00003100c0 
fffffc000031001c
Code: b26901e4 a0300000 443ff001 402075a1 e4200004 d3400049 <b0090240> 
c3e00003


>>RA;  fffffc0000444804 <isp1020_intr_handler+3a4/4c0>

>>PC;  fffffc0000444804 <isp1020_intr_handler+3a4/4c0>   <=====

Trace; fffffc000044442c <do_isp1020_intr_handler+2c/60>
Trace; fffffc0000318b2c <handle_IRQ_event+cc/140>
Trace; fffffc00003195b0 <handle_irq+130/1c0>
Trace; fffffc000032b0d4 <noritake_srm_device_interrupt+34/60>
Trace; fffffc0000319be4 <do_entInt+c4/140>
Trace; fffffc00003137b8 <ret_from_sys_call+0/10>
Trace; fffffc0000315090 <cpu_idle+70/80>
Trace; fffffc000032cf60 <do_check_pgt_cache+0/140>
Trace; fffffc000037b7b4 <do_select+254/2c0>
Trace; fffffc0000315070 <cpu_idle+50/80>
Trace; fffffc000037b7b4 <do_select+254/2c0>
Trace; fffffc00003100c0 <rest_init+40/60>
Trace; fffffc000031001c <_stext+1c/20>

Code;  fffffc00004447ec <isp1020_intr_handler+38c/4c0>
0000000000000000 <_PC>:
Code;  fffffc00004447ec <isp1020_intr_handler+38c/4c0>
   0:   e4 01 69 b2       stl  a3,484(s0)
Code;  fffffc00004447f0 <isp1020_intr_handler+390/4c0>
   4:   00 00 30 a0       ldl  t0,0(a0)
Code;  fffffc00004447f4 <isp1020_intr_handler+394/4c0>
   8:   01 f0 3f 44       and  t0,0xff,t0
Code;  fffffc00004447f8 <isp1020_intr_handler+398/4c0>
   c:   a1 75 20 40       cmpeq        t0,0x3,t0
Code;  fffffc00004447fc <isp1020_intr_handler+39c/4c0>
  10:   04 00 20 e4       beq  t0,24 <_PC+0x24> fffffc0000444810 
<isp1020_intr_handler+3b0/4c0>
Code;  fffffc0000444800 <isp1020_intr_handler+3a0/4c0>
  14:   49 00 40 d3       bsr  ra,13c <_PC+0x13c> fffffc0000444928 
<isp1020_return_status+8/120>
Code;  fffffc0000444804 <isp1020_intr_handler+3a4/4c0>   <=====
  18:   40 02 09 b0       stl  v0,576(s0)   <=====
Code;  fffffc0000444808 <isp1020_intr_handler+3a8/4c0>
  1c:   03 00 e0 c3       br   2c <_PC+0x2c> fffffc0000444818 
<isp1020_intr_handler+3b8/4c0>

********************************************************************************************************

_________________________________________________________________
Tired of spam? Get advanced junk mail protection with MSN 8. 
http://join.msn.com/?page=features/junkmail

