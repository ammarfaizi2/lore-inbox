Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265608AbSLBHjd>; Mon, 2 Dec 2002 02:39:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265650AbSLBHjd>; Mon, 2 Dec 2002 02:39:33 -0500
Received: from pizda.ninka.net ([216.101.162.242]:62655 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S265608AbSLBHjd>;
	Mon, 2 Dec 2002 02:39:33 -0500
Date: Sun, 01 Dec 2002 23:44:38 -0800 (PST)
Message-Id: <20021201.234438.39375070.davem@redhat.com>
To: rth@twiddle.net
Cc: torvalds@transmeta.com, sfr@canb.auug.org.au, linux-kernel@vger.kernel.org,
       anton@samba.org, ak@muc.de, davidm@hpl.hp.com, schwidefsky@de.ibm.com,
       ralf@gnu.org, willy@debian.org
Subject: Re: [PATCH] Start of compat32.h (again)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021201233901.B32203@twiddle.net>
References: <Pine.LNX.4.44.0212011047440.12964-100000@home.transmeta.com>
	<1038804400.4411.4.camel@rth.ninka.net>
	<20021201233901.B32203@twiddle.net>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Richard Henderson <rth@twiddle.net>
   Date: Sun, 1 Dec 2002 23:39:01 -0800
   
   Except that x86-64 binaries get to use 16 more registers, can use
   pc-relative addressing modes, and have a sane function calling
   convention.  So things tend to run a bit faster in 64-bit mode.

Sure, I'll give you that, but nothing in the architecture is going to
half the size of every pointer for you.

I bet overall the TLB and cache usage is higher.  The things the lack
of registers do is spill and thus beat on the stack, big deal, that
all tends to be in a contiguous areas of memory (ie. same cache blocks
and same TLB pages) and at least Intel has optimized stack memory
accesses out the wazoo.
