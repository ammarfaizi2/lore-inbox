Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265901AbUACDIU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 22:08:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265910AbUACDIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 22:08:20 -0500
Received: from waste.org ([209.173.204.2]:17030 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S265901AbUACDIQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 22:08:16 -0500
Date: Fri, 2 Jan 2004 21:08:14 -0600
From: Matt Mackall <mpm@selenic.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.1-rc1-tiny1 tree for small systems
Message-ID: <20040103030814.GG18208@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the third release of the -tiny kernel tree. The aim of this
tree is to collect patches that reduce kernel disk and memory
footprint as well as tools for working on small systems. Target users
are things like embedded systems, small or legacy desktop folks, and
handhelds.

Latest release includes:
 - sync against 2.6.1-rc1
 - latest netdrvr patchkit 
 - SLOB allocator
 - Andi Kleen's bloat-o-meter
 - configurable tcpdiag, inetpeer, dnotify, ptrace, sysenter/vsyscall
 - configurable X86 CPU feature detection
 - ability to override arch CFLAGS from Kconfig
 - optional uninlining of current and thread_info
 - other minor tweaks

The big bit here is SLOB, which optionally replaces the SLAB allocator
and kmalloc wrappers with a traditional malloc arena and a SLAB
emulation layer. SLOB is less than a tenth the size of the SLAB code
and is considerably more space efficient with its allocations, but is
not as fast and may prove less resistant to long-term fragmentation.

Thanks to Andi Kleen, Magnus Naeslund, and various others for their
contributions and suggestions.

The patch can be found at:

 http://selenic.com/tiny/2.6.1-rc1-tiny1.patch.bz2
 http://selenic.com/tiny/2.6.1-rc1-tiny1-broken-out.tar.bz2

Contributions and suggestions are encouraged. In particular, it would
be helpful if people with non-x86 hardware could take a stab at
extending some of the stuff that's currently only been done for X86 to
other architectures.


-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
