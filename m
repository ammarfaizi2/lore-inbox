Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264639AbUIWT6i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264639AbUIWT6i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 15:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263117AbUIWT6h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 15:58:37 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:2201
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S264639AbUIWT6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 15:58:20 -0400
Date: Thu, 23 Sep 2004 12:57:08 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Albert Cahalan <albert@users.sf.net>
Cc: cfriesen@nortelnetworks.com, albert@users.sourceforge.net,
       linux-kernel@vger.kernel.org, ak@muc.de, gandalf@wlug.westbo.se
Subject: Re: [PATCH] Warn people that ipchains and ipfwadm are going away.
Message-Id: <20040923125708.770d5922.davem@davemloft.net>
In-Reply-To: <1095968193.4969.980.camel@cube>
References: <1095962839.4974.965.camel@cube>
	<41532504.3000005@nortelnetworks.com>
	<1095968193.4969.980.camel@cube>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Sep 2004 15:36:34 -0400
Albert Cahalan <albert@users.sf.net> wrote:

> I'm still not seeing a need to run an x86-64 kernel
> with an i386 iptables.

Me neither.  And it's not like the netfilter tools have
any interesting library dependencies either, ldd on
iptables for example is merely:

        libdl.so.2 => /lib/ultra3/libdl.so.2 (0x7002c000)
        libnsl.so.1 => /lib/ultra3/libnsl.so.1 (0x70040000)
        libc.so.6 => /lib/ultra3/libc.so.6 (0x70068000)
        /lib/ld-linux.so.2 => /lib/ld-linux.so.2 (0x70000000)

And that's just libc.

If Andi would code on kernel bug fixes for these problems
as much as he complained about them, he wouldn't have anything
to complain about :-)

I would like to see a netfilter compat layer translater engine
of some sort, none the less.  With the right design it won't
be hard to implement things properly.

