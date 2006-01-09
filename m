Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751317AbWAIUcb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbWAIUcb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 15:32:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbWAIUcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 15:32:31 -0500
Received: from colin.muc.de ([193.149.48.1]:22795 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1751317AbWAIUca (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 15:32:30 -0500
Date: 9 Jan 2006 21:32:25 +0100
Date: Mon, 9 Jan 2006 21:32:25 +0100
From: Andi Kleen <ak@muc.de>
To: lkml@cl.domainfactory-kunde.de
Cc: Clemens Ladisch <clemens@ladisch.de>, Andrew Morton <akpm@osdl.org>,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HPET RTC emulation: add watchdog timer
Message-ID: <20060109203225.GA93253@muc.de>
References: <20060109154350.GA22126@turing.informatik.uni-halle.de> <20060109164140.GA67021@muc.de> <1136829634.43c2a4c2e0997@www.domainfactory-webmail.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1136829634.43c2a4c2e0997@www.domainfactory-webmail.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2006 at 07:00:34PM +0100, lkml@cl.domainfactory-kunde.de wrote:
> Andi Kleen wrote:
> > On Mon, Jan 09, 2006 at 04:43:50PM +0100, Clemens Ladisch wrote:
> > > To prevent the emulated RTC timer from stopping when interrupts
> > > are disabled for too long, implement the watchdog timer to
> > > restart it when needed.
> >
> > The interrupt handler should just read the time (it likely
> > has to do that anyways)
> 
> Not in the current implementation.

The standard HPET interrupt in x86-64 does this already at least.

> > and check for that directly.
> 
> I want to avoid the read altogether because the round trip to the
> south bridge is rather slow (1.5 microseconds with VIA chipsets).

You can use the TSC to detect it too, but it might be unreliable.

-Andi

