Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbUCNUwL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 15:52:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbUCNUwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 15:52:11 -0500
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:10951 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S261603AbUCNUwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 15:52:08 -0500
Date: Sun, 14 Mar 2004 15:52:09 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Joerg Sommrey <jo@sommrey.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NMI watchdog in 2.6.3-mm4/2.6.4-mm1
In-Reply-To: <20040314161233.GA2955@sommrey.de>
Message-ID: <Pine.LNX.4.58.0403141545330.28447@montezuma.fsmlabs.com>
References: <200403141212.i2ECC5vo008463@harpo.it.uu.se> <20040314161233.GA2955@sommrey.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Mar 2004, Joerg Sommrey wrote:

> > >With 2.6.4-mm1 the NMI watchdog is again not functional in my box. Any
> > >ideas?

I think all we did was drop the NMI frequency in -mm1, but that would be
for nmi_watchdog=2

> nmi_watchdog=2 has never worked for me. Is this really supposed to work
> on a SMP machine? In that case there isn't even a message
> about activating the watchdog, but I get a nmi-count in /proc/interrupts.

It is activated, it's just not verbal about it, nmi_watchdog=1 is more
verbose because there are a number of interrupt delivery modes we try
before giving up.

> I almost gave up, until I found the watchdog working in 2.6.3-mm4.
> See attached files for further information.

I think the pending problem then is nmi_watchdog=1 working erratically.
Does 2.6.3 work for you?
