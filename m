Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270862AbTHFUzY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 16:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271751AbTHFUzY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 16:55:24 -0400
Received: from hendrix.ece.utexas.edu ([128.83.59.42]:17638 "EHLO
	hendrix.ece.utexas.edu") by vger.kernel.org with ESMTP
	id S270862AbTHFUzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 16:55:15 -0400
Date: Wed, 6 Aug 2003 15:55:02 -0500 (CDT)
From: "Hmamouche, Youssef" <youssef@ece.utexas.edu>
To: David Hinds <dhinds@sonic.net>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: [PROBLEM] xircom CBE2-100(faulty) hangs kernel 2.4.{21, 22-pre8}
 (fwd)
In-Reply-To: <20030806124759.C30485@sonic.net>
Message-ID: <Pine.LNX.4.21.0308061514470.2297-100000@linux08.ece.utexas.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam,
	SpamAssassin (Disabled due to 10consecutive timeouts)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




I'm a user. When I insert a card "into my laptop" I'd like it to work as
advertised. If it doesn't work as advertised(because of some hardware
failure in this case), I'd like the kernel to more or less let me know
that something went wrong so I can return it. I wouldn't expect the kernel
to freeze.

Faulty hardware is very common in the PC era. I agree that it is hard to
pin down hardware malfunctions when you don't know what to check
for. However, There should be concern when it takes your whole system
down.

I guess this issue can be disregarded but it'll only make the kernel as
strong as its weakest link.

Youssef

On Wed, 6 Aug 2003, David Hinds wrote:

> > Date: Sat, 2 Aug 2003 16:09:30 -0500 (CDT)
> > From: "Hmamouche, Youssef" <youssef@ece.utexas.edu> 
> > Hi,
> > 
> > I have a xircom CBE2-100 ethernet card that I know(as a matter of fact) is
> > faulty. The warranty on the card expired and couldn't take it back to
> > the manufacturer. Anyway, I hotplugged it into the sock with no problem at
> > all. However, when I try to bring up the interface, the kernel hangs. If I
> > unplug the card, the kernel comes back to life and resumes. 
> 
> Uhh... let me get this straight... the card is known for a fact to be
> faulty.
> 
> > The symptoms of the problem show at
> > drivers/net/pcmcia/xircom_tulip_cb: xircom_interrupt() where the interrupt
> > is never acknowledge(due to flawed hardware). 
> 
> Perhaps the driver does not ack the interrupt, because the device
> registers do not indicate that it requires service, and the interrupt
> pin is just stuck.  Or perhaps the driver does ack and the card is
> immediately re-triggering or ignoring the ack.
> 
> Drivers cannot in general diagnose hardware faults.  Perhaps, if
> someone had a card broken the same way your card is broken, and they
> knew the specific reason for the breakage, they could design a test
> for that particular hardware fault.  But your card might be the only
> one in the known universe with this particular failure mode.
> 
> -- Dave
> 



