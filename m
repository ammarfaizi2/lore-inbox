Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261465AbULXXz3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261465AbULXXz3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Dec 2004 18:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261466AbULXXz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Dec 2004 18:55:29 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:32990
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261465AbULXXzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Dec 2004 18:55:24 -0500
Date: Fri, 24 Dec 2004 15:55:08 -0800
From: "David S. Miller" <davem@davemloft.net>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: andrea@suse.de, linux-kernel@vger.kernel.org, tglx@linutronix.de,
       akpm@osdl.org
Subject: Re: VM fixes [4/4]
Message-Id: <20041224155508.65783793.davem@davemloft.net>
In-Reply-To: <20041224212513.GV771@holomorphy.com>
References: <20041224174156.GE13747@dualathlon.random>
	<20041224100147.32ad4268.davem@davemloft.net>
	<20041224182219.GH13747@dualathlon.random>
	<20041224125504.4caa4270.davem@davemloft.net>
	<20041224212513.GV771@holomorphy.com>
X-Mailer: Sylpheed version 1.0.0beta3 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Dec 2004 13:25:13 -0800
William Lee Irwin III <wli@holomorphy.com> wrote:

> On Fri, 24 Dec 2004 19:22:19 +0100 Andrea Arcangeli <andrea@suse.de> wrote:
> >> If those old cpus really supported smp in linux, then fixing this bit is
> >> trivial, just change it to short. Do they support short at least?
> 
> On Fri, Dec 24, 2004 at 12:55:04PM -0800, David S. Miller wrote:
> > No, they do not.  The smallest atomic unit is one 32-bit word.
> > And yes there are SMP systems using these chips.
> 
> Would systems described as ev56 by /proc/cpuinfo have such chips?

No.  ev4 and earlier have the word or larger load/store limitation.
Only ev5 and later have byte and half-word sized load/store support.

I didn't actually know this when I read your question, so I snooped
around the asm-alpha/ headers and found the comments around the
__alpha_bwx__ ifdef checks. :-)
