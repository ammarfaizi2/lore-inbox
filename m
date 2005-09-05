Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751246AbVIEOqp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbVIEOqp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 10:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbVIEOqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 10:46:45 -0400
Received: from [217.170.8.20] ([217.170.8.20]:3095 "EHLO research.newtrade.nl")
	by vger.kernel.org with ESMTP id S1751246AbVIEOqo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 10:46:44 -0400
From: Duncan Sands <baldrick@free.fr>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Subject: Re: [ATMSAR] Request for review - update #1
Date: Mon, 5 Sep 2005 16:46:37 +0200
User-Agent: KMail/1.8.2
Cc: "Giampaolo Tomassoni" <g.tomassoni@libero.it>,
       linux-kernel@vger.kernel.org, linux-atm-general@lists.sourceforge.net
References: <NBBBIHMOBLOHKCGIMJMDGEHPEKAA.g.tomassoni@libero.it> <200509041720.55588.s0348365@sms.ed.ac.uk>
In-Reply-To: <200509041720.55588.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509051646.37653.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alistair,

> Just out of curiosity, is there ANY reason why this has to be done in the 
> kernel? The PPPoATM module for pppd implements (via linux-atm) a completely 
> userspace ATM decoder.. if anything, now redundant ATM stack code should be 
> REMOVED from Linux!

the main advantage of the kernel module is that it is integrated into the
kernel's ATM layer.  That means that you can use all those great features
the ATM layer provides to do more with your modem.  This doesn't matter for
most people: they have a PPPoA or PPPoE connection and aren't looking to do
clever tricks; the user mode driver is fine for them.  But it is not enough
for everyone.  For example, my ISP uses "routed IP", which is not supported
by the user mode driver, but works fine with the kernel driver thanks to the
ATM layer.

All the best,

Duncan.

PS: linux-atm and the pppoatm module are used with the kernel driver;
presumably you meant pppoa2 or pppoa3.
