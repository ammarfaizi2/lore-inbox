Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270210AbTGMKdg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 06:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270211AbTGMKdg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 06:33:36 -0400
Received: from ip212-226-133-178.adsl.kpnqwest.fi ([212.226.133.178]:27792
	"EHLO jumper") by vger.kernel.org with ESMTP id S270210AbTGMKde
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 06:33:34 -0400
To: Russell King <rmk@arm.linux.org.uk>
Subject: Re: hang with pcmcia wlan card
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Wiktor Wodecki <wodecki@gmx.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <87fzldxcf5.fsf@jumper.lonesom.pp.fi>
	<873chbyasi.fsf@jumper.lonesom.pp.fi>
	<20030712173039.A17432@flint.arm.linux.org.uk>
	<20030712164855.GB2133@gmx.de>
	<1058086011.31919.39.camel@dhcp22.swansea.linux.org.uk>
	<87wuemg3h2.fsf@jumper.lonesom.pp.fi>
	<20030713110016.A2621@flint.arm.linux.org.uk>
From: Jaakko Niemi <liiwi@lonesom.pp.fi>
Date: Sun, 13 Jul 2003 13:48:22 +0300
In-Reply-To: <20030713110016.A2621@flint.arm.linux.org.uk> (Russell King's
 message of "Sun, 13 Jul 2003 11:00:16 +0100")
Message-ID: <87he5qg0sp.fsf@jumper.lonesom.pp.fi>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk@arm.linux.org.uk> writes:

> On Sun, Jul 13, 2003 at 12:50:33PM +0300, Jaakko Niemi wrote:
>> Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
>> > On Sad, 2003-07-12 at 17:48, Wiktor Wodecki wrote:
>> >> > +      * If ISA interrupts don't work, then fall back to routing card
>> >> > +      * interrupts to the PCI interrupt of the socket.
>> >> > +      */
>> >> > +     if (!socket->socket.irq_mask) {
>> >> > +             int irqmux, devctl;
>> >> > +
>> >
>> > See the fix posted to the list a while ago and apply that and all should
>> > be well. The change you refer to breaks for some setups
>> 
>>  Was the fix against drivers/pcmcia/ti113x.h ? (other than backing off
>>  that patch..). If so, then I'm unable to locate it. Looks like I need
>>  local lkml archive anyway :)
>
> The patch never went anywhere near lkml.  It was sent to Pat Mochel
> primerily for testing (since Pat was able to produce the feedback
> last time around to solve the problem.)  However, I haven't heard back
> from Pat.

 I applied this to plain vanilla 2.5.75-bk1 and booted and everything
 seems working ok. 

> I won't even bother putting this into my bk tree and asking Linus to
> pull; I'm sure someone else will integrate this into the kernel tree
> for me.  (as happened previously, and as a result I need to sort out
> my bk tree.)

 I guess testing with a bit of different hardware would be good.

                        --j


