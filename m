Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267553AbTAGXFu>; Tue, 7 Jan 2003 18:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267566AbTAGXFu>; Tue, 7 Jan 2003 18:05:50 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:59396 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id <S267553AbTAGXFj>; Tue, 7 Jan 2003 18:05:39 -0500
Date: Tue, 7 Jan 2003 18:14:19 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
X-X-Sender: root@oddball.prodigy.com
Reply-To: Bill Davidsen <davidsen@tmr.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [BUG] 2.5.53 ongoing OOPS in apm at boot
Message-ID: <Pine.LNX.4.44.0301071808550.1130-101000@oddball.prodigy.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1133924723-1041981259=:1130"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-1133924723-1041981259=:1130
Content-Type: TEXT/PLAIN; charset=US-ASCII

System is a humble P-II-350, used only for testing. Same bug I reported in 
2.5.50 and saw in 51 and 52. Compressed config attached, I don't find 
anything which wasn't in 2.5.47 config.

Ksymoops

ksymoops 2.4.4 on i686 2.5.53.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.53/ (default)
     -m /boot/System.map-2.5.53 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Jan  7 18:00:28 oddball kernel: Unable to handle kernel paging request at virtual address c6847000
Jan  7 18:00:28 oddball kernel: c6847000
Jan  7 18:00:28 oddball kernel: *pde = 05f6b067
Jan  7 18:00:28 oddball kernel: Oops: 0000
Jan  7 18:00:28 oddball kernel: CPU:    0
Jan  7 18:00:28 oddball kernel: EIP:    0060:[<c6847000>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Jan  7 18:00:28 oddball kernel: EFLAGS: 00010246
Jan  7 18:00:28 oddball kernel: eax: 00000102   ebx: c68603f0   ecx: ffffffff   edx: ffffffff
Jan  7 18:00:28 oddball kernel: esi: c6860a77   edi: ffffffff   ebp: c518bfec   esp: c518bfc4
Jan  7 18:00:28 oddball kernel: ds: 0068   es: 0068   ss: 0068
Jan  7 18:00:28 oddball kernel: Stack: c686047c c0402bd4 00000000 00000000 00000000 00000000 00000000 00000068 
Jan  7 18:00:28 oddball kernel:        00000000 00000000 00000000 c0108f05 00000000 00000000 00000000 
Jan  7 18:00:28 oddball kernel:  [<c686047c>] apm+0x8c/0x2a0 [apm]
Jan  7 18:00:28 oddball kernel:  [<c0108f05>] kernel_thread_helper+0x5/0x10
Jan  7 18:00:28 oddball kernel: Code:  Bad EIP value.

>>EIP; c6847000 <END_OF_CODE+63fe8cc/????>   <=====


1 warning and 1 error issued.  Results may not be reliable.


lsmod which ksymoops didn't do:

Module                  Size  Used by
apm                    15019
parport_pc             33460
parport                34595

-- 
bill davidsen <davidsen@tmr.com>

--8323328-1133924723-1041981259=:1130
Content-Type: APPLICATION/x-gzip; name="OOPS2.cfg.gz"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0301071814190.1130@oddball.prodigy.com>
Content-Description: 
Content-Disposition: attachment; filename="OOPS2.cfg.gz"

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
MgnTSjxzooN0VVv+Ads/urKcXAAA
--8323328-1133924723-1041981259=:1130--
