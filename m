Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318294AbSHEEVE>; Mon, 5 Aug 2002 00:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318295AbSHEEVE>; Mon, 5 Aug 2002 00:21:04 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:61446 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318294AbSHEEVE>; Mon, 5 Aug 2002 00:21:04 -0400
Date: Sun, 4 Aug 2002 21:24:32 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>,
       <vamsi_krishna@in.ibm.com>
Subject: Re: [PATCH] kprobes for 2.5.30 
In-Reply-To: <20020805041904.783374450@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0208042118290.2754-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 5 Aug 2002, Rusty Russell wrote:
> 
> Done.  Look better?

How about one more cleanup: make the x86 do_int3()/do_debug() calling
convention be independent of CONFIG_KPROBE? 

Btw, the way to test against zero in x86 asm is not

	cmpl $0,%eax

but rather the shorter

	testl %eax,%eax

which just shows that the person who wrote the asm probably was used to
saner CPUs ;)

		Linus

