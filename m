Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964991AbWACX01@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964991AbWACX01 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 18:26:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964990AbWACX01
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 18:26:27 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:51675 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964983AbWACX00
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 18:26:26 -0500
To: torvalds@osdl.org
Subject: [PATCSET] m68k annotations and fixes
Cc: linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org
Message-Id: <E1EtvXt-0003Kh-Cb@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 03 Jan 2006 23:26:25 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This series gets mainline buildable on m68k; most of these patches apply clean
to m68k CVS as well, except for two that are pulled from m68k CVS.  Usual
mix of compile fixes, fixes of gcc4-detected crap and sparse annotations.

Compared to the last time this series had been posted: fix for breakage of
console code in head.S in absense of FRAMEBUFFER_CONSOLE changed as Roman
had suggested.

Al Viro:
      m68k: compile fix - hardirq checks were in wrong place
      m68k: compile fix - updated vmlinux.lds to include LOCK_TEXT
      m68k: namespace pollution fix (custom->amiga_custom)
      m68k: switch mac/misc.c to direct use of appropriate cuda/pmu/maciisi requests
      m68k: dumb typo in atyfb
      m68k: oktagon makefile fix
      m68k: isa_{type,sex} should be exported
      m68k: fix macro syntax to make current binutils happy
      m68k: more workarounds for recent binutils idiocy
      m68k: static vs. extern in scc.h
      m68k: static vs. extern in sun3ints.h
      m68k: static vs. extern in amigaints.h
      m68k: memory input should be an lvalue (mac/misc.c)
      m68k: broken constraints on mulu.l
      m68k: bogus function argument types (sun3_pgtable.h)
      m68k: lvalues abuse in mac8390
      m68k: lvalues abuse in dmasound
      m68k: compile fixes for dmasound (static vs. extern)
      m68k: basic iomem annotations
      m68k: basic __user annotations
      m68k: signal __user annotations
      m68k: rtc __user annotations
      m68k: syscalls __user annotation
      m68k: checksum __user annotations
      m68k: amiflop __user annotations
      m68k: ataflop __user annotations, NULL noise removal
      m68k: amiserial __user annotations
      m68k: dsp56k __user annotations
      m68k: amifb __user annotations
      m68k: zorro __user annotations
      m68k: dmasound __user annotations
      m68k: NULL noise removal
      m68k: cast in strnlen switched to unsigned long
      m68k: kill mach_floppy_setup, convert to proper __setup() in drivers
      m68k: fix use of void foo(void) asm("bar") in traps.c
      m68k: fix reference to init_task in vmlinux-sun3.lds
      m68k: fix macfb init
      m68k: fix PIO case in esp
      m68k: console code in head.S needs framebuffer support built in

Kars de Jong:
      m68k: Moved initialisation of conswitchp from subarches to global arch setup (from m68k CVS)

Roman Zippel:
      m68k: dmasound_paula.c lvalues abuse (from m68k CVS)

