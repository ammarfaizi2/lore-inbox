Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751027AbWI1XZ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbWI1XZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 19:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750849AbWI1XZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 19:25:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:56710 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750834AbWI1XZz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 19:25:55 -0400
Date: Thu, 28 Sep 2006 16:25:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: oe@hentges.net, Stephen Hemminger <shemminger@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Netdev List <netdev@vger.kernel.org>
Subject: Re: sky2 (was Re: 2.6.18-mm2)
Message-Id: <20060928162539.7d565d0a.akpm@osdl.org>
In-Reply-To: <451C5599.80402@garzik.org>
References: <20060928155053.7d8567ae.akpm@osdl.org>
	<451C5599.80402@garzik.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Sep 2006 19:07:05 -0400
Jeff Garzik <jeff@garzik.org> wrote:

> Andrew Morton wrote:
> > Another customer..
> > 
> > Begin forwarded message:
> > 
> > Date: Fri, 29 Sep 2006 00:44:01 +0200
> > From: Matthias Hentges <oe@hentges.net>
> > To: Andrew Morton <akpm@osdl.org>
> > Cc: linux-kernel@vger.kernel.org
> > Subject: Re: 2.6.18-mm2
> > 
> > 
> > Hello all,
> > 
> > I've just tested -mm2 on my C2D system and I'm getting a lot of these
> > messages:
> > 
> > "[  139.143807] printk: 131 messages suppressed.
> > [  139.148235] sky2 0000:03:00.0: pci express error (0x500547)"
> > 
> > Please note that the "sky2" driver has always been the black sheep on
> > that system due to regular full lock-ups of the driver, requiring a
> > rmmod sky2 + modprobe sky2 cycle.
> > 
> > This happens often enough to warrant writing a cronjob checking the
> > network and auto-rmmod'ing the module.....
> > 
> > While the above is bloody annoying at times (heh), the driver never
> > caused any messages like the ones I now get with -mm2 .
> 
> sky2 just turned on PCI Express error reporting, so it makes sense that 
> messages would appear.  The better question is whether this is a driver 
> problem, or a hardware problem.  With your "black sheep" comment, I 
> wonder if it isn't a hardware problem that's been hidden.
> 

See also http://bugzilla.kernel.org/show_bug.cgi?id=7222

That's two reports in 18 hours, from amongst the presumably-small population
of sky2-owning -mm testers.
