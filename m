Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275485AbRIZS7M>; Wed, 26 Sep 2001 14:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275489AbRIZS7D>; Wed, 26 Sep 2001 14:59:03 -0400
Received: from smtp.mailbox.co.uk ([195.82.125.32]:53440 "EHLO
	smtp.mailbox.net.uk") by vger.kernel.org with ESMTP
	id <S275485AbRIZS6z>; Wed, 26 Sep 2001 14:58:55 -0400
Date: Wed, 26 Sep 2001 19:59:21 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Norbert Roos <n.roos@berlin.de>, linux-kernel@vger.kernel.org
Subject: Re: System hangs during interruptible_sleep_on_timeout() under 2.4.9
Message-ID: <20010926195921.B3664@flint.arm.linux.org.uk>
In-Reply-To: <3BB20949.19469C6F@berlin.de> <Pine.LNX.4.33.0109261902350.6377-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0109261902350.6377-100000@localhost.localdomain>; from mingo@elte.hu on Wed, Sep 26, 2001 at 07:05:42PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2001 at 07:05:42PM +0200, Ingo Molnar wrote:
> 	printk("<%d>", irq);
> 
> into arch/i386/kernel/irq.c:do_IRQ(). So you can see what kind of
> interrupt traffic there is while the device initializes and you are
> waiting for it to generate an interrupt.

Hmm, isn't <0>, <1> etc used to encode the printk level in the string
though?

#define KERN_EMERG      "<0>"   /* system is unusable                   */
#define KERN_ALERT      "<1>"   /* action must be taken immediately     */
#define KERN_CRIT       "<2>"   /* critical conditions                  */
... etc ...

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

