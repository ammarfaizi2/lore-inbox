Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750734AbWBEV0K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbWBEV0K (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 16:26:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbWBEV0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 16:26:10 -0500
Received: from khc.piap.pl ([195.187.100.11]:45322 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1750734AbWBEV0I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 16:26:08 -0500
To: Glen Turner <glen.turner@aarnet.edu.au>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: 8250 serial console fixes -- issue
References: <Pine.LNX.4.44.0602011911360.22854-100000@gate.crashing.org>
	<1138844838.5557.17.camel@localhost.localdomain>
	<43E2B8D6.1070707@aarnet.edu.au>
	<20060203094042.GB30738@flint.arm.linux.org.uk>
	<43E36850.5030900@aarnet.edu.au>
	<20060203160218.GA27452@flint.arm.linux.org.uk>
	<m3lkwse3nz.fsf@defiant.localdomain>
	<20060203221346.GA10700@flint.arm.linux.org.uk>
	<m3mzh7ds45.fsf@defiant.localdomain>
	<20060204232005.GC24887@flint.arm.linux.org.uk>
	<43E56D14.80808@aarnet.edu.au>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Sun, 05 Feb 2006 22:26:06 +0100
In-Reply-To: <43E56D14.80808@aarnet.edu.au> (Glen Turner's message of "Sun, 05 Feb 2006 13:42:20 +1030")
Message-ID: <m3psm1ebv5.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Glen Turner <glen.turner@aarnet.edu.au> writes:

> The serial console still should not write into an unasserted
> DSR or DCD since that will hang up on incoming calls. But
> they's a totally different, non-security issue.

Could be a security issue if the modem gets reconfigured.

> I'm also unsure of the robustness equipment in the face
> of Russell's suggestion. The suggestion implies that the
> kernel will write strings when CTS is unasserted.  There
> is some allowance for that in receivers that are configured
> for RTS/CTS flow control, but it that allowance being overly
> stressed?  And does it matter if the modem or the receiver
> drops some characters?  Is there popular equipment for which
> this is a pathological case?

Actually I think you can't currently connect a Hayes modem directly
to a serial console, CRTSCTS or no flow control.

With terminal server it may work (especially Linux-based or similar),
for example, with "screen".

> I would probably prefer two flags -- 'r' meaning flow control
> (CTS) and a new option, say 's', meaning modem status (DSR,DCD).

Would make sense I think.

>> BTW I think you know all of this very well for years.
>
> I don't know what you were thinking when you wrote this.  But
> it is stupid.  It's one thing to be technically wrong  -- all
> that is required to fix that is some patience on both sides.
> And Russell has been very patient with me, which I appreciate.
>
> It's totally another thing entirely to be insulting.  What
> do you now think are the chances of people working together
> harmoniously to have the open issues satisfactorily resolved?

I'm not exactly sure what do you mean. First I thought he was
overworked or something like that but now I wonder if I should
check it with an English teacher nearby?

I just really thought he knows modem control lines details and
how Hayes modems behave etc. from BBS era.

What exactly is the "insult" here?
-- 
Krzysztof Halasa
