Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264499AbTEPRIB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 13:08:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264500AbTEPRIB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 13:08:01 -0400
Received: from ida.rowland.org ([192.131.102.52]:30724 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S264499AbTEPRIA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 13:08:00 -0400
Date: Fri, 16 May 2003 13:20:52 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Paul Fulghum <paulkf@microgate.com>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       <johannes@erdfelt.com>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: Test Patch: 2.5.69 Interrupt Latency
In-Reply-To: <1053100440.1948.17.camel@toshiba>
Message-ID: <Pine.LNX.4.44L0.0305161316380.1171-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 May 2003, Paul Fulghum wrote:

> Moving the wait out of the ISR and doing the wakeup
> only for RD on non-OC ports are winners.
> 
> I can't comment on the 1 second grace period. Was that
> in response to this investigation, or have you actually
> seen false RD indications due to noise?

Well, I have actually seen false indications.  Whether they are due to
noise is open to debate.  Since they occur just at the time when I turn
the power to my USB peripheral on or off, that's my best guess.  It might
even turn out that power on/off generates a temporary OC condition, so
fixing that might render the grace period unnecessary.  I haven't had a
chance try it yet.

> There is also the more trivial matter of removing the
> unnecessary setting of the FGR bit on wakeup.

Yes.  That can be done in any case.

> I'll check that the global RD interrupt does not
> keep repeating after a false RD by an OC port.

Good.

> So I suggest you build a patch that does all of
> the above (with the grace period at your discretion).
> Then we can both test it, and you can submit it
> for actual inclusion.

I will.  Probably won't be ready until some time next week.

Alan Stern

