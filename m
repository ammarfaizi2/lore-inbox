Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268269AbUIPXAT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268269AbUIPXAT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 19:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268305AbUIPW7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 18:59:39 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:13773
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S268409AbUIPW5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 18:57:01 -0400
Date: Thu, 16 Sep 2004 15:54:12 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Bill Huey (hui) <bhuey@lnxw.com>
Cc: bhuey@lnxw.com, davidsen@tmr.com, linux-kernel@vger.kernel.org,
       mingo@elte.hu
Subject: Re: [patch] remove the BKL (Big Kernel Lock), this time for real
Message-Id: <20040916155412.47649ba6.davem@davemloft.net>
In-Reply-To: <20040916225102.GA4386@nietzsche.lynx.com>
References: <m3vfefa61l.fsf@averell.firstfloor.org>
	<cic7f9$i4m$1@gatekeeper.tmr.com>
	<20040916222903.GA4089@nietzsche.lynx.com>
	<20040916154011.3f0dbd54.davem@davemloft.net>
	<20040916225102.GA4386@nietzsche.lynx.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Sep 2004 15:51:02 -0700
Bill Huey (hui) <bhuey@lnxw.com> wrote:

> Judging from how the Linux code is done and the numbers I get from
> Bill Irwin in casual conversation, the Linux SMP approach is clearly
> the right track at this time with it's hand honed per-CPU awareness of
> things. The only serious problem that spinlocks have as they aren't
> preemptable, which is what Ingo is trying to fix.

This is what Linus proclaimed 6 or 7 years ago when people were
trying to convince us to do things like Solaris and other big
Unixes at the time.
