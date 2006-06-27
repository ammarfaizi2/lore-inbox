Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751302AbWF0JM6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbWF0JM6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 05:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbWF0JM6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 05:12:58 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:18833
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751302AbWF0JM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 05:12:57 -0400
Date: Tue, 27 Jun 2006 02:12:12 -0700 (PDT)
Message-Id: <20060627.021212.92582530.davem@davemloft.net>
To: rdunlap@xenotime.net
Cc: vonbrand@inf.utfsm.cl, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17 du jour on SPARC64: Build failure
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060626182205.ba9392d2.rdunlap@xenotime.net>
References: <200606270041.k5R0fZqd008665@laptop11.inf.utfsm.cl>
	<20060626182205.ba9392d2.rdunlap@xenotime.net>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Randy.Dunlap" <rdunlap@xenotime.net>
Date: Mon, 26 Jun 2006 18:22:05 -0700

> CONFIG_PCI is not set.  That's the build problem, although
> I don't see which file #includes it.
> The bad news is that when CONFIG_PCI=n, those functions just do
> 	BUG();
> anyway, so it won't help you much.

No SBUS drivers will use dma_*() anyways, so it's not matter.  The
file should still build properly when CONFIG_PCI=n, and that's what
I'll fix.
