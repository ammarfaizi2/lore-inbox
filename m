Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267669AbUHPOt1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267669AbUHPOt1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 10:49:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267658AbUHPOt1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 10:49:27 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:8915 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S267669AbUHPOsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 10:48:32 -0400
Date: Mon, 16 Aug 2004 07:48:29 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Greg Weeks <greg.weeks@timesys.com>
Cc: Dan Malek <dan@embeddededge.com>, Kumar Gala <kumar.gala@freescale.com>,
       LKML <linux-kernel@vger.kernel.org>,
       LinuxPPC-dev Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [BUG] PPC math-emu multiply problem
Message-ID: <20040816144829.GC2377@smtp.west.cox.net>
References: <4108F845.7080305@timesys.com> <85C49799-E168-11D8-B0AC-000393DBC2E8@freescale.com> <A46787F8-E194-11D8-B8DB-003065F9B7DC@embeddededge.com> <410A5F08.90103@timesys.com> <410A67EA.80705@timesys.com> <20040809165650.GA22109@smtp.west.cox.net> <6FBD1B21-EA2B-11D8-8382-003065F9B7DC@embeddededge.com> <20040809222328.GB22109@smtp.west.cox.net> <4120B055.8090503@timesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4120B055.8090503@timesys.com>
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2004 at 09:02:13AM -0400, Greg Weeks wrote:

> Tom Rini wrote:
> >On Mon, Aug 09, 2004 at 01:42:08PM -0400, Dan Malek wrote:
> >>On Aug 9, 2004, at 12:56 PM, Tom Rini wrote:
> >>>Has anyone had a problem with this?  If not, I'll go and pass it
> >>>along...
> >>>
> >>The default rounding mode should be whatever is defined
> >>by IEEE.  I thought the emulator used the proper default value
> >>and if want something different it should be selected by
> >>the control register.  Maybe the emulator isn't implementing
> >>the control register properly.
> >
> >Or we had the wrong default?  Greg, any chance you've looked into this
> >more?  Thanks.
> >
> I'm back.
> 
> The round mode for the emulator is compiled in. Changing the round mode 
> caused failures in some of the other LSB float tests.  I had intended to 
> say something about this before taking off on vacation. Sorry.

S'alright.

> The way I got the LSB tests to pass was to remove the round in the 
> denormalised underflow case. This appears to match the hardware 
> behavior. I've not looked at the PPC floating point model close enough 
> to know if this is proper behavior. It is what the LSB tests are 
> expecting and doesn't cause a failure in any of the other LSB tests.

Have you guys run the LSB tests on some PPC with hw floating point (is
that what you mean by 'matches the hardware behavior' ?) to see if the
test also passes there as-is?  And does anyone object to this patch?
Now that 2.6.8.1 is out I'm gonna start committing in a bunch of stuff
I've had queued up and see if I can get Linus to pull.  Thanks.

-- 
Tom Rini
http://gate.crashing.org/~trini/
