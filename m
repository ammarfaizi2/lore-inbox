Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265203AbUGQRf0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265203AbUGQRf0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 13:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266546AbUGQRf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 13:35:26 -0400
Received: from gate.crashing.org ([63.228.1.57]:31633 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265203AbUGQRfM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 13:35:12 -0400
Subject: Re: [PATCH] pmac_zilog: insert correct failure path for device
	numbers being taken
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       eger@havoc.gtf.org, rmk+serial@arm.linux.org.uk
In-Reply-To: <1090026344.1232.412.camel@cube>
References: <1090026344.1232.412.camel@cube>
Content-Type: text/plain
Message-Id: <1090085592.1922.5.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 17 Jul 2004 13:33:13 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-07-16 at 21:05, Albert Cahalan wrote:
> > I'll talk to him at KS/OLS and see if we can come up with
> > some solution, this is actually a regression since 2.4
> > could "offset" macserial, so we could accomodate, for
> > example, a driver for a pcmcia modem _and_ the zilog ports.
> 
> That's the wrong way around. The zilog ports are always
> there, and thus could have stable numbers. The PCMCIA
> ports can not have stable numbers; they might be gone even.

Nice ideal vision ...

> In general, the platform-specific (motherboard, generally)
> ports should get to grab device numbers first. Anthing
> connected by a normally hot-plug bus goes last. Plain PCI
> is in the middle, because PCI cards are occasionally moved.

I'm not talking about the best solution that will make everybody
happy, but at this point in 2.6, whatever will fix the problem, I
doubt russel would accept a patch changing the 8250 driver in any
significant way

> For a PC, serial ports hanging off the motherboard's LPC bus
> (what amounts to built-in ISA) should go before serial ports
> that might be on normal PCI cards, which in turn go before
> those on PCMCIA.
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

