Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263290AbTLXEXU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 23:23:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263298AbTLXEXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 23:23:20 -0500
Received: from fw.osdl.org ([65.172.181.6]:39642 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263290AbTLXEXT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 23:23:19 -0500
Date: Tue, 23 Dec 2003 20:23:05 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: dilinger@voxel.net, linux-kernel@vger.kernel.org,
       Matt Mackall <mpm@selenic.com>, george anzinger <george@mvista.com>
Subject: Re: [PATCH 5/7] more CardServices() removals (drivers/net/wireless)
Message-Id: <20031223202305.489c409f.akpm@osdl.org>
In-Reply-To: <3FE9022A.7010604@pobox.com>
References: <1072229780.5300.69.camel@spiral.internal>
	<20031223182817.0bd3dd3c.akpm@osdl.org>
	<3FE8FC2E.3080701@pobox.com>
	<20031223184827.4cfb87e2.akpm@osdl.org>
	<3FE9022A.7010604@pobox.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
> Patch:
>  http://www.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.6/2.6.0-netdrvr-exp1.patch.bz2

Thanks, I mmified that.  It let me drop a shower of other stuff, which is
always welcome.  Please send in new versions as-and-when needed.

I dropped all of kgdboe:

	kgdb-over-ethernet.patch
	kgdb-over-ethernet-fixes.patch
	kgdb-CONFIG_NET_POLL_CONTROLLER.patch
	kgdb-handle-stopped-NICs.patch
	eepro100-poll-controller.patch
	tlan-poll_controller.patch
	tulip-poll_controller.patch
	tg3-poll_controller.patch
	8139too-poll_controller.patch
	kgdb-eth-smp-fix.patch
	kgdb-eth-reattach.patch
	kgdb-skb_reserve-fix.patch

Matt, would you be able to take a look at resurrecting kgdboe based on the
netpoll infrastructure sometime please?

George, I'm sorely tempted to fold all of these:

	kgdb-buff-too-big.patch
	kgdb-warning-fix.patch
	kgdb-build-fix.patch
	kgdb-spinlock-fix.patch
	kgdb-fix-debug-info.patch
	kgdb-cpumask_t.patch
	kgdb-x86_64-fixes.patch

into the base kgdb patch.   Beware ;)

