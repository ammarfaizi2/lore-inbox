Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263554AbUCYTHZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 14:07:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263565AbUCYTHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 14:07:24 -0500
Received: from mail.shareable.org ([81.29.64.88]:27793 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S263554AbUCYTHT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 14:07:19 -0500
Date: Thu, 25 Mar 2004 19:07:18 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Miquel van Smoorenburg <miquels@cistron.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: arch/i386/Kconfig: CONFIG_IRQBALANCE Description
Message-ID: <20040325190718.GD11236@mail.shareable.org>
References: <1079996577.6595.19.camel@bach> <16480.28882.388997.71072@gargle.gargle.HOWL> <c3qa94$qhi$1@news.cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3qa94$qhi$1@news.cistron.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miquel van Smoorenburg wrote:
> Is that real SMP, or hyperthreading? If it's hyperthreading, then
> it makes sense that the IRQs are not balanced.

That's unfair to the two tasks which might be running on each virtual
CPU: one of the tasks is interrupted often.

> In fact I have a server on which the IRQ balancing code does
> balance over the 2 virtual CPUs by accident (still have to debug
> what goes wrong and file a proper bug report) and as a result
> performance sucked until I turned it off.

What caused the suckage?  Obviously there's a small time spend doing
the work of rebalancing, but there is no cache hit from moving an
interrupt between virtual CPUs, unlike with SMP, so why did that make
performance suck?

-- Jamie
