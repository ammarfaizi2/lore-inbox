Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266618AbUBQUIl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 15:08:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266622AbUBQUIk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 15:08:40 -0500
Received: from mx1.redhat.com ([66.187.233.31]:35813 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266618AbUBQUIe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 15:08:34 -0500
Date: Tue, 17 Feb 2004 12:08:28 -0800
From: "David S. Miller" <davem@redhat.com>
To: Martin Hicks <mort@wildopensource.com>
Cc: manfred@colorfullife.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Reduce TLB flushing during process migration
Message-Id: <20040217120828.37d810d4.davem@redhat.com>
In-Reply-To: <20040217200558.GO12142@localhost>
References: <40323FB6.1030208@colorfullife.com>
	<20040217100852.2eb50c4b.davem@redhat.com>
	<20040217200558.GO12142@localhost>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Feb 2004 15:05:58 -0500
Martin Hicks <mort@wildopensource.com> wrote:

> Here's an updated patch that creates the new wrapper.  I only changed
> ia64 to call flush_tlb_mm() because I'm a little wary about assuming
> that all non-x86 arches want this.

Please use "do { } while (0)" for the NOP define of the macro else
we'll end up with empty-statement warnings from the compiler.
