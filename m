Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266507AbSKORaZ>; Fri, 15 Nov 2002 12:30:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266512AbSKORaZ>; Fri, 15 Nov 2002 12:30:25 -0500
Received: from dhcp80ff2399.dynamic.uiowa.edu ([128.255.35.153]:8320 "EHLO
	localhost") by vger.kernel.org with ESMTP id <S266507AbSKORaX>;
	Fri, 15 Nov 2002 12:30:23 -0500
Date: Fri, 15 Nov 2002 11:37:03 -0600
From: Joseph Pingenot <trelane@digitasaru.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.47 bug - PnPBIOS GPFs and kernel panics
Message-ID: <20021115173703.GA2828@digitasaru.net>
Reply-To: trelane@digitasaru.net
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-School: University of Iowa
X-vi-or-emacs: vi *and* emacs!
X-MSMail-Priority: High
X-Priority: 1 (Highest)
X-MS-TNEF-Correlator: <AFJAUFHRUOGRESULWAOIHFEAUIOFBVHSHNRAIU.monkey@spamcentral.invalid>
X-MimeOLE: Not Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Upon enabling PnPBIOS in the kernel, compiling, and rebooting into it,
  I get greeted with the following:
PnPBIOS: Found PnPBIOS installation structure at 0xc00f7d50
PnPBIOS: PnPBIOS version 1.0 entry 0xf0000:0xaa05, dseg 0x400
pnp: 00:03: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:03: ioport range 0x40b-0x40b has been reserved
pnp: 00:03: ioport range 0x480-0x48f has been reserved
pnp: 00:03: ioport range 0x4db-0x4db has been reserved
pnp: 00:03: ioport range 0x1000-0x105f has been reserved
general protection fault: 0040

CPU: 0
EIP: 0088:[<00009dff>]	Not tainted
EIP is at E Using_Versions+0x9dfe/0xc0116caf
eax: 00000040	ebx: 0000alcl	ecx: 00150000	edx: 00000005
esi: 0000b942	edi: 00000000	ebp: c11d9e0c	esp: c11d9db8
ds: 0090	es: 00a0	ss: 0068
Process swapper (pid: 1, threadinfo=c11d8000 task=c1d6040
Stack: b9870090 a1c10005 b9613032 b9250003 0a110011 0018b8e8 b8d5a1bb 0000b8c1
       b8aca1ba 0000b89a 00030000 9e0c0000 9dfec11d          00000000 00180000
       00010015 be0b0000 02f8b415 b5a3b490 b55b0000 be70b580 00000000 ae840000

Call Trace:
 [<c013033a>] kmem_cache_alloc+0x2e/0x38
 [<c0237fcc>] __pnp_bios_get_dev_node+0x11c/0x17c
 [<c0238040>] np_bios_get_dev_node+0x14/0x34
 [<c0105086>] init+0x2e/0x178
 [<c0105058>] init+0x0/0x178
 [<c0106e3d>] kernel_thread_helper+0x5/0xc

Code: Bad EIP value
  <0> Kernel panic: Attempted to kill init!

Another two error reports on the way, unrelated to this one.

-Joseph
-- 
Joseph===============================================trelane@digitasaru.net
"[The question of] copy protection has long been answered, and it's only
  a matter of months until more or less all CDs will be published with
  copy protection."  --"Ihr EMI Team" 
    http://www.theregister.co.uk/content/54/27960.html
