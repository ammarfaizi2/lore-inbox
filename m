Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262080AbSIYT2b>; Wed, 25 Sep 2002 15:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262082AbSIYT2b>; Wed, 25 Sep 2002 15:28:31 -0400
Received: from mx1.elte.hu ([157.181.1.137]:14217 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S262080AbSIYT2a>;
	Wed, 25 Sep 2002 15:28:30 -0400
Date: Wed, 25 Sep 2002 21:42:33 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Kai Germaschewski <kai-germaschewski@uiowa.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [ANNOUNCE] [patch] kksymoops, in-kernel symbolic oopser, 2.5.38-B0
In-Reply-To: <Pine.LNX.4.44.0209251415500.28659-100000@chaos.physics.uiowa.edu>
Message-ID: <Pine.LNX.4.44.0209252141080.17991-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


one unrelated build thing that doesnt work is arch/i386/defconfig. If i
add a CONFIG_KALLSYMS=y line to its debug section, and remove the
CONFIG_KALLSYMS line from the .config, and then do a 'make oldconfig', i
get this:

Kernel debugging (CONFIG_DEBUG_KERNEL) [Y/n/?]
  Debug memory allocations (CONFIG_DEBUG_SLAB) [N/y/?]
  Memory mapped I/O debugging (CONFIG_DEBUG_IOVIRT) [N/y/?]
  Magic SysRq key (CONFIG_MAGIC_SYSRQ) [Y/n/?]
  Spinlock debugging (CONFIG_DEBUG_SPINLOCK) [N/y/?]
  Load all symbols for debugging/kksymoops (CONFIG_KALLSYMS) [N/y/?] (NEW)

i'd expect the 'Y' to be picked up from the defconfig - no?

	Ingo

