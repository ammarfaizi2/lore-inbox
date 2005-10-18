Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751022AbVJRQul@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751022AbVJRQul (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 12:50:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751032AbVJRQul
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 12:50:41 -0400
Received: from hera.kernel.org ([140.211.167.34]:24988 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1751010AbVJRQul (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 12:50:41 -0400
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: 2.6.14-rc4-rt6, skge vs. sk98lin
Date: Tue, 18 Oct 2005 09:50:28 -0700
Organization: OSDL
Message-ID: <20051018095028.4b78dbb2@localhost.localdomain>
References: <1129599910.5031.3.camel@cmn3.stanford.edu>
	<435456A1.6020208@pobox.com>
	<1129600953.5031.6.camel@cmn3.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1129654228 16106 10.8.0.74 (18 Oct 2005 16:50:28 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Tue, 18 Oct 2005 16:50:28 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 1.9.14 (GTK+ 2.6.10; x86_64-redhat-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Oct 2005 19:02:33 -0700
Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:

> On Mon, 2005-10-17 at 21:57 -0400, Jeff Garzik wrote:
> > Fernando Lopez-Lezcano wrote:
> > > I'm running 2.6.14-rc4-rt6 and trying the skge driver instead of the
> > > sk98lin and I'm getting these warnings in my logs (this is probably not
> > > related to the rt patch):
> > > 
> > >   network driver disabled interrupts: skge_xmit_frame+0x0/0x320 [skge]
> > > 
> > > No other relevant messages around that I can see. Is this a bug? Any
> > > information I could supply to help debug it?
> > 
> > This is a bogus message added by the -rt patch.  It is not a bug.
> > 
> > The trylock scheme in some newer net drivers (grep for NETDEV_TX_LOCKED) 
> > uses local_irq_save/restore because there is no 
> > spin_trylock_irqsave/spin_trylock_failed_irqrestore API.
> 
> Would it have any undesirable effect to find this and comment it out?
> There are quite a few messages in the logs. Knowing it is not a bug I
> may try the driver a bit more (I rebooted into sk98lin just in case ;-)
> 
> Thanks for the info. 
> -- Fernando

Or get the -rt folks to come with a better way.

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


-- 
Stephen Hemminger <shemminger@osdl.org>
OSDL http://developer.osdl.org/~shemminger
