Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266324AbUHOHrN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266324AbUHOHrN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 03:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266531AbUHOHrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 03:47:13 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:60875 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S266324AbUHOHrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 03:47:12 -0400
Date: Sun, 15 Aug 2004 03:51:10 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] smp_call_function WARN_ON
In-Reply-To: <411F08D1.7060400@colorfullife.com>
Message-ID: <Pine.LNX.4.58.0408150337170.22078@montezuma.fsmlabs.com>
References: <411F08D1.7060400@colorfullife.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Aug 2004, Manfred Spraul wrote:

> Wrong: At least on i386 the code always waits for delivery of the IPI,
> it just doesn't wait for completion of the callback.
> Do you need IPIs from irq or bh context? It would be tricky to change
> the current code: an IPI just delivers an interrupt without any payload.
> The global 'call_data' variable contains the description of the IPI and
> accesses to it must be synchronized.

Oops yes you're right, i'd have to setup a seperate vector to be able to
do it without the wait entirely. Sorry about the noise.

Thanks,
	Zwane

