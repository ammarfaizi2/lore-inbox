Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268303AbUIPWnP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268303AbUIPWnP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 18:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268305AbUIPWnP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 18:43:15 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:4813
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S268303AbUIPWnE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 18:43:04 -0400
Date: Thu, 16 Sep 2004 15:40:11 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Bill Huey (hui) <bhuey@lnxw.com>
Cc: davidsen@tmr.com, linux-kernel@vger.kernel.org, mingo@elte.hu,
       bhuey@lnxw.com
Subject: Re: [patch] remove the BKL (Big Kernel Lock), this time for real
Message-Id: <20040916154011.3f0dbd54.davem@davemloft.net>
In-Reply-To: <20040916222903.GA4089@nietzsche.lynx.com>
References: <m3vfefa61l.fsf@averell.firstfloor.org>
	<cic7f9$i4m$1@gatekeeper.tmr.com>
	<20040916222903.GA4089@nietzsche.lynx.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Sep 2004 15:29:03 -0700
Bill Huey (hui) <bhuey@lnxw.com> wrote:

> FreeBSD-current uses adaptive mutexes. However they spin on that mutex
> only if the thread owning it is running across another CPU at that time,
> otherwise it sleeps, maybe priority inherited depending on the
> circumstance.

This is how Solaris MUTEX objects work too.
