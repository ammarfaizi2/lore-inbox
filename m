Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318722AbSHLFbH>; Mon, 12 Aug 2002 01:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318725AbSHLFbH>; Mon, 12 Aug 2002 01:31:07 -0400
Received: from pizda.ninka.net ([216.101.162.242]:33433 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318722AbSHLFbH>;
	Mon, 12 Aug 2002 01:31:07 -0400
Date: Sun, 11 Aug 2002 22:21:24 -0700 (PDT)
Message-Id: <20020811.222124.60543063.davem@redhat.com>
To: rusty@rustcorp.com.au
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: Re: [PATCH] Simplified scalable cpu bitmasks
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020812000347.A99CE2C185@lists.samba.org>
References: <20020812000347.A99CE2C185@lists.samba.org>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Rusty Russell <rusty@rustcorp.com.au>
   Date: Mon, 12 Aug 2002 14:42:51 +1000

   This changes bitmap_member to the more logical DECLARE_BITMAP, then
   uses it for cpu_online_map (ie. cpu_online_map is now an unsigned long
   array).
   
   Compiles and boots: Dave, how's this?

I'm ok with this for now.

I suspect that once you start using NR_CPUS in the range of 1024 or so
you want to allow the port do things like "use a pointer for cpuset_t
and NULL means CPU_MASK_ALL"

Or maybe not :-) we'll see.
