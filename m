Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265187AbSK1FYc>; Thu, 28 Nov 2002 00:24:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265196AbSK1FYc>; Thu, 28 Nov 2002 00:24:32 -0500
Received: from pizda.ninka.net ([216.101.162.242]:32161 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S265187AbSK1FYb>;
	Thu, 28 Nov 2002 00:24:31 -0500
Date: Wed, 27 Nov 2002 21:29:10 -0800 (PST)
Message-Id: <20021127.212910.45156979.davem@redhat.com>
To: davidm@hpl.hp.com, davidm@napali.hpl.hp.com
Cc: ak@muc.de, sfr@canb.auug.org.au, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, anton@samba.org, schwidefsky@de.ibm.com,
       ralf@gnu.org, willy@debian.org
Subject: Re: [PATCH] Start of compat32.h (again)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <15844.64663.864253.832815@napali.hpl.hp.com>
References: <15844.34389.396428.645047@napali.hpl.hp.com>
	<20021127.015717.91758081.davem@redhat.com>
	<15844.64663.864253.832815@napali.hpl.hp.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: David Mosberger <davidm@napali.hpl.hp.com>
   Date: Wed, 27 Nov 2002 09:10:47 -0800

   You conveniently cut of the important part of my message:
   
   	Remember that most compatibility syscalls go straight to the
   	64-bit syscall handlers.  You're probably hosed anyhow if a
   	64-bit syscall returns, say, 0x1ffffffff, but on ia64 I'd
   	still rather play it safe and consistently have all
   	compatibility syscalls return a 64-bit sign-extended value
   	like all other syscall handlers ("least surprise" principle).

If the return path is different for the 32-bit syscalls,
which is the point I was talking about, then that code path
can sign extend, truncate, or whatever the upper 32-bits of
the return value.

You need to do things differently in the 32-bit return path anyways.

I didn't miss the content of your email at all David, quite the
opposite in fact.
