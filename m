Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264885AbTAUA1u>; Mon, 20 Jan 2003 19:27:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265196AbTAUA1u>; Mon, 20 Jan 2003 19:27:50 -0500
Received: from oak.sktc.net ([208.46.69.4]:62660 "EHLO oak.sktc.net")
	by vger.kernel.org with ESMTP id <S264885AbTAUA1t>;
	Mon, 20 Jan 2003 19:27:49 -0500
Message-ID: <3E2C9623.60709@sktc.net>
Date: Mon, 20 Jan 2003 18:36:51 -0600
From: "David D. Hagood" <wowbagger@sktc.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021201
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: AnonimoVeneziano <voloterreno@tin.it>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Spurious 8259A interrupt: IRQ7 ????
References: <3E2C8EFF.6020707@tin.it>
In-Reply-To: <3E2C8EFF.6020707@tin.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

AnonimoVeneziano wrote:
> What does it mean this message?
> 
> Of what problem is the signal?

It is most likely a hardware problem.

When a device signals an interrupt, it asserts its interrupt pin. When 
the CPU asks the interrupt controller what device generated the 
interrupt, the interrupt controller tells the CPU.

But if the interrupt line "goes away" before the CPU fetches the vector, 
then the interrupt controller doesn't "know" what IRQ caused the 
interrupt. So the interrupt controller sends an IRQ #7 to the CPU, along 
with setting a bit in the interrupt controller's status register that 
says in effect "this isn't really an IRQ 7, but I have no idea what it 
was. Sorry."

If you have ISA cards in your system, remove them from the system and 
re-insert them (with the power off, of course) - they may have developed 
some oxidization on the card edge connector. You can also try scrubbing 
the card edge with some plain paper (a US dollar bill works even better, 
but you might not have access to dead presidents in Italy.)

Ditto with PCI cards - remove them, polish the connector, then re-insert 
them.


