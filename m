Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261599AbVECTCb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261599AbVECTCb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 15:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261601AbVECTCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 15:02:31 -0400
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:9627
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261599AbVECTCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 15:02:21 -0400
Date: Tue, 3 May 2005 11:51:03 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Paul Mackerras <paulus@samba.org>
Cc: jk@blackdown.de, benh@kernel.crashing.org, akpm@osdl.org, oleg@tv-sign.ru,
       linux-kernel@vger.kernel.org, maneesh@in.ibm.com
Subject: Re: [PATCH] fix __mod_timer vs __run_timers deadlock.
Message-Id: <20050503115103.7461ae5e.davem@davemloft.net>
In-Reply-To: <17014.59016.336852.31119@cargo.ozlabs.ibm.com>
References: <42748B75.D6CBF829@tv-sign.ru>
	<20050501023149.6908c573.akpm@osdl.org>
	<87vf61kztb.fsf@blackdown.de>
	<1115079230.6155.35.camel@gaston>
	<873bt5xf9v.fsf@blackdown.de>
	<17014.59016.336852.31119@cargo.ozlabs.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 May 2005 12:48:40 +1000
Paul Mackerras <paulus@samba.org> wrote:

> Juergen Kreileder writes:
> 
> > BTW, xmon doesn't work for me.  'echo x > /proc/sysrq-trigger' gives
> > me a :mon> prompt but I can't enter any commands.
> 
> We don't have polled interrupts-off input methods for USB keyboards.

There is nothing in the USB nor INPUT layers really blocking an
implementation of this BTW.

I need this on Sparc64 as well, so that PROM command line input
works after booting with USB keyboards.
