Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932301AbVIEPEv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932301AbVIEPEv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 11:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932304AbVIEPEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 11:04:51 -0400
Received: from [217.170.8.20] ([217.170.8.20]:21271 "EHLO research.newtrade.nl")
	by vger.kernel.org with ESMTP id S932301AbVIEPEv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 11:04:51 -0400
From: Duncan Sands <baldrick@free.fr>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Subject: Re: [ATMSAR] Request for review - update #1
Date: Mon, 5 Sep 2005 17:04:44 +0200
User-Agent: KMail/1.8.2
Cc: Grzegorz Kulewski <kangur@polcom.net>,
       Giampaolo Tomassoni <g.tomassoni@libero.it>,
       linux-kernel@vger.kernel.org, linux-atm-general@lists.sourceforge.net
References: <NBBBIHMOBLOHKCGIMJMDGEHPEKAA.g.tomassoni@libero.it> <Pine.LNX.4.63.0509041830270.29195@alpha.polcom.net> <200509041754.54995.s0348365@sms.ed.ac.uk>
In-Reply-To: <200509041754.54995.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509051704.44315.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alistair,

> > The instalation is currently (with firmware loader instead of modem_run)
> > very simple: USE="atm" emerge ppp, download firmware and place it in
> > /lib/firmware, compile the kernel with speedtch support.
> 
> Compared to "place the firmware in /lib/firmware" on many other distros, this 
> sounds like a lot of work! The kernel speedtch provides no advantages to its 
> userspace alternative.

historically the main problem with using the kernel driver was getting hold of
an ATM aware pppd.  The step "USE="atm" emerge ppp" looks like gentoos way of
installing such a pppd.  Nowadays several major distributions ship with an
ATM aware pppd, so if you are using one there is nothing to be done.  Likewise,
most distributions ship a kernel with speedtch support.  So if you're using
such a distribution all you have to do to use the kernel driver is
"place the firmware in /lib/firmware".

On the other hand, it is misleading to say that with the user mode driver
all you have to do is place the firmware in /lib/firmware.  That's only
true if your distribution (eg: Mandrake) explicitly supports the user mode
driver and has pre-installed and configured it for you.  If you don't have
such a distribution then setting up the user mode driver, while not difficult,
does require some work.

> > I tried to use userspace driver some time ago but it wasn't working for me
> > so I gave up. I was using modem_run with kernel driver for long time to
> > load the firmware but there were many problems with it too (nearly every
> > kernel or modem_run upgrade was breaking something, modem_run was hanging
> > in D state in most unapropriate moments and so on).
> 
> This is not the case any longer.

I'm the one who fixed most of those problems by the way.

> > Now I am using pure kernel driver and firmware loader and it works 100%
> > ok. There were no problems with it for long time. And I don't even want to
> > look at this userspace driver again.
> 
> Conversely people (including myself) found the kernel implementation to be 
> buggy, and when userspace breaks, you can simply restart it.. when the kernel 
> breaks, you have to reboot.

Tell me what problems you've been seeing and I will try to fix them.

All the best,

Duncan.
