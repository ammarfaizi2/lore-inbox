Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264697AbTA0X6h>; Mon, 27 Jan 2003 18:58:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264729AbTA0X6h>; Mon, 27 Jan 2003 18:58:37 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:7173
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S264697AbTA0X6g>; Mon, 27 Jan 2003 18:58:36 -0500
Date: Mon, 27 Jan 2003 16:07:49 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: Oops on 2.4.19
Message-ID: <20030128000749.GA6024@matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ksymoops 2.4.6 on i686 2.4.19-klips196.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19-klips196/ (default)
     -m /boot/System.map-2.4.19-klips196 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

oops: 0000
cpu: 0
eip: 0010:[<c014da00>] not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
eflags: 00010203
eax: dff28c30 ebx: fffffff0 ecx: 00000010 edx: 416d3207
esi: 00000000 edi: d567dfa4 ebp: 00000000 esp: d567df18
ds: 0018 es 0018 ss: 0018
process find (pid: 21850, stackpage=d567d000)
stack: 0567df74 00000000 d567dfa4 00000008 dff28c30 ddd06000 416d3207 00000008
    c0143c30 d38ed190 d567df74 d567df74 c01445b5 d38ed190 d567df74 00000000
    ddd06000 00000000 d567dfa4 00000008 00000008 ddd06008 00000000 dd06000
call trace: [<c0143c30>] [<c01445b5>] [<c014489a>] [<c0144d55>] [<c01415b9>]
  [<c0139f92>] [<c0108b13>]
code: 8b 6d 00 8b 54 24 18 39 53 44 0f 85 80 00 00 00 8b 44 24 24


>>EIP; c014da00 <d_lookup+70/120>   <=====

>>eax; dff28c30 <_end+1fb6d044/20490474>
>>edi; d567dfa4 <_end+152c23b8/20490474>
>>esp; d567df18 <_end+152c232c/20490474>

Trace; c0143c30 <cached_lookup+10/60>
Trace; c01445b5 <link_path_walk+6e5/9b0>
Trace; c014489a <path_walk+1a/20>
Trace; c0144d55 <__user_walk+35/50>
Trace; c01415b9 <sys_lstat64+19/70>
Trace; c0139f92 <sys_write+102/110>
Trace; c0108b13 <system_call+33/40>

Code;  c014da00 <d_lookup+70/120>
00000000 <_EIP>:
Code;  c014da00 <d_lookup+70/120>   <=====
   0:   8b 6d 00                  mov    0x0(%ebp),%ebp   <=====
Code;  c014da03 <d_lookup+73/120>
   3:   8b 54 24 18               mov    0x18(%esp,1),%edx
Code;  c014da07 <d_lookup+77/120>
   7:   39 53 44                  cmp    %edx,0x44(%ebx)
Code;  c014da0a <d_lookup+7a/120>
   a:   0f 85 80 00 00 00         jne    90 <_EIP+0x90> c014da90 <d_lookup+100/120>
Code;  c014da10 <d_lookup+80/120>
  10:   8b 44 24 24               mov    0x24(%esp,1),%eax


1 warning issued.  Results may not be reliable.

This is a dell poweredge 2400 dual/667 P3s with 512MB ram.

It is using software raid5 instead of the built in hardware raid (because sw
raid is faster...), with a small raid1 to boot off of.

All filesystems are ext3, and it was up 144 days before it oopsed.

This kernel is patched with freeswan 1.96, but I don't suspect it since
there weren't any traces of networking in the oops...

Anymore information needed, just let me know.

Mike
