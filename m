Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261447AbULXUzV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261447AbULXUzV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Dec 2004 15:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261449AbULXUzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Dec 2004 15:55:21 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:23005
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261447AbULXUzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Dec 2004 15:55:17 -0500
Date: Fri, 24 Dec 2004 12:55:04 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, akpm@osdl.org
Subject: Re: VM fixes [4/4]
Message-Id: <20041224125504.4caa4270.davem@davemloft.net>
In-Reply-To: <20041224182219.GH13747@dualathlon.random>
References: <20041224174156.GE13747@dualathlon.random>
	<20041224100147.32ad4268.davem@davemloft.net>
	<20041224182219.GH13747@dualathlon.random>
X-Mailer: Sylpheed version 1.0.0beta3 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Dec 2004 19:22:19 +0100
Andrea Arcangeli <andrea@suse.de> wrote:

> On Fri, Dec 24, 2004 at 10:01:47AM -0800, David S. Miller wrote:
> > On Fri, 24 Dec 2004 18:41:56 +0100
> > Andrea Arcangeli <andrea@suse.de> wrote:
> > 
> > > + * All archs should support atomic ops with
> > > + * 1 byte granularity.
> > > + */
> > > +	unsigned char memdie;
> > 
> > Again, older Alpha's do not.
> 
> If those old cpus really supported smp in linux, then fixing this bit is
> trivial, just change it to short. Do they support short at least?

No, they do not.  The smallest atomic unit is one 32-bit word.
And yes there are SMP systems using these chips.
