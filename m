Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290818AbSDMRIw>; Sat, 13 Apr 2002 13:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292588AbSDMRIv>; Sat, 13 Apr 2002 13:08:51 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:16654
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S290818AbSDMRIv>; Sat, 13 Apr 2002 13:08:51 -0400
Date: Sat, 13 Apr 2002 10:06:21 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: VIA, 32bit PIO and 2.5.x kernel
In-Reply-To: <3CB8314E.7050707@evision-ventures.com>
Message-ID: <Pine.LNX.4.10.10204130948430.489-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trimmed CC...

Additional issues not fully address are 8-bit transfers.

Lastly if a host can not do 16-bit transfers it is bad and broken and the
OEM needs to be railed for it.  Defaulting to 32-bit with legacy hardware
still in the mix will eat somebodies data.

Much of this discussion as to expose a bogus policy of forcing hardware
to 32-bit and causing other problems that are not reported in the proper
light.  When people put DOC or ATA-Flash in the onboard host it will mess
things up.  Since there are people who think it is okay to set policies in
hardware and have gotten away with it, adding in the default to undo the
bogusity will point that most hardware does not need the is junk and let
it resided with the enduser.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

On Sat, 13 Apr 2002, Martin Dalecki wrote:

> Russell King wrote:
> > On Fri, Apr 12, 2002 at 10:04:12AM +0200, Martin Dalecki wrote:
> > 
> >>3. Make 32 bit PIO transfers the global default.
> > 
> > 
> > This is fine, as long as you allow some interfaces to say "I really want
> > to be 16-bit PIO only".
> > 
> > I *need* 16-bit transfers for many ARM-based IDE stuff.  32-bit is not
> > an option on many, if not all ARM-based PCMCIA stuff.
> 
> What I wan't to disable is just the *unconditional* fallback to 16 bit IO
> at some places. This and not more. This doens't even affect the physical setup 
> between the host chip and the controller on disc.
> The global "wheee I'm a poor and can't afford 32 bit IO" option will remain
> there of course.
> 
> So we have no  issue here. OK?
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

