Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932182AbVLLTwU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182AbVLLTwU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 14:52:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932183AbVLLTwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 14:52:20 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:53210 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S932182AbVLLTwU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 14:52:20 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.15-rc5-mm2: ehci_hcd crashes on load sometimes
Date: Mon, 12 Dec 2005 20:53:39 +0100
User-Agent: KMail/1.9
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
References: <20051211041308.7bb19454.akpm@osdl.org> <200512111706.42867.rjw@sisk.pl> <20051211123808.2609f5e7.akpm@osdl.org>
In-Reply-To: <20051211123808.2609f5e7.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512122053.39970.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, 11 December 2005 21:38, Andrew Morton wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> >
> > The ehci_hcd driver causes problems like this:
> > 
> > ehci_hcd 0000:00:02.2: EHCI Host Controller
> > ehci_hcd 0000:00:02.2: debug port 1
> > ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 3
> > ehci_hcd 0000:00:02.2: irq 5, io mem 0xfebfdc00
> > usb 2-2: Product: USB Receiver
> > usb 2-2: Manufacturer: Logitech
> > usb 2-2: configuration #1 chosen from 1 choice
> > ehci_hcd 0000:00:02.2: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
> > Unable to handle kernel NULL pointer dereference at 00000000000002a4 RIP:
> > <ffffffff880ad9d0>{:ehci_hcd:ehci_irq+224}
> 
> Can you poke around in gdb, see which line it's dying at?

It looks like at the line 620.  At least here's what gdb told me:

Line 620 of "ehci-hcd.c" starts at address 0x69c3 <ehci_irq+211>
   and ends at 0x69e2 <ehci_irq+242>.
