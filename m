Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267419AbRGYXgU>; Wed, 25 Jul 2001 19:36:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267431AbRGYXgL>; Wed, 25 Jul 2001 19:36:11 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:63240 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267419AbRGYXfz>; Wed, 25 Jul 2001 19:35:55 -0400
Subject: Re: how to tell Linux *not* to share IRQs ?
To: vaxerdec@frontiernet.net (Scott McDermott)
Date: Thu, 26 Jul 2001 00:37:08 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010725192342.A2453@vaxerdec.localdomain> from "Scott McDermott" at Jul 25, 2001 07:23:42 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15PYDE-0002tj-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> I cannot for the life of me get Linux to use all the available IRQs; it
> insists on sharing IRQs even though there are enough available to give
> each PCI device a separate one.

The actual sharing rules for PCI interrupt lines are frequently determined
by the actual wiring on the motherboard. It is quite possible the interrupt
lines on some of your slots are physically wired together, and indeed quite
likely that this is true if you have five or more slots

> parallel and USB, giving all manner of "pci=" kernel parameters, tried
> with APIC and without (even though it's UP, it seems to still use it if

APIC can help by removing ISA/PCI sharing, but not PCI to PCI. 

Alan
--
  "Have you noticed the way people's intelligence capabilities decline
   sharply the minute they start waving guns around?"
 		-- Dr. Who
