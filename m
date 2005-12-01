Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932446AbVLAUZ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932446AbVLAUZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 15:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932439AbVLAUZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 15:25:56 -0500
Received: from smtp.osdl.org ([65.172.181.4]:41909 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932446AbVLAUZ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 15:25:56 -0500
Date: Thu, 1 Dec 2005 12:24:55 -0800
From: Andrew Morton <akpm@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: ray-gmail@madrabbit.org, zippel@linux-m68k.org, mrmacman_g4@mac.com,
       tglx@linutronix.de, linux-kernel@vger.kernel.org, mingo@elte.hu,
       george@mvista.com, johnstul@us.ibm.com
Subject: Re: [patch 00/43] ktimer reworked
Message-Id: <20051201122455.4546d1da.akpm@osdl.org>
In-Reply-To: <20051201165144.GC31551@flint.arm.linux.org.uk>
References: <1133395019.32542.443.camel@tglx.tec.linutronix.de>
	<Pine.LNX.4.61.0512010118200.1609@scrub.home>
	<23CA09D3-4C11-4A4B-A5C6-3C38FA9C203D@mac.com>
	<Pine.LNX.4.61.0512011352590.1609@scrub.home>
	<2c0942db0512010822x1ae20622obf224ce9728e83f8@mail.gmail.com>
	<20051201165144.GC31551@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> wrote:
>
> rmk, also a native English speaker, agrees with Ray, Thomas and Ingo.
>  As does dictionary.reference.com's definitions of timeout and timer:
> 
>   timeout
> 
>    A period of time after which an error condition is raised if some event
>    has not occured. A common example is sending a message. If the receiver
>    does not acknowledge the message within some preset timeout period, a
>    transmission error is assumed to have occured.
> 
>   timer
> 
>    a timepiece that measures a time interval and signals its end
> 
>  Hence, timers have the implication that they are _expected_ to expire.
>  Timeouts have the implication that their expiry is an exceptional
>  condition.

Well timer_lists get around the problem quite neatly by handling both
situations.  In a way which has been learned by thousands of developers
over many years.

The whole concept of separating "timers" from "timeouts" seems a step
backward to me.  A large one.   Why was it done, and can it be undone?
