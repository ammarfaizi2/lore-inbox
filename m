Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279747AbRJYKXr>; Thu, 25 Oct 2001 06:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279756AbRJYKXd>; Thu, 25 Oct 2001 06:23:33 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:30036 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S279747AbRJYKXO>; Thu, 25 Oct 2001 06:23:14 -0400
To: "Linus Torvalds" <torvalds@transmeta.com>
Cc: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
        "Alan Cox" <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        "Patrick Mochel" <mochel@osdl.org>,
        "Jonathan Lundell" <jlundell@pobox.com>
Subject: Re: [RFC] New Driver Model for 2.5
In-Reply-To: <Pine.LNX.4.33.0110250224340.1128-100000@penguin.transmeta.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 25 Oct 2001 04:11:58 -0600
In-Reply-To: <Pine.LNX.4.33.0110250224340.1128-100000@penguin.transmeta.com>
Message-ID: <m1elnsdo5t.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Linus Torvalds" <torvalds@transmeta.com> writes:

> On 25 Oct 2001, Eric W. Biederman wrote:
> >
> > Or another fun common one.  To shut down the interrupt controller, I first
> > need to shut down every device that thinks it can generate interrupts.
> > But my interrupt controller is way out on my pci->isa bridge.  So I
> > can't shut that device down.
> >
> > Sorry this whole device tree idea for shutdown ordering doesn't seem
> > to match my idea of reality.
> 
> Your _examples_ do not match any reality.

I'll go as far as agreeing they do not matching any _practical_ reality.

> Don't worry about things like the CPU shutdown: you have to have special
> code for it anyway.

But that is the case I plan on coding....
 
> Let's face it, the device tree is for _devices_. It's for shutting down a
> network card before we shut down the PCI bridge that is in front of it.
> 
> The issue of "core shutdown" is not covered - and isn't _meant_ to be
> covered. 

O.k. I'll step back and let you guys handle the normal cases.  I rarely
get past "core startup" and "core shutdown".  

> That's the problem of the architecture-specific code. There is no
> point in having a device tree for that, because it's going to be very much
> architecture-specific anyway (ie on x86 we may have to just blindly trust
> some silly APCI table data etc).

I'm doing my best to provide a real world alternative to ACPI on some
boards. 

My perspective is coming from linuxBIOS, or in general GPL'd
firmware, so it is a little different.  

But at this point in the conversation it looks like I should just back
off, let the core API get the easy cases correct.  And then come back
and figure out how to handle the truly weird cases.

Eric
