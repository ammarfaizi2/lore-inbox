Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265325AbTFUU35 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 16:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265326AbTFUU34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 16:29:56 -0400
Received: from moraine.clusterfs.com ([216.138.243.178]:61378 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S265325AbTFUU3z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 16:29:55 -0400
Date: Sat, 21 Jun 2003 14:46:15 -0600
From: Peter Braam <braam@clusterfs.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.72 as VMware guest doesn't boot
Message-ID: <20030621204615.GA32341@peter.cfs>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

I'm trying to boot a 2.5.72 guest in VMware workstation 3.2. 

It uncompresess the kernel, says it is booting linux, and that's the
end of the console messages.  

I have the feeling that I have possibly grossly misconfigured the
kernel. Does someone have a working .config file?

Just in case it's something more interesting, kgdb (which hasn't hit
it's initial breakpoint yet) shows:

(gdb) target remote /dev/ttys0
Remote debugging using /dev/ttys0
0x3c0a2965 in ?? ()
warning: shared library handler failed to enable breakpoint
(gdb) bt
#0  0x3c0a2965 in ?? ()
#1  0xc010c2fa in do_IRQ (regs=
      {ebx = 67598, ecx = 0, edx = 20831, esi = 636928, edi = -1072672768,
= -1070014472, eax = -1054257152, xds = 123, xes = 123, orig_eax = -256,
= -1070013788, xcs = 96, eflags = 646, esp = -1070012999, xss =
0481085})
    at arch/i386/kernel/irq.c:503
#2  0xc010ac70 in common_interrupt () at arch/i386/kernel/entry.S:426
(gdb) c
Continuing.
Can't send signals to this remote system.  SIGEMT not sent.
                                                                           
Program received signal SIGEMT, Emulation trap.
0x3c0a2965 in ?? ()
(gdb)

Thanks for any help.

- Peter -
