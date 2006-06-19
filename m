Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964864AbWFSTk1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964864AbWFSTk1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 15:40:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964866AbWFSTk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 15:40:26 -0400
Received: from web52903.mail.yahoo.com ([206.190.49.13]:43094 "HELO
	web52903.mail.yahoo.com") by vger.kernel.org with SMTP
	id S964864AbWFSTk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 15:40:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=T0FANRVh1mICSQPouPKI8cDTZkYm+7lkG9/XEWWr2C2MH2ud7lP27WcBJdTqGMvwHDZLH+sIzifU0xxAx8ItIJBxep+jZHIGTLRtUjTZJbMPVlays/b8kYS2v8rKzW930ySL/SCVG0kW3jI3SlvRDKNhxMU6majZnv/JTQlVLAk=  ;
Message-ID: <20060619194024.99464.qmail@web52903.mail.yahoo.com>
Date: Mon, 19 Jun 2006 20:40:24 +0100 (BST)
From: Chris Rankin <rankincj@yahoo.com>
Subject: Re: Linux 2.6.17: IRQ handler mismatch in serial code?
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
In-Reply-To: <20060619184706.GH3479@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> This seems to be an invalid situation - you appear to have an _ISA_
> NE2000 card using IRQ3, trying to share the same interrupt as a
> serial port.
> 
> ISA interrupts aren't sharable without additional hardware support
> or specific software support in the Linux kernel interrupt
> architecture.

Hmm, I see what you mean. Except that I thought that I'd manually disabled the motherboard's
serial device on IRQ 3, via the BIOS:

Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
pnp: Device 00:07 activated.
00:07: ttyS2 at I/O 0x3e8 (irq = 4) is a 16550A
pnp: Device 00:08 activated.
00:08: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A

Does Linux reenable all motherboard devices, regardless?

Cheers,
Chris



		
___________________________________________________________ 
To help you stay safe and secure online, we've developed the all new Yahoo! Security Centre. http://uk.security.yahoo.com
