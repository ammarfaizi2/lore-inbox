Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932364AbVLARpA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932364AbVLARpA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 12:45:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932370AbVLARpA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 12:45:00 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:53977 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932364AbVLARo7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 12:44:59 -0500
Date: Thu, 1 Dec 2005 18:44:32 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: ray-gmail@madrabbit.org, Kyle Moffett <mrmacman_g4@mac.com>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, mingo@elte.hu, george@mvista.com, johnstul@us.ibm.com
Subject: Re: [patch 00/43] ktimer reworked
In-Reply-To: <20051201165144.GC31551@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.61.0512011828150.1609@scrub.home>
References: <1133395019.32542.443.camel@tglx.tec.linutronix.de>
 <Pine.LNX.4.61.0512010118200.1609@scrub.home> <23CA09D3-4C11-4A4B-A5C6-3C38FA9C203D@mac.com>
 <Pine.LNX.4.61.0512011352590.1609@scrub.home>
 <2c0942db0512010822x1ae20622obf224ce9728e83f8@mail.gmail.com>
 <20051201165144.GC31551@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 1 Dec 2005, Russell King wrote:

>  timeout
> 
>   A period of time after which an error condition is raised if some event
>   has not occured. A common example is sending a message. If the receiver
>   does not acknowledge the message within some preset timeout period, a
>   transmission error is assumed to have occured.
> 
>  timer
> 
>   a timepiece that measures a time interval and signals its end
> 
> Hence, timers have the implication that they are _expected_ to expire.
> Timeouts have the implication that their expiry is an exceptional
> condition.

IOW a timeout uses a timer to implement an exceptional condition after a 
period of time expires.

> So can we stop rehashing this stupid discussion?

The naming isn't actually my primary concern. I want a precise definition 
of the expected behaviour and usage of the old and new timer system. If I 
had this, it would be far easier to choose a proper name.
E.g. I still don't know why ktimeout should be restricted to raise just 
"error conditions", as the name implies.

bye, Roman
