Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932316AbVJQQ0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316AbVJQQ0M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 12:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932317AbVJQQ0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 12:26:12 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:34721 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932316AbVJQQ0L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 12:26:11 -0400
Date: Mon, 17 Oct 2005 18:25:25 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>
cc: Ingo Molnar <mingo@elte.hu>, tglx@linutronix.de, george@mvista.com,
       linux-kernel@vger.kernel.org, johnstul@us.ibm.com, paulmck@us.ibm.com,
       hch@infradead.org, oleg@tv-sign.ru, tim.bird@am.sony.com
Subject: Re: [PATCH]  ktimers subsystem 2.6.14-rc2-kt5
In-Reply-To: <20051017025657.0d2d09cc.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0510171511010.1386@scrub.home>
References: <1128168344.15115.496.camel@tglx.tec.linutronix.de>
 <Pine.LNX.4.61.0510100213480.3728@scrub.home> <1129016558.1728.285.camel@tglx.tec.linutronix.de>
 <Pine.LNX.4.61.0510130004330.3728@scrub.home> <434DA06C.7050801@mvista.com>
 <Pine.LNX.4.61.0510150143500.1386@scrub.home> <1129490809.1728.874.camel@tglx.tec.linutronix.de>
 <Pine.LNX.4.61.0510170021050.1386@scrub.home> <20051017075917.GA4827@elte.hu>
 <Pine.LNX.4.61.0510171054430.1386@scrub.home> <20051017094153.GA9091@elte.hu>
 <20051017025657.0d2d09cc.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 17 Oct 2005, Andrew Morton wrote:

> That being said, I'll confess that I've largely ignored this discussion in
> the hope that things would get sorted out.  Seems that this won't be
> happening and as Roman's opinions carry weight I do intend to solicit a
> (brief!) summary of his objections from him when the patch comes round
> again.  Sorry.

It's rather simple:
- "timer API" vs "timeout API": I got absolutely no acknowlegement that 
this might be a little confusing and in consequence "process timer" may be 
a better name.
- I pointed out various (IMO) unnecessary complexities, which were rather 
quickly brushed off e.g. with a need for further (not closer specified) 
cleanups.
- resolution handling: at what resolution should/does the kernel work and 
what do we report to user space. The spec allows multiple interpretations 
and I have a hard time to get at least one coherent interpretation out of 
Thomas.

Maybe I'm the only one who found Thomas answers a little superficial, but 
as this is a central kernel subsystem I think it deserves a closer look 
and everytime I tried to poke a little deeper I got nothing.

bye, Roman
