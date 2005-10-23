Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751149AbVJWKSY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbVJWKSY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 06:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751444AbVJWKSY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 06:18:24 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:61831 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751149AbVJWKSX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 06:18:23 -0400
Date: Sun, 23 Oct 2005 12:18:06 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: maxk@qualcomm.com, bluez-devel@lists.sourceforge.net,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Billionton bluetooth CF card: performance is 10KB/sec
Message-ID: <20051023101806.GD1975@elf.ucw.cz>
References: <20051022173152.GA2573@elf.ucw.cz> <1130059941.11428.81.camel@blade> <20051023094806.GB1975@elf.ucw.cz> <1130062204.11428.86.camel@blade>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1130062204.11428.86.camel@blade>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > so you say that the Nokia 6230 has PAN Profile support and you don't
> > > need any PPP crap to get Internet access? This would be the first phone
> > > I have seen so far.
> > 
> > No, sorry, that was over ppp over rfcomm. With MSI dongle, I get
> > 25KB/sec with n6230. With bluetooth CF card, I only get 10KB/sec.
> 
> show me the "hcitool info ..." for the phone.

Sorry, I do not have it here just now. Should be able to get it in a
few days.

> > > > Netdev watchdog complains a lot:
> > > > 
> > > > Oct 22 18:53:57 amd pand[2439]: Bluetooth PAN daemon version 2.19
> > > > Oct 22 18:53:57 amd pand[2439]: Connecting to <won't tell you>
> > > > Oct 22 18:53:58 amd pand[2439]: bnep0 connected
> > > > Oct 22 18:54:37 amd kernel: usb 3-1: USB disconnect, address 2
> > > > Oct 22 18:55:33 amd kernel: NETDEV WATCHDOG: bnep0: transmit timed out
> > > > Oct 22 18:55:59 amd last message repeated 2 times
> > > > Oct 22 18:56:51 amd last message repeated 5 times
> > > > Oct 22 18:57:55 amd last message repeated 3 times
> > > > Oct 22 18:59:03 amd last message repeated 7 times
> > > 
> > > The transmit timeouts shouldn't be there. The question is now which side
> > > is at fault. The host or the phone?
> > 
> > This is against second linux box... Can't be the phone.
> 
> >From Linux to Linux you can get something around 80KB/sec. Do you have
> any other USB dongle to test this against, because I think the PCMCIA
> card is the problematic part here.

I agree that pcmcia card is problematic. No, I do not have any other
usb dongles, but...

billionton.n6230: 10KB/sec (ppp over rfcomm)
MSI..n6230: 25KB/sec (ppp over rfcomm)
MSI..billionton: 10KB/sec (bnetp)

...pretty much tells the story. I could do some obex transfers against
k700 to test it a bit more.

> If you go over RFCOMM to the phone you will almost never reach the full
> speed, because most RFCOMM implementation on the phones are not really
> good. The PPP is eating the rest of the bandwidth.

Fortunately edge has limit of 25KB/sec or something like that, and
bluetooth has 100KB/sec limit, so it is fast enough even with some
added overhead.
								Pavel
-- 
Thanks, Sharp!
