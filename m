Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267841AbTBEH1V>; Wed, 5 Feb 2003 02:27:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267842AbTBEH1U>; Wed, 5 Feb 2003 02:27:20 -0500
Received: from durendal.skynet.be ([195.238.3.91]:29693 "EHLO
	durendal.skynet.be") by vger.kernel.org with ESMTP
	id <S267841AbTBEH1Q>; Wed, 5 Feb 2003 02:27:16 -0500
Message-ID: <010101c2cce9$4023ced0$15c809c6@PCJOERI01>
From: "Joeri Belis" <joeri.belis@nollekens.be>
To: <linux-kernel@vger.kernel.org>
Subject: mount scsi cdroms gives kernel oops
Date: Wed, 5 Feb 2003 08:36:09 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ENV: xandros 1.0 ( 2.4.19 ).
When i try to mount any of my 2 scsi cdroms on a aha152x controller, i get a
segmentation fault and i can only reset.
First i thought that is was the aha152x driver but the kernel oops gives not
about that .
But the insmod is giving errors .

Can anybody help to debug the problem. What can i try next? Do you need more
info?

Joeri

ksymoops 2.4.5 on i686 2.4.19-x1. Options used
-V (default)
-k /proc/ksyms (default)
-l /proc/modules (default)
-o /lib/modules/2.4.19-x1/ (default)
-m /boot/System.map-2.4.19-x1 (default)

Warning: You did not tell me where to find symbol information. I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc. ksymoops -h explains the options.

Error (expand_objects): cannot stat(/modules/reiserfs.o) for reiserfs
Error (expand_objects): cannot stat(/modules/splashFXmod.o) for splashFXmod
Error (pclose_local): find_objects pclose failed 0x100
Warning (compare_ksyms_lsmod): module bsd_comp is in lsmod but not in ksyms,
probably no symbols exported
Warning (compare_ksyms_lsmod): module ppp_async is in lsmod but not in
ksyms, probably no symbols exported
Warning (compare_ksyms_lsmod): module ppp_deflate is in lsmod but not in
ksyms, probably no symbols exported
Warning (compare_ksyms_lsmod): module ppp_generic is in lsmod but not in
ksyms, probably no symbols exported
Warning (compare_ksyms_lsmod): module slhc is in lsmod but not in ksyms,
probably no symbols exported
Warning (map_ksym_to_module): cannot match loaded module reiserfs to a
unique module object. Trace may not be reliable.
Feb 3 20:28:47 XANHORT6I43 kernel: c8989211
Feb 3 20:28:47 XANHORT6I43 kernel: Oops: 0000
Feb 3 20:28:47 XANHORT6I43 kernel: CPU: 0
Feb 3 20:28:47 XANHORT6I43 kernel: EIP:
1010:[serial:__insmod_serial_O/lib/modules/2.4.19-x1/kernel/drivers/char+-28
6191/96] Not tainted
Feb 3 20:28:47 XANHORT6I43 kernel: EFLAGS: 00010002
Feb 3 20:28:47 XANHORT6I43 kernel: eax: c0280000 ebx: c5993600 ecx: 00000000
edx: 00000000
Feb 3 20:28:47 XANHORT6I43 kernel: esi: c5b06000 edi: c5993600 ebp: c5b06000
esp: c3c63e78
Feb 3 20:28:47 XANHORT6I43 kernel: ds: 1018 es: 1018 ss: 1018
Feb 3 20:28:47 XANHORT6I43 kernel: Process mount (pid: 1123,
stackpage=c3c63000)
Feb 3 20:28:47 XANHORT6I43 kernel: Stack: 00000293 c5a8ab94 c5993600
c89892f1 c5993600 00000000 00000000 00000000
Feb 3 20:28:47 XANHORT6I43 kernel: c8967a94 c896754a c5993600 c8967a94
c5993600 c5a8ab94 c599370c c5a8ab40
Feb 3 20:28:47 XANHORT6I43 kernel: 00000000 c896dbcf c5993600 c5993600
00000282 c3c63f04 c3c62000 c1180848
Feb 3 20:28:47 XANHORT6I43 kernel: Call Trace:
[serial:__insmod_serial_O/lib/modules/2.4.19-x1/kernel/drivers/char+-285967/
96]
[serial:__insmod_serial_O/lib/modules/2.4.19-x1/kernel/drivers/char+-423276/
96]
[serial:__insmod_serial_O/lib/modules/2.4.19-x1/kernel/drivers/char+-424630/
96]
[serial:__insmod_serial_O/lib/modules/2.4.19-x1/kernel/drivers/char+-423276/
96]
[serial:__insmod_serial_O/lib/modules/2.4.19-x1/kernel/drivers/char+-398385/
96]
Feb 3 20:28:47 XANHORT6I43 kernel: Code: 03 51 2c 89 93 58 01 00 00 8b 40 10
89 83 5c 01 00 00 31 c0
Using defaults from ksymoops -t elf32-i386 -a i386


>>eax; c0280000
>>ebx; c5993600 <_end+56e0bb4/855c5b4>
>>esi; c5b06000 <_end+58535b4/855c5b4>
>>edi; c5993600 <_end+56e0bb4/855c5b4>
>>ebp; c5b06000 <_end+58535b4/855c5b4>
>>esp; c3c63e78 <_end+39b142c/855c5b4>

Code; 00000000 Before first symbol
00000000 <_EIP>:
Code; 00000000 Before first symbol
0: 03 51 2c add 0x2c(%ecx),%edx
Code; 00000003 Before first symbol
3: 89 93 58 01 00 00 mov %edx,0x158(%ebx)
Code; 00000009 Before first symbol
9: 8b 40 10 mov 0x10(%eax),%eax
Code; 0000000c Before first symbol
c: 89 83 5c 01 00 00 mov %eax,0x15c(%ebx)
Code; 00000012 Before first symbol
12: 31 c0 xor %eax,%eax

7 warnings and 3 errors issued. Results may not be reliable.


