Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314511AbSDSAOa>; Thu, 18 Apr 2002 20:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314513AbSDSAO3>; Thu, 18 Apr 2002 20:14:29 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:35827
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S314511AbSDSAO2>; Thu, 18 Apr 2002 20:14:28 -0400
Date: Thu, 18 Apr 2002 17:17:00 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: Oops 2.4.19-pre3-ac1
Message-ID: <20020419001700.GI574@matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a 2x666 Pentium III (Coppermine), Dell PE2400.

->   1    17 days, 03:48:30 | Linux 2.4.19-pre3-ac1   Mon Apr  1 12:22:01 2002

It's been running for several hours after this oops happened, and ksymoops
was run on this computer.  I don't know, is the mismatch something to worry
about?

ksymoops 2.4.5 on i686 2.4.19-pre3-ac1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19-pre3-ac1/ (default)
     -m /boot/System.map-2.4.19-pre3-ac1 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base says c0217a80, System.map says c01652a0.  Ignoring ksyms_base entry
invalid operand: 0000
CPU:    0
EIP:    0010:[flush_tlb_others+44/208]    Not tainted
EFLAGS: 00010287
eax: 00000000   ebx: c340ada0   ecx: 00000001   edx: c543c000
esi: c340ada0   edi: dd837400   ebp: c543c000   esp: c543df24
ds: 0018   es: 0018   ss: 0018
Process tmpreaper (pid: 4604, stackpage=c543d000)
Stack: 00000001 c01121d8 00000001 c340ada0 ffffffff df47f320 00000000 c01184c9 
       c340ada0 cfc48000 cf538a74 c7e52574 df21a2a0 c543c000 c340adbc 00000000 
       df47f32c 00000028 c340ada0 dd837400 c0118e50 00000011 cfc48000 c543c000 
Call Trace: [flush_tlb_mm+88/96] [copy_mm+809/928] [do_fork+1168/1920] [sys_fork+20/32] [system_call+51/64]
Code: 0f 0b 85 db 75 02 0f 0b ff 42 04 f0 fe 0d 20 5e 2b c0 0f 88 
Using defaults from ksymoops -t elf32-i386 -a i386


>>ebx; c340ada0 <_end+3087c98/20488ef8>
>>edx; c543c000 <_end+50b8ef8/20488ef8>
>>esi; c340ada0 <_end+3087c98/20488ef8>
>>edi; dd837400 <_end+1d4b42f8/20488ef8>
>>ebp; c543c000 <_end+50b8ef8/20488ef8>
>>esp; c543df24 <_end+50bae1c/20488ef8>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   85 db                     test   %ebx,%ebx
Code;  00000004 Before first symbol
   4:   75 02                     jne    8 <_EIP+0x8> 00000008 Before first symbol
Code;  00000006 Before first symbol
   6:   0f 0b                     ud2a   
Code;  00000008 Before first symbol
   8:   ff 42 04                  incl   0x4(%edx)
Code;  0000000b Before first symbol
   b:   f0 fe 0d 20 5e 2b c0      lock decb 0xc02b5e20
Code;  00000012 Before first symbol
  12:   0f 88 00 00 00 00         js     18 <_EIP+0x18> 00000018 Before first symbol


2 warnings issued.  Results may not be reliable.
