Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263104AbUCSQgi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 11:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263123AbUCSQgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 11:36:38 -0500
Received: from styx.suse.cz ([82.208.2.94]:50304 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S263104AbUCSQge (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 11:36:34 -0500
Date: Fri, 19 Mar 2004 17:36:50 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Dave Jones <davej@redhat.com>, Marc Zyngier <mzyngier@freesurf.fr>,
       Linux kernel <linux-kernel@vger.kernel.org>, torvalds@osdl.org,
       akpm@osdl.org, jgarzik@pobox.com
Subject: Re: [3C509] Fix sysfs leak.
Message-ID: <20040319163650.GA4458@ucw.cz>
References: <200403152147.i2FLl09s002942@delerium.codemonkey.org.uk> <wrpad2hf4be.fsf@panther.wild-wind.fr.eu.org> <20040316134613.GA15600@redhat.com> <wrp3c88g9xu.fsf@panther.wild-wind.fr.eu.org> <20040316142951.GA17958@redhat.com> <Pine.LNX.4.53.0403161053040.6499@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0403161053040.6499@chaos>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2004 at 10:58:08AM -0500, Richard B. Johnson wrote:
> On Tue, 16 Mar 2004, Dave Jones wrote:
> 
> > On Tue, Mar 16, 2004 at 03:09:49PM +0100, Marc Zyngier wrote:
> >  > >>>>> "Dave" == Dave Jones <davej@redhat.com> writes:
> >  >
> >  > Dave> Then the probing routine is bogus, it returns 0 when it fails too.
> >  >
> >  > Uh ? el3_eisa_probe looks like it properly returns an error...
> >  >
> >  > Or maybe you call a failure not finding a proper device on the bus ?
> >
> > The damned bus doesn't even exist. If this is a case that couldn't be
> > detected, I'd not be complaining, but this is just nonsense having
> > a driver claim that its found an EISA device, when there aren't even
> > any EISA slots on the board.
> 
> There is no way that any software knows about an EISA bus. It
> only knows that there is some device at some port. Since a 3c503
> was built to go into an 8-bit EISA slot, if one is found it
> is assumed to be in such a slot on the EISA bus!
> 
> So, if the device doesn't exist there is a problem with the
> detection method for the device, not a detection method for
> a bus because the bus can't be detected at all.

3c503 in EISA? 8-bit EISA? I think you mean ISA ...

EISA has slot information available, as far as I know, and device
identifiers and ... and is a 32-bit bus.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
