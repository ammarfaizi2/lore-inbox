Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275520AbRIZTaC>; Wed, 26 Sep 2001 15:30:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275526AbRIZT3w>; Wed, 26 Sep 2001 15:29:52 -0400
Received: from chiara.elte.hu ([157.181.150.200]:23308 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S275520AbRIZT3j>;
	Wed, 26 Sep 2001 15:29:39 -0400
Date: Wed, 26 Sep 2001 21:27:44 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Norbert Roos <n.roos@berlin.de>, <linux-kernel@vger.kernel.org>
Subject: Re: System hangs during interruptible_sleep_on_timeout() under 2.4.9
In-Reply-To: <20010926195921.B3664@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.33.0109262123110.7740-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 26 Sep 2001, Russell King wrote:

> > 	printk("<%d>", irq);

> Hmm, isn't <0>, <1> etc used to encode the printk level in the string
> though?

yes. the above will still be printed, because there is no newline in the
printk. The first printk (which is very likely <0>), will be interpreted
as KERN_EMERG and will be snipped, the rest of the 'line' will be printed.
(until something printk's a \n, when the whole thing starts again.) But
you are right, it's more consistent and safer to use eg. "(%d)".

	Ingo

