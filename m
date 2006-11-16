Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424105AbWKPOmE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424105AbWKPOmE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 09:42:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424107AbWKPOmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 09:42:04 -0500
Received: from khc.piap.pl ([195.187.100.11]:32915 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1424105AbWKPOl7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 09:41:59 -0500
To: Jeff Garzik <jeff@garzik.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       David Miller <davem@davemloft.net>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, tiwai@suse.de
Subject: Re: [PATCH] ALSA: hda-intel - Disable MSI support by default
References: <455A938A.4060002@garzik.org>
	<20061114.201549.69019823.davem@davemloft.net>
	<455A9664.50404@garzik.org>
	<20061114.202814.70218466.davem@davemloft.net>
	<1163643937.5940.342.camel@localhost.localdomain>
	<455BDA1D.5090409@garzik.org>
	<1163650341.5940.361.camel@localhost.localdomain>
	<455C0176.5090107@garzik.org>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Thu, 16 Nov 2006 15:41:56 +0100
In-Reply-To: <455C0176.5090107@garzik.org> (Jeff Garzik's message of "Thu, 16 Nov 2006 01:13:10 -0500")
Message-ID: <m3u00z4fnv.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jeff@garzik.org> writes:

>>> We are referring to the standard PCI 2.2 bit, PCI_COMMAND_INTX_DISABLE.
>> Yeah, I figured it, I somewhat forgot about it ... it got introduced
>> in
>> 2.3 though, no ?
>
> It's pretty new.  2.2 or 2.3.

2.3.

PCI 2.2 defines bits 0-9 only (bit 7 = Stepping Control)
PCI 2.3 and 3.0: bit 7 = Reserved, bit 10 = Interrupt Disable.

OTOH many devices have "interrupt disable" bit somewhere else, in
their specific PCI config registers or in regular config registers
(accessible with normal Memory Read/Write cycles).

MSI was first defined in PCI 2.2.

Perhaps I can check NV (MCP55) for that problem with a module claiming
all free interrupts. Tomorrow maybe.
-- 
Krzysztof Halasa
