Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264647AbUGBPxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264647AbUGBPxX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 11:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264649AbUGBPxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 11:53:23 -0400
Received: from fw.osdl.org ([65.172.181.6]:19910 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264647AbUGBPxP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 11:53:15 -0400
Date: Fri, 2 Jul 2004 08:49:15 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "Michael Tasche" <michael.tasche@web.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Crash when loading a module (without executing any code of the
 module!)
Message-Id: <20040702084915.315eb814.rddunlap@osdl.org>
In-Reply-To: <200407021515.i62FEVbt025846@fmmailgate01.web.de>
References: <200407021515.i62FEVbt025846@fmmailgate01.web.de>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Jul 2004 17:15:29 +0200 Michael Tasche wrote:

| Hi,
|  
| attached you will find the .configs of the two kernel-trees.

Not.  and there was a part 2 of the request also:

| >Can you post the module source code, or a subset of it that causes
| >the problem?

My modules load OK, so without some broken source code, it's
gonna be tough.


| -Michael
|  
| On Wed, 30 Jun 2004 14:29:48 -0700, Randy.Dunlap <rddunlap@osdl.org> wrote:
| >
| >Hi-
| > 
| >On Wed, 30 Jun 2004 15:41:27 +0200 Michael Tasche wrote:
| >| Hi,
| >| currently I'm developping a small kernel module for a hardware (which was developped by a friend of mine), which is
| >| supposed to load a firmware onto a PCI-card.
| >|
| >| The development is done together with the friend, who's developping the firmware.
| >| We tried the following:
| >| He compiled a kernel-independent object (containing the firmware) on his system using kbuild
| >| (Dual-AthlonMP, SuSE 8.2 with kernel.org-kernel 2.6.3, module-init-tools 0.9.14-pre2, gcc 3.3.1,
| >| ld 2.14.90.0.5 20030722).
| >| Afterwards I tried to link it to my kernel-module (using the same kbuild makefile with
| >| firmware.o_shipped) on my machine (Fedora2, 2.6.5-3.1smp, module-init-tools 3.0-pre10, gcc 3.3.3, ld 2.15.90.0.3
| >| 20040415).
| >|
| >| This is what happened:
| >|
| >| Unable to handle kernel paging request at virtual address 82d90700
| >|  printing eip:
| >| 02135657
| >| *pde = 00000000
| >| Oops: 0002 [#1]
| >| PREEMPT SMP
| >| CPU:    1
| >| EIP:    0060:[<02135657>]    Not tainted
| >| EFLAGS: 00010246   (2.6.5-3.1smp)
| >| EIP is at module_unload_init+0xa/0x4d
| >| eax: 82d90700   ebx: 82c2387c   ecx: 82d8f600   edx: 00000000
| >| esi: 82c38f33   edi: 82c40027   ebp: 000005f0   esp: 763c3f38
| >| ds: 007b   es: 007b   ss: 0068
| >| Process insmod (pid: 1812, threadinfo=763c2000 task=7f3c60b0)
| >| Stack: 02136dc0 7864cc40 8282a000 00000000 82d8f600 00000000 00000000 00000000
| >|        00000000 00000000 0000000b 00000000 00000010 00000000 00000000 00000009
| >|        00000025 00000024 00000026 82c3829c 82c23727 82a94000 0856a008 763c3fc4
| >| Call Trace:
| >|  [<02136dc0>] load_module+0x53e/0x7fa
| >|  [<021370da>] sys_init_module+0x5e/0x293
| >|
| >| Code: 89 81 00 11 00 00 89 81 04 11 00 00 89 c8 c7 80 00 01 00 00
| > 
| >Some of those stack addresses look odd to me.
| >Please send me your kernel .config file.
| > 
| >| What puzzles me, is that I don't see any of my code in the calltrace. I had a look into the
| >| kernel-code and it seems to crash, before it even jumps into my code. What am I missing?
| >| By the way, everything works fine, if I compile the entire module on my machine.
| >| Some more testing showed, that we do also expierence a crash, if we do everything vice-versa.
| >|
| >| Regards,
| >| Michael
| >|
| >| P.S: This was also posted by the driver developer to comp.os.linux.development.system.
| > 
| >Can you post the module source code, or a subset of it that causes
| >the problem?
| > 
| >--


--
~Randy
