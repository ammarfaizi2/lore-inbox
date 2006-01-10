Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750943AbWAJI1r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750943AbWAJI1r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 03:27:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751009AbWAJI1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 03:27:47 -0500
Received: from webmailv3.ispgateway.de ([80.67.16.113]:9166 "EHLO
	webmailv3.ispgateway.de") by vger.kernel.org with ESMTP
	id S1750931AbWAJI1r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 03:27:47 -0500
Message-ID: <1136881650.43c36ff2cb881@www.domainfactory-webmail.de>
Date: Tue, 10 Jan 2006 09:27:30 +0100
From: Clemens Ladisch <clemens@ladisch.de>
To: Andi Kleen <ak@muc.de>
Cc: Andrew Morton <akpm@osdl.org>,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HPET RTC emulation: add watchdog timer
References: <20060109154350.GA22126@turing.informatik.uni-halle.de> <20060109164140.GA67021@muc.de> <1136829634.43c2a4c2e0997@www.domainfactory-webmail.de> <20060109203225.GA93253@muc.de>
In-Reply-To: <20060109203225.GA93253@muc.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.8
X-Originating-IP: 213.238.46.206
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Clemens Ladisch <lkml@cl.domainfactory-kunde.de> wrote:
> > Andi Kleen wrote:
> > > Clemens Ladisch wrote:
> > > > To prevent the emulated RTC timer from stopping when
> > > > interrupts are disabled for too long, implement the watchdog
> > > > timer to restart it when needed.
> > >
> > > The interrupt handler should just read the time (it likely
> > > has to do that anyways)
> >
> > Not in the current implementation.
>
> The standard HPET interrupt in x86-64 does this already at least.

But it's slower than just doing a mod_timer which the RTC code does
_anyway_, so we could just as well use it.  Especially as the watchdog
timer isn't actually expected to run in normal circumstances.


Clemens

