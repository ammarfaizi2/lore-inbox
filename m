Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932365AbVJRCCZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932365AbVJRCCZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 22:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbVJRCCZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 22:02:25 -0400
Received: from smtp3.Stanford.EDU ([171.67.16.138]:42941 "EHLO
	smtp3.Stanford.EDU") by vger.kernel.org with ESMTP id S932365AbVJRCCY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 22:02:24 -0400
Subject: Re: 2.6.14-rc4-rt6, skge vs. sk98lin
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: nando@ccrma.Stanford.EDU, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <435456A1.6020208@pobox.com>
References: <1129599910.5031.3.camel@cmn3.stanford.edu>
	 <435456A1.6020208@pobox.com>
Content-Type: text/plain
Date: Mon, 17 Oct 2005 19:02:33 -0700
Message-Id: <1129600953.5031.6.camel@cmn3.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-10-17 at 21:57 -0400, Jeff Garzik wrote:
> Fernando Lopez-Lezcano wrote:
> > I'm running 2.6.14-rc4-rt6 and trying the skge driver instead of the
> > sk98lin and I'm getting these warnings in my logs (this is probably not
> > related to the rt patch):
> > 
> >   network driver disabled interrupts: skge_xmit_frame+0x0/0x320 [skge]
> > 
> > No other relevant messages around that I can see. Is this a bug? Any
> > information I could supply to help debug it?
> 
> This is a bogus message added by the -rt patch.  It is not a bug.
> 
> The trylock scheme in some newer net drivers (grep for NETDEV_TX_LOCKED) 
> uses local_irq_save/restore because there is no 
> spin_trylock_irqsave/spin_trylock_failed_irqrestore API.

Would it have any undesirable effect to find this and comment it out?
There are quite a few messages in the logs. Knowing it is not a bug I
may try the driver a bit more (I rebooted into sk98lin just in case ;-)

Thanks for the info. 
-- Fernando


