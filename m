Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263493AbTC2TeM>; Sat, 29 Mar 2003 14:34:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263494AbTC2TeM>; Sat, 29 Mar 2003 14:34:12 -0500
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:15243 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S263493AbTC2TeM>; Sat, 29 Mar 2003 14:34:12 -0500
Subject: Re: 3c59x gives HWaddr FF:FF:...
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Thomas Backlund <tmb@iki.fi>
Cc: "J.A. Magallon" <jamagallon@able.es>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <0d0001c2f616$6a678dc0$9b1810ac@xpgf4>
References: <20030328145159.GA4265@werewolf.able.es>
	 <20030328124832.44243f83.akpm@digeo.com>
	 <20030328230510.GA5124@werewolf.able.es>
	 <20030328151624.67a3c8c5.akpm@digeo.com>
	 <20030329004630.GA2480@werewolf.able.es>
	 <0d0001c2f616$6a678dc0$9b1810ac@xpgf4>
Content-Type: text/plain
Organization: 
Message-Id: <1048967121.600.7.camel@teapot>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 (1.2.3-1) 
Date: 29 Mar 2003 20:45:22 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-03-29 at 18:12, Thomas Backlund wrote:
> Since you have MDK 9.1, could you try the 3rdparty/3c90x module from
> mdk kernel-source and see if it works...
> It is 3Com's own driver... that is supposed to work with that card...
> 
> If it won't work, maybe it's the card that is broken... messed up...
> If it works, the bug is in the 3c59x module...

I think it's a bug with 3c59x.c or the PCI resource allocation code in
2.4 kernels, since my 3CCFE575CT 10/100 CardBus adapter works fine with
2.5 kernels, but when running on vanilla 2.4.20, I get a
FF:FF:FF:FF:FF:FF MAC address.

Curiously, instead of using 2.4.20 built-in yenta socket, cs and 3c59x.c
driver, if I revert to running SourceForge's pcmcia-cs, the card works
flawlessly. Also, it seems that Alan Cox patches for 2.4 (part of which
are included in Red Hat's kernels) solve the problem with my card.

________________________________________________________________________
        Felipe Alfaro Solana
   Linux Registered User #287198
http://counter.li.org

