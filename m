Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264609AbUEXUX6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264609AbUEXUX6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 16:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264649AbUEXUX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 16:23:58 -0400
Received: from cicero0.cybercity.dk ([212.242.40.52]:29708 "EHLO
	cicero0.cybercity.dk") by vger.kernel.org with ESMTP
	id S264609AbUEXUXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 16:23:43 -0400
Subject: Kernel oops
From: tmp <skrald@amossen.dk>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-GaJQUnm7wI4g8JTKe6t3"
Message-Id: <1085429969.720.5.camel@debian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 24 May 2004 22:19:29 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-GaJQUnm7wI4g8JTKe6t3
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

4-5 times a day I get the attached kernel oops.
I have not touched any modules ahead of the crashes.

$ uname -a
Linux localhost 2.6.6 #1 Mon May 10 16:03:55 CEST 2004 i686 GNU/Linux

$ lsmod
Module                  Size  Used by
apm                    15536  1
md5                     3648  1
ipv6                  220064  10
snd_ice1712            41928  0
snd_ice17xx_ak4xxx      3136  1 snd_ice1712
snd_pcm_oss            48420  0
snd_mixer_oss          17216  1 snd_pcm_oss
snd_pcm                81636  2 snd_ice1712,snd_pcm_oss
snd_page_alloc          8964  1 snd_pcm
snd_timer              19844  1 snd_pcm
snd_ak4xxx_adda         5376  2 snd_ice1712,snd_ice17xx_ak4xxx
snd_cs8427              8768  1 snd_ice1712
snd_ac97_codec         60868  1 snd_ice1712
snd_i2c                 4800  2 snd_ice1712,snd_cs8427
snd_mpu401_uart         5824  1 snd_ice1712
snd_rawmidi            18976  1 snd_mpu401_uart
ide_scsi               13764  0
scsi_mod               61500  1 ide_scsi
parport_pc             18528  1
lp                      7940  0
parport                20608  2 parport_pc,lp
nls_cp437               5376  2
rtc                     9464  0
unix                   21552  538



--=-GaJQUnm7wI4g8JTKe6t3
Content-Disposition: attachment; filename=oops.txt
Content-Type: text/plain; name=oops.txt; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

May 24 22:09:46 debian kernel: Oops: 0000 [#1]
May 24 22:09:46 debian kernel: CPU:    0
May 24 22:09:46 debian kernel: EIP:    0060:[proc_get_inode+110/272]    Not tainted
May 24 22:09:46 debian kernel: EFLAGS: 00210206   (2.6.6)
May 24 22:09:46 debian kernel: EIP is at proc_get_inode+0x6e/0x110
May 24 22:09:46 debian kernel: eax: 00000000   ebx: decaf850   ecx: 00deaf36   edx: 235d66ad
May 24 22:09:46 debian kernel: esi: dffece90   edi: dffdee00   ebp: 00000004   esp: d628fe30
May 24 22:09:46 debian kernel: ds: 007b   es: 007b   ss: 0068
May 24 22:09:46 debian kernel: Process multiload-apple (pid: 705, threadinfo=d628e000 task=d8164e30)
May 24 22:09:46 debian kernel: Stack: decaf850 f000000d d95aa080 e0820ead dffece90 cb52cb68 dffecee0 c016e8e3                                                                                                             
May 24 22:09:46 debian kernel:        dffdee00 f000000d dffece90 ffffffea 00000000 dffdddd0 d628ff70 cb52cae8                                                                                                             
May 24 22:09:46 debian kernel:        cb52cae8 c016c1d1 dffdddd0 cb52cae8 d628ff70 fffffff4 dffdde38 dffdddd0                                                                                                             
May 24 22:09:46 debian kernel: Call Trace:
May 24 22:09:46 debian kernel:  [pg0+541367981/1069707264] unix_stream_sendmsg+0x24d/0x3a0 [unix]
May 24 22:09:46 debian kernel:  [proc_lookup+179/192] proc_lookup+0xb3/0xc0
May 24 22:09:46 debian kernel:  [proc_root_lookup+49/128] proc_root_lookup+0x31/0x80
May 24 22:09:46 debian kernel:  [real_lookup+203/240] real_lookup+0xcb/0xf0
May 24 22:09:46 debian kernel:  [do_lookup+150/176] do_lookup+0x96/0xb0
May 24 22:09:46 debian kernel:  [link_path_walk+1052/2048] link_path_walk+0x41c/0x800
May 24 22:09:46 debian kernel:  [path_lookup+105/272] path_lookup+0x69/0x110
May 24 22:09:46 debian kernel:  [schedule_timeout+109/192] schedule_timeout+0x6d/0xc0
May 24 22:09:46 debian kernel:  [open_namei+131/1024] open_namei+0x83/0x400
May 24 22:09:46 debian kernel:  [do_pollfd+79/144] do_pollfd+0x4f/0x90
May 24 22:09:46 debian kernel:  [filp_open+62/112] filp_open+0x3e/0x70
May 24 22:09:46 debian kernel:  [sys_open+91/144] sys_open+0x5b/0x90
May 24 22:09:46 debian kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
May 24 22:09:46 debian kernel:
May 24 22:09:46 debian kernel: Code: 8b 46 18 c7 43 38 00 00 00 00 89 43 34 0f b7 46 0e 66 85 c0

--=-GaJQUnm7wI4g8JTKe6t3
Content-Disposition: attachment; filename=oops.ksymoops.txt
Content-Type: text/plain; name=oops.ksymoops.txt; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

ksymoops 2.4.9 on i686 2.6.6.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.6/ (default)
     -m /boot/System.map-2.6.6 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
May 24 22:09:46 debian kernel: Oops: 0000 [#1]
May 24 22:09:46 debian kernel: CPU:    0
May 24 22:09:46 debian kernel: EIP:    0060:[proc_get_inode+110/272]    Not tainted
May 24 22:09:46 debian kernel: EFLAGS: 00210206   (2.6.6)
May 24 22:09:46 debian kernel: eax: 00000000   ebx: decaf850   ecx: 00deaf36   edx: 235d66ad
May 24 22:09:46 debian kernel: esi: dffece90   edi: dffdee00   ebp: 00000004   esp: d628fe30
May 24 22:09:46 debian kernel: ds: 007b   es: 007b   ss: 0068
May 24 22:09:46 debian kernel: Stack: decaf850 f000000d d95aa080 e0820ead dffece90 cb52cb68 dffecee0 c016e8e3                                                                                                             
May 24 22:09:46 debian kernel:        dffdee00 f000000d dffece90 ffffffea 00000000 dffdddd0 d628ff70 cb52cae8                                                                                                             
May 24 22:09:46 debian kernel:        cb52cae8 c016c1d1 dffdddd0 cb52cae8 d628ff70 fffffff4 dffdde38 dffdddd0                                                                                                             
May 24 22:09:46 debian kernel: Call Trace:
Warning (Oops_read): Code line not seen, dumping what data is available


>>ebx; decaf850 <pg0+1e8d8850/3fc27000>
>>esi; dffece90 <pg0+1fc15e90/3fc27000>
>>edi; dffdee00 <pg0+1fc07e00/3fc27000>
>>esp; d628fe30 <pg0+15eb8e30/3fc27000>

May 24 22:09:46 debian kernel: Code: 8b 46 18 c7 43 38 00 00 00 00 89 43 34 0f b7 46 0e 66 85 c0
Using defaults from ksymoops -t elf32-i386 -a i386


Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 46 18                  mov    0x18(%esi),%eax
Code;  00000003 Before first symbol
   3:   c7 43 38 00 00 00 00      movl   $0x0,0x38(%ebx)
Code;  0000000a Before first symbol
   a:   89 43 34                  mov    %eax,0x34(%ebx)
Code;  0000000d Before first symbol
   d:   0f b7 46 0e               movzwl 0xe(%esi),%eax
Code;  00000011 Before first symbol
  11:   66 85 c0                  test   %ax,%ax


2 warnings and 1 error issued.  Results may not be reliable.

--=-GaJQUnm7wI4g8JTKe6t3--

