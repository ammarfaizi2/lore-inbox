Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267860AbUHPSfM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267860AbUHPSfM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 14:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267863AbUHPSfM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 14:35:12 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:58318 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S267861AbUHPSfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 14:35:03 -0400
Date: Mon, 16 Aug 2004 11:35:02 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Greg Weeks <greg.weeks@timesys.com>
Cc: Dan Malek <dan@embeddededge.com>, Kumar Gala <kumar.gala@freescale.com>,
       LKML <linux-kernel@vger.kernel.org>,
       LinuxPPC-dev Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [BUG] PPC math-emu multiply problem
Message-ID: <20040816183502.GC7303@smtp.west.cox.net>
References: <85C49799-E168-11D8-B0AC-000393DBC2E8@freescale.com> <A46787F8-E194-11D8-B8DB-003065F9B7DC@embeddededge.com> <410A5F08.90103@timesys.com> <410A67EA.80705@timesys.com> <20040809165650.GA22109@smtp.west.cox.net> <6FBD1B21-EA2B-11D8-8382-003065F9B7DC@embeddededge.com> <20040809222328.GB22109@smtp.west.cox.net> <4120B055.8090503@timesys.com> <20040816144829.GC2377@smtp.west.cox.net> <4120FCD0.2090305@timesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4120FCD0.2090305@timesys.com>
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2004 at 02:28:32PM -0400, Greg Weeks wrote:

> Tom Rini wrote:
> 
> >>The way I got the LSB tests to pass was to remove the round in the 
> >>denormalised underflow case. This appears to match the hardware 
> >>behavior. I've not looked at the PPC floating point model close enough 
> >>to know if this is proper behavior. It is what the LSB tests are 
> >>expecting and doesn't cause a failure in any of the other LSB tests.
> >>   
> >>
> >
> >Have you guys run the LSB tests on some PPC with hw floating point (is
> >that what you mean by 'matches the hardware behavior' ?) to see if the
> >test also passes there as-is?  And does anyone object to this patch?
> >Now that 2.6.8.1 is out I'm gonna start committing in a bunch of stuff
> >I've had queued up and see if I can get Linus to pull.  Thanks.
> >
> > 
> >
> I didn't run the entire LSB, just some of the math tests. I had an 8260 
> and the 8560 we found the problem on and also a normal x86 box. I think 
> this is the correct fix. At least all of the LSB math tests pass now and 
> the LTP float tests don't complain.

Just to be clear, with that patch, 8260, 8560 and x86 all agree on
results ?

-- 
Tom Rini
http://gate.crashing.org/~trini/
