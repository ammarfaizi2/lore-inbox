Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281895AbRLAWJF>; Sat, 1 Dec 2001 17:09:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281893AbRLAWI6>; Sat, 1 Dec 2001 17:08:58 -0500
Received: from router.ems.chel.su ([195.54.2.222]:62223 "EHLO
	router.ems.chel.su") by vger.kernel.org with ESMTP
	id <S281899AbRLAWIo>; Sat, 1 Dec 2001 17:08:44 -0500
Date: Sun, 2 Dec 2001 02:34:53 +0500
From: Aleksey I Zavilohin <villain@villain.home.ems.chel.su>
To: linux-kernel@vger.kernel.org
Subject: oops in 2.4.16
Message-ID: <20011202023453.B19801@villain.home.ems.chel.su>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Organization: villain
X-Operation-System: Linux 2.4.16
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I got this oops today

ksymoops 2.4.1 on i686 2.4.16.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.16/ (default)
     -m /boot/System.map-2.4.16 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): mismatch on symbol vg  , lvm-mod says cc927e00, /lib/modules/2.4.16/kernel/drivers/md/lvm-mod.o says cc927ce0.  Ignoring /lib/modules/2.4.16/kernel/drivers/md/lvm-mod.o entry
Warning (compare_maps): mismatch on symbol audio_devs  , sound says cc865020, /lib/modules/2.4.16/kernel/drivers/sound/sound.o says cc8649a0.  Ignoring /lib/modules/2.4.16/kernel/drivers/sound/sound.o entry
Warning (compare_maps): mismatch on symbol midi_devs  , sound says cc865090, /lib/modules/2.4.16/kernel/drivers/sound/sound.o says cc864a10.  Ignoring /lib/modules/2.4.16/kernel/drivers/sound/sound.o entry
Warning (compare_maps): mismatch on symbol mixer_devs  , sound says cc865038, /lib/modules/2.4.16/kernel/drivers/sound/sound.o says cc8649b8.  Ignoring /lib/modules/2.4.16/kernel/drivers/sound/sound.o entry
Warning (compare_maps): mismatch on symbol num_audiodevs  , sound says cc865034, /lib/modules/2.4.16/kernel/drivers/sound/sound.o says cc8649b4.  Ignoring /lib/modules/2.4.16/kernel/drivers/sound/sound.o entry
Warning (compare_maps): mismatch on symbol num_midis  , sound says cc8650a8, /lib/modules/2.4.16/kernel/drivers/sound/sound.o says cc864a28.  Ignoring /lib/modules/2.4.16/kernel/drivers/sound/sound.o entry
Warning (compare_maps): mismatch on symbol num_mixers  , sound says cc86504c, /lib/modules/2.4.16/kernel/drivers/sound/sound.o says cc8649cc.  Ignoring /lib/modules/2.4.16/kernel/drivers/sound/sound.o entry
Warning (compare_maps): mismatch on symbol num_synths  , sound says cc86508c, /lib/modules/2.4.16/kernel/drivers/sound/sound.o says cc864a0c.  Ignoring /lib/modules/2.4.16/kernel/drivers/sound/sound.o entry
Warning (compare_maps): mismatch on symbol synth_devs  , sound says cc865060, /lib/modules/2.4.16/kernel/drivers/sound/sound.o says cc8649e0.  Ignoring /lib/modules/2.4.16/kernel/drivers/sound/sound.o entry
CPU:    0
EIP:    0010:[<c0110e9b>]    Tainted: P
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010006
eax: 00000001   ebx: c5a95efc   ecx: 0385d98c   edx: c4dfa1c4
esi: 00000046   edi: 00000001   ebp: c4d97ee4   esp: c4d97ecc
ds: 0018   es: 0018   ss: 0018
Process multiload_apple (pid: 744, stackpage=c4d97000)
Stack: c4a95ef8 c4495c20 c4495c74 c4a95efc 00000282 00000001 c4495c20 c0190e3e
       cbd971f4 000005a0 c01cad45 c4495c20 000005a0 c4d97f48 c4d97f80 c4d97f48
       c4a95cf4 c7219800 00000000 c4495c20 c4495880 00000000 c018e625 c4a95cf4
Call Trace: [<c0190e3e>] [<c01cad45>] [<c018e625>] [<c018e85e>] [<c012de6b>]
   [<c0106b2b>]
Code: 8b 01 85 45 fc 74 4e 31 c0 9c 5e fa c7 01 00 00 00 00 83 79

>>EIP; c0110e9b <__wake_up+2b/98>   <=====
Trace; c0190e3e <sock_def_readable+26/4c>
Trace; c01cad45 <unix_stream_sendmsg+211/2c8>
Trace; c018e625 <sock_sendmsg+69/88>
Trace; c018e85e <sock_write+b2/bc>
Trace; c012de6b <sys_write+8f/c4>
Trace; c0106b2b <system_call+33/38>
Code;  c0110e9b <__wake_up+2b/98>
00000000 <_EIP>:
Code;  c0110e9b <__wake_up+2b/98>   <=====
   0:   8b 01                     mov    (%ecx),%eax   <=====
Code;  c0110e9d <__wake_up+2d/98>
   2:   85 45 fc                  test   %eax,0xfffffffc(%ebp)
Code;  c0110ea0 <__wake_up+30/98>
   5:   74 4e                     je     55 <_EIP+0x55> c0110ef0 <__wake_up+80/98>
Code;  c0110ea2 <__wake_up+32/98>
   7:   31 c0                     xor    %eax,%eax
Code;  c0110ea4 <__wake_up+34/98>
   9:   9c                        pushf  
Code;  c0110ea5 <__wake_up+35/98>
   a:   5e                        pop    %esi
Code;  c0110ea6 <__wake_up+36/98>
   b:   fa                        cli    
Code;  c0110ea7 <__wake_up+37/98>
   c:   c7 01 00 00 00 00         movl   $0x0,(%ecx)
Code;  c0110ead <__wake_up+3d/98>
  12:   83 79 00 00               cmpl   $0x0,0x0(%ecx)


10 warnings issued.  Results may not be reliable.

-- 
Nothing is rich but the inexhaustible wealth of nature.
She shows us only surfaces, but she is a million fathoms deep.
		-- Ralph Waldo Emerson
