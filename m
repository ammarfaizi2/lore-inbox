Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317497AbSHLISa>; Mon, 12 Aug 2002 04:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317493AbSHLIRj>; Mon, 12 Aug 2002 04:17:39 -0400
Received: from dp.samba.org ([66.70.73.150]:7657 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S317494AbSHLIR1>;
	Mon, 12 Aug 2002 04:17:27 -0400
Date: Mon, 12 Aug 2002 18:14:57 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: "David S. Miller" <davem@redhat.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: Re: [PATCH] Simplified scalable cpu bitmasks
Message-Id: <20020812181457.6245f673.rusty@rustcorp.com.au>
In-Reply-To: <20020811.222124.60543063.davem@redhat.com>
References: <20020812000347.A99CE2C185@lists.samba.org>
	<20020811.222124.60543063.davem@redhat.com>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Aug 2002 22:21:24 -0700 (PDT)
"David S. Miller" <davem@redhat.com> wrote:

>    From: Rusty Russell <rusty@rustcorp.com.au>
>    Date: Mon, 12 Aug 2002 14:42:51 +1000
> 
>    This changes bitmap_member to the more logical DECLARE_BITMAP, then
>    uses it for cpu_online_map (ie. cpu_online_map is now an unsigned long
>    array).
>    
>    Compiles and boots: Dave, how's this?
> 
> I'm ok with this for now.
> 
> I suspect that once you start using NR_CPUS in the range of 1024 or so
> you want to allow the port do things like "use a pointer for cpuset_t
> and NULL means CPU_MASK_ALL"

I thought about that.  Then I thought, "we'll cross that bridge when we
come to it".  It's overdesign at the moment, we'll be able to judge in 2.7.

Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
