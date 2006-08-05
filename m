Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422646AbWHEAGP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422646AbWHEAGP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 20:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422649AbWHEAGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 20:06:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:14251 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422646AbWHEAGP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 20:06:15 -0400
Date: Fri, 4 Aug 2006 17:06:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: linux-kernel@vger.kernel.org, support@moxa.com.tw
Subject: Re: [RFC 1/2] Char: mxser, upgrade to 1.9.1
Message-Id: <20060804170608.fdafbc0d.akpm@osdl.org>
In-Reply-To: <44D3DDD7.2010608@gmail.com>
References: <we_have_too_much_work@hehe.blahblah>
	<20060730123150.883d9121.akpm@osdl.org>
	<44D3DDD7.2010608@gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 05 Aug 2006 01:52:32 +0159
Jiri Slaby <jirislaby@gmail.com> wrote:

> Andrew Morton wrote:
> > On Sat, 29 Jul 2006 15:29:43 -0400
> > Jiri Slaby <jirislaby@gmail.com> wrote:
> > 
> >> mxser, upgrade to 1.9.1
> >>
> >> Change driver according to original 1.9.1 moxa driver.
> > 
> > Where did these changes come from?  The Moxa website, perhaps?
> > 
> > Do we know what they do?  Have you been able to test it?
> 
> Ok. Bernard did not test it:
> <cite>
> In fact, due to distro version differences between mine and the one
> installed on my friends linuxbox (I was running Mandriva 2006 with 2.6
> kernel and he had a Knoppix system with 2.4 kernel), I did not had the
> opportunity to check if the new version sent by Moxa support worked
> before he disappeared.
> But I dont see any reason it would not. Moxa guys have all the hardware
> in their development departement to check their product drivers.
> 
> I just verified that 1.9.1 driver source could be compiled under kernel
> 2.6. and so did it.
> </cite>
> 
> So, what do you expect me to do, Andrew? Add just pci_ids + its config with no 
> int->ulong conversion + writing ~UART_IER_THRI to the port?

It's hard.

Perhaps we could merge it and stick a printk in there saying "if you have
the hardware for this driver, please send an email to ...".

Then when we get a few people we ask them "do you want to become an mxser
tester".

Then we add a comment to the driver (or ./TESTERS) recording the names of
the people who have volunteered to test this driver.

So next time this sort of thing happens, we know what to do.

Would such a system work?  Maybe.  Partially.  If it does, it would be
modestly useful.

