Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289512AbSAJPw7>; Thu, 10 Jan 2002 10:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289513AbSAJPwt>; Thu, 10 Jan 2002 10:52:49 -0500
Received: from nick.dcs.qmul.ac.uk ([138.37.88.61]:29117 "EHLO
	nick.dcs.qmul.ac.uk") by vger.kernel.org with ESMTP
	id <S289512AbSAJPwp>; Thu, 10 Jan 2002 10:52:45 -0500
Date: Thu, 10 Jan 2002 15:52:44 +0000 (GMT)
From: Matt Bernstein <matt@theBachChoir.org.uk>
To: Andrew Morton <akpm@zip.com.au>
cc: linux-kernel@vger.kernel.org
Subject: oops with 2.4.17 + mini-ll patch
Message-ID: <Pine.LNX.4.43.0201101544330.31242-100000@nick.dcs.qmul.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not sure if this is related to your patch (which looked harmless enough to
me :), but here it is anyway.

Dual PIII 1GHz, modular everything inc. ATA/IDE (VIA); SCSI (gdth.o);
NFSv3 (udp, client only); autofs4; ext2 only for local fs. Debian woody.

HTH (anything else anyone needs, let me know!)

Matt

ksymoops 2.4.3 on i686 2.4.9-ac18.  Options used
     -v /usr/src/linux-2.4.17/vmlinux (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -m /usr/src/linux-2.4.17/System.map (specified)

Unable to handle kernel NULL pointer dereference at virtual address 00000001
00000001
*pde = 00000000
Oops: 0000
CPU:    1
EIP:    0010:[<00000001>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: c0265f5c   ebx: 00000001   ecx: d26a597c   edx: c0265f5c
esi: 00000001   edi: 00000020   ebp: 00000000   esp: c181bf0c
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c181b000)
Stack: c011f106 00000001 00000000 00000001 00000020 00000000 c011b4ab c0265260
       c011b36c 00000000 00000001 c023e500 fffffffe 00000001 c011b0eb c023e500
       00000046 00000000 c023a800 00000000 00000020 c0108c1d c01f0168 c0105430
Call Trace: [<c011f106>] [<c011b4ab>] [<c011b36c>] [<c011b0eb>] [<c0108c1d>]
   [<c0105430>] [<c0105430>] [<c0105430>] [<c0105430>] [<c010545c>] [<c01054e2>]
   [<c0116e6b>] [<c0117018]
Code:  Bad EIP value.

>>EIP; 00000000 Before first symbol
Trace; c011f106 <timer_bh+256/2b0>
Trace; c011b4aa <bh_action+4a/80>
Trace; c011b36c <tasklet_hi_action+6c/a0>
Trace; c011b0ea <do_softirq+7a/e0>
Trace; c0108c1c <do_IRQ+dc/f0>
Trace; c0105430 <default_idle+0/40>
Trace; c0105430 <default_idle+0/40>
Trace; c0105430 <default_idle+0/40>
Trace; c0105430 <default_idle+0/40>
Trace; c010545c <default_idle+2c/40>
Trace; c01054e2 <cpu_idle+52/70>
Trace; c0116e6a <call_console_drivers+ea/100>


