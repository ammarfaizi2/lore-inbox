Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264541AbRGGBFx>; Fri, 6 Jul 2001 21:05:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264542AbRGGBFn>; Fri, 6 Jul 2001 21:05:43 -0400
Received: from trantor.dso.org.sg ([192.190.204.1]:5040 "EHLO
	trantor.dso.org.sg") by vger.kernel.org with ESMTP
	id <S264541AbRGGBFf>; Fri, 6 Jul 2001 21:05:35 -0400
Date: Sat, 7 Jul 2001 09:10:46 -0800
From: Richard Chan <cshihpin@dso.org.sg>
To: linux-kernel@vger.kernel.org
Cc: arjanv@redhat.com
Subject: Athlon oops traced to CONFIG_MK7 code in arch/i386/lib/mmx.c
Message-ID: <20010707091046.A2355@cshihpin.dso.org.sg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Athlon oops saga continues - I consistently get Athlon kernels oopsing
during the boot up process either in rc.sysinit or loading of usb modules
(this is a RedHat system 7.1). These kernels can boot to a shell init=/bin/sh
but once I try to do stuff like inserting modules they oops left, right, and centre.

System: Athlon 1.2GHz VIA KT 133A
Kernel: 2.4.5 and -ac, 2.4.6 and -ac
Compiler: gcc 2.96-RH/3.00/3.01 binutils 2.10.90/2.11.2/2.11.90


I have narrowed a(the?) problem down to the CONFIG_MK7 specific code in arch/i386/lib/mmx.c.
If I disable CONFIG_MK7 in that one file with the rest of the kernel untouched and
compiled with CONFIG_MK7 and -march=athlon then my kernel boots sucessfully and manages
to get into multi-user mode. With a few minutes of testing and X everything works fine.

I'm interested if there is an explanation of the MK7 specific code in mmx.c and
whether that could really be the source of the problem. I would like to get
to the bottom of this.

FWIW - the RedHat 7.1 stock 2.4.2 athlon kernel boots successfully without oopsen.

Thanks!

Richard Chan <cshihpin@dso.org.sg>
