Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290772AbSBLFex>; Tue, 12 Feb 2002 00:34:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290782AbSBLFeo>; Tue, 12 Feb 2002 00:34:44 -0500
Received: from pizda.ninka.net ([216.101.162.242]:5513 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S290772AbSBLFef>;
	Tue, 12 Feb 2002 00:34:35 -0500
Date: Mon, 11 Feb 2002 21:32:48 -0800 (PST)
Message-Id: <20020211.213248.48398226.davem@redhat.com>
To: rth@twiddle.net
Cc: davidm@hpl.hp.com, anton@samba.org, linux-kernel@vger.kernel.org,
        zippel@linux-m68k.org
Subject: Re: thread_info implementation
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020211212644.A20387@twiddle.net>
In-Reply-To: <20020211.192334.123921982.davem@redhat.com>
	<15464.36074.246502.582895@napali.hpl.hp.com>
	<20020211212644.A20387@twiddle.net>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Richard Henderson <rth@twiddle.net>
   Date: Mon, 11 Feb 2002 21:26:44 -0800
   
   On another topic, I'm considering having $8 continue to be current
   and using the two-insn stack mask to get current_thread_info and
   measuring the size difference that makes.

I might put 'current' into %g7 on sparc but currently I don't think
it's worth it myself.

BTW, your "4 issue" comments assume the cpu can do 4 non-FPU
instructions per cycle, most I am aware of cannot and I think ia64
even falls into the "cannot" category.  Doesn't it?

