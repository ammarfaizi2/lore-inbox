Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422642AbVLXJvP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422642AbVLXJvP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Dec 2005 04:51:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422647AbVLXJvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Dec 2005 04:51:15 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:63707 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1422642AbVLXJvP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Dec 2005 04:51:15 -0500
Date: Sat, 24 Dec 2005 09:51:14 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: linux-kernel@vger.kernel.org
Subject: [PATCHSET] 2.6.15-rc6-bird3
Message-ID: <20051224095114.GU27946@ftp.linux.org.uk>
References: <20051222101523.GP27946@ftp.linux.org.uk> <20051223093146.GT27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051223093146.GT27946@ftp.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Updated version:
ftp://ftp.linux.org.uk/pub/people/viro/patch-2.6.15-rc6-bird3.bz2

URL of splitup: same place, bird-mbox.

New target added to tracked set: sun3 (which completes m68k coverage).
Patches in befs series are only beginning - there's more to do to get
it endian-clean.  Tomorrow...  As an aside, fs/befs is a nice demonstration
of the typedef uses that can go wrong...

BTW, sun3 had exposed an ld(1) bug - mixing PHDRS, large holes in segments
and nobits sections in the end of segments after such holes can make ld(1)
forget to map such sections into any segment.  If you've seen strip(1)
complaining about .bss - that's what it is.  After fixing init_task reference
in vmlinux-sun3.lds it doesn't trigger that bug anymore, but binutils
still needs fixing; if nobody beats me to it I'll see what can be done
about that crap...
 
Changes since yesterday snapshot:

Al Viro:
      m68k: fix reference to init_task in vmlinux-sun3.lds
      m68k: fix macfb init
      affs_fill_super() %s abuses
      befs: remove bogus typedef
      befs: prepare to sanitizing headers
      befs: introduce on-disk endian types
      befs: missing fs32_to_cpu() in debug.c

Alexey Dobriyan:
      eisa_eeprom.c: __user annotations
      parisc: add __iomem to __raw_check_addr()
      include/asm-parisc/processor.h: C99 initializers
