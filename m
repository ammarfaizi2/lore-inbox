Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261789AbVECQRF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261789AbVECQRF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 12:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbVECQRF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 12:17:05 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:65176 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S261789AbVECQRA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 12:17:00 -0400
Date: Tue, 3 May 2005 09:16:58 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: David Woodhouse <dwmw2@infradead.org>,
       Kumar Gala <kumar.gala@freescale.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Phil Oester <kernel@linuxace.com>, linux-kernel@vger.kernel.org
Subject: Re: Garbage on serial console after serial driver loads
Message-ID: <20050503161658.GP1221@smtp.west.cox.net>
References: <20050328173652.GA31354@linuxace.com> <20050328200243.C2222@flint.arm.linux.org.uk> <1115129833.4446.23.camel@hades.cambridge.redhat.com> <20050503151159.GL1221@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050503151159.GL1221@smtp.west.cox.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 03, 2005 at 08:11:59AM -0700, Tom Rini wrote:
> On Tue, May 03, 2005 at 03:17:12PM +0100, David Woodhouse wrote:
> > On Mon, 2005-03-28 at 20:02 +0100, Russell King wrote:
> > > Is this patch ok for you?
> > 
> > Not really; it's just a quick hack applied without any real
> > consideration of the problem. If we're messing up the baud rate when we
> > change the master clock, then just make it change the divisor
> > accordingly at the same time. We don't seem to store the active
> > parameters of the serial console anywhere useful; we can do it just by
> > reading back the divisor and multiplying by eight though...
> > 
> > Tom, does this also mean you don't need the 'ifndef ppc'?
> 
> I don't recall the problem well enough right now, but I'll go toss this
> into a current git tree and let you know.

Dropping the 'ifndef ppc' is fine on my Motorola Sandpoint which I do
believe exhibited the problem previously. I've cc'd Kumar Gala since I see
on IRC that 85xx boards might also have had a problem here.

-- 
Tom Rini
http://gate.crashing.org/~trini/
