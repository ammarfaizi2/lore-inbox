Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319001AbSHFFp0>; Tue, 6 Aug 2002 01:45:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319002AbSHFFp0>; Tue, 6 Aug 2002 01:45:26 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:47634 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S319001AbSHFFpZ>; Tue, 6 Aug 2002 01:45:25 -0400
Date: Mon, 5 Aug 2002 22:48:38 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>,
       <vamsi_krishna@in.ibm.com>
Subject: Re: [PATCH] kprobes for 2.5.30 
In-Reply-To: <20020806035803.23FC54B65@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0208052247380.1171-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 6 Aug 2002, Rusty Russell wrote:
> 
> I am reading from this that we *should* be explicitly disabling
> preemption in interrupt handlers if we rely on the cpu number not
> changing underneath us, even if it's (a) currently unneccessary, and
> (b) arch-specific code.

But do_irq() already does that.

You mean _exception_ handlers. It's definitely not unnecessary. Exceptions 
can very much be preempted.

		Linus

