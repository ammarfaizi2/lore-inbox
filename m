Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262759AbTCJIfk>; Mon, 10 Mar 2003 03:35:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262756AbTCJIex>; Mon, 10 Mar 2003 03:34:53 -0500
Received: from [195.39.17.254] ([195.39.17.254]:3076 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S262750AbTCJIdl>;
	Mon, 10 Mar 2003 03:33:41 -0500
Date: Sun, 9 Mar 2003 23:26:54 +0100
From: Pavel Machek <pavel@ucw.cz>
To: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>
Subject: ioctl32 -- diffstat motivation
Message-ID: <20030309222654.GA26572@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This is what patches done. With this in, cleanups can proceed. Please
take that,
								Pavel

 arch/ia64/ia32/ia32_entry.S         |    2 
 arch/ia64/ia32/ia32_ioctl.c         |  218 ----------------------------------
 arch/mips64/kernel/ioctl32.c        |   67 ----------
 arch/mips64/kernel/scall_o32.S      |    2 
 arch/parisc/kernel/ioctl32.c        |  143 ----------------------
 arch/ppc64/kernel/ioctl32.c         |  126 --------------------
 arch/ppc64/kernel/misc.S            |    2 
 arch/s390x/kernel/ioctl32.c         |  110 -----------------
 arch/s390x/kernel/wrapper32.S       |    2 
 arch/sparc64/kernel/ioctl32.c       |  150 +----------------------
 arch/sparc64/kernel/sparc64_ksyms.c |    4 
 arch/sparc64/kernel/sunos_ioctl32.c |   52 ++++----
 arch/sparc64/kernel/systbls.S       |    2 
 arch/sparc64/solaris/ioctl.c        |   47 +++----
 arch/sparc64/solaris/timod.c        |    2 
 arch/x86_64/ia32/ia32_ioctl.c       |  226 ------------------------------------
 arch/x86_64/ia32/ia32entry.S        |    2 
 fs/compat.c                         |  223 +++++++++++++++++++++++++++++++++++
 include/linux/ioctl32.h             |    5 
 19 files changed, 297 insertions(+), 1088 deletions(-)

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
