Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270367AbTG1Ri3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 13:38:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270370AbTG1Ri3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 13:38:29 -0400
Received: from ns.suse.de ([213.95.15.193]:5131 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S270367AbTG1Ri2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 13:38:28 -0400
Date: Mon, 28 Jul 2003 19:53:42 +0200
From: Andi Kleen <ak@suse.de>
To: Ville Herva <vherva@niksula.hut.fi>
Cc: marcelo@conectiva.com.br, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NMI watchdog documentation
Message-Id: <20030728195342.02913727.ak@suse.de>
In-Reply-To: <20030723174325.GL150921@niksula.cs.hut.fi>
References: <20030723174325.GL150921@niksula.cs.hut.fi>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jul 2003 20:43:25 +0300
Ville Herva <vherva@niksula.hut.fi> wrote:

> Documentation/nmi-watchdoc.txt doesn't actually tell what options need to be
> enabled in kernel config in order to use NMI watchdog. I for one found it
> confusing.
> 
> I vaguely recall someone posted a similar patch some time ago, but it still
> doesn't seem to be present in 2.4 or 2.6-test.
> 
> Andi: what about x86-64 - does it have something similar that should be
> mentioned?

x86-64 is the same, except APIC is always compiled in and the nmi watchdog is
always enabled with perfctr mode. mode=2 seems to also not work correctly currently.

However one caveat (even for i386): when you use perfctr mode 1 you lose the first
performance register which you may need for other things.

-Andi

