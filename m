Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262249AbVAOJ5U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262249AbVAOJ5U (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 04:57:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262251AbVAOJ5U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 04:57:20 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:8341
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S262249AbVAOJ5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 04:57:14 -0500
Subject: Re: 2.6.11-rc1-mm1
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: karim@opersys.com
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <41E86E6F.6090004@opersys.com>
References: <20050114002352.5a038710.akpm@osdl.org>
	 <1105740276.8604.83.camel@tglx.tec.linutronix.de>
	 <41E85123.7080005@opersys.com>
	 <1105747280.13265.72.camel@tglx.tec.linutronix.de>
	 <41E86E6F.6090004@opersys.com>
Content-Type: text/plain
Date: Sat, 15 Jan 2005 10:57:12 +0100
Message-Id: <1105783032.13265.207.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Karim,

On Fri, 2005-01-14 at 20:14 -0500, Karim Yaghmour wrote:
> Gee Thomas, I guess you really want to take this one until the last
> man is standing. Feel free to use the ad-hominem tone if it suits
> you. Don't hold it against me though if I don't bite :)

No personal offence was intended.

> Thomas Gleixner wrote:
> > It's not only me, who needs constant time. Everybody interested in
> > tracing will need that. In my opinion its a principle of tracing.
> 
> relayfs is a generalized buffering mechanism. Tracing is one application
> it serves. Check out the web site: "high-speed data-relay filesystem."
> Fancy name huh ...

I do not doubt that. 

But hardwiring an instrumentation framework on it is also hardwiring
implicit restrictions on the usability of the instrumentation for
certain purposes.

> > The "lockless" mechanism is _FAKE_ as I already pointed out. It replaces
> > locks by do { } while loops. So what ?
> 
> Well for one thing, a portion of code running in user-context won't
> disable interrupts while it's attempting to get buffer space, and
> therefore won't impact on interrupt delivery.

The do {} while loops are in the fast ltt_log_event path

> Clearly you haven't read the implementation and/or aren't familiar with
> its use. Usually, what you want to do is open(), mmap(), write(), there
> is no "conversion" to a file. The filesystem abstraction is just a
> namespace holder for us.

I have read it and tried it. I don't see a point why I can't map a
ringbuffer into user space. 
I'm not beating on the ringbuffer, but I'm using it as an example. :)

> That's not the point. You're bending backwards as far as you can reach
> trying to raise as much mud as you can, but when pressed for actual
> constructive input you hide behind a strawman argument. If you don't
> have anything to say, then stop whining.

I gave constructive criticism along with points, where I just point on
the restrictions and weakness of the implementation.

tglx


