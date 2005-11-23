Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932191AbVK1TOE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbVK1TOE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 14:14:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932193AbVK1TOD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 14:14:03 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:29073 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S932191AbVK1TNw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 14:13:52 -0500
Message-ID: <4384C2E3.7050404@tmr.com>
Date: Wed, 23 Nov 2005 14:28:35 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Christmas list for the kernel
References: <9e4733910511221031o44dd90caq2b24fbac1a1bae7b@mail.gmail.com> <9e4733910511221341u695f6765k985ecf0c54daba49@mail.gmail.com> <20051123144437.GB7328@ucw.cz> <200511231221.27781.gene.heskett@verizon.net> <20051123173020.GL15449@flint.arm.linux.org.uk>
In-Reply-To: <20051123173020.GL15449@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Wed, Nov 23, 2005 at 12:21:27PM -0500, Gene Heskett wrote:
> 
>>serio: i8042 AUX port at 0x60,0x64 irq 12
>>serio: i8042 KBD port at 0x60,0x64 irq 1
>>Serial: 8250/16550 driver $Revision: 1.90 $ 2 ports, IRQ sharing enabled
>>ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
>>ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
>>ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
>>ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
>>ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
>>ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
>>
>>I had posted about this before, but it was apparently lost in the lists
>>general noise.   I do use both ports here, and they are working, so I
>>hadn't pursued it further.
> 
> 
> So has the answer.  I've answered this twice today, and several times
> in bugzilla.  It's one reason why these lines are now prefixed with
> "serial8250" - that being the struct device to which they end up being
> associated with.  (defaulting to "serial8250" for power management
> purposes if no other exists.)
> 
Am I being slow? These messages are repeated three times because they 
are prefixed? 2.6.14 also presented the info several times:

PNP: PS/2 Controller [PNP0303:KBC,PNP0f13:MICE] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
pnp: the driver 'serial' has been registered
pnp: match found with the PnP device '00:09' and the driver 'serial'
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A

I don't have a 2.6.15 flavor system handy at the moment, my bleeding 
edge system is being OpenSolaris today :-( Is there value to having this 
apparently duplicate information displayed? It looks like babble, or 
worse some init code being called multiple times, if this is as it 
should be, or useful to some developer fine, I just don't quite read 
that into your answer saying it's prefixed. And I don't see serial8250 
in Gene's post or my dmesg.
-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

