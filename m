Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262050AbVAOAWe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbVAOAWe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 19:22:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262052AbVAOAWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 19:22:33 -0500
Received: from fw.osdl.org ([65.172.181.6]:49623 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262050AbVAOAWR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 19:22:17 -0500
Date: Fri, 14 Jan 2005 16:26:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: tglx@linutronix.de
Cc: karim@opersys.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc1-mm1
Message-Id: <20050114162652.73283f2e.akpm@osdl.org>
In-Reply-To: <1105747280.13265.72.camel@tglx.tec.linutronix.de>
References: <20050114002352.5a038710.akpm@osdl.org>
	<1105740276.8604.83.camel@tglx.tec.linutronix.de>
	<41E85123.7080005@opersys.com>
	<1105747280.13265.72.camel@tglx.tec.linutronix.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> wrote:
>
> ...
> I'm impressed of your sudden time constraints awareness. Allowing 8192
> bytes of user event size, string printing with varags and XML tracing
> is not biting you ? 

?  I see no XML in there.

akpm:/usr/src/25> grep -i xml patches/ltt* patches/relayfs*
patches/ltt-core-headers.patch:+#define LTT_CUSTOM_EV_FORMAT_TYPE_XML   3
akpm:/usr/src/25> 

> 
> Haha. If you have eventstamps and timestamps (even the jiffie + event
> based ones) nothing is hard to interpret. I guess the ethereal guys are
> rolling on the floor and laughing. 
> 
> The kernel is not the place to fix your postprocessing problems. Sure
> you have to do more complicated stuff, but you move the burden from
> kernel to a place where it does not hurt.

I thought Karim said that this was a form of data compression.

> 
> Yes, the "you would anyway have to go down the same path we have"
> argument really scares me away from doing so. 
> 
> I don't buy this kind of arguments. 

I do.  When someone has been working on a real-world project for several
years we *need* to understand all the problems which that person
encountered before we can competently review the implementation.  Surely
you've been there before: you throw out all the old stuff, write a new one
and once you've addressed all the warts and corner cases and
weird-but-valid requirements it ends up with the same complexity as the
original.
