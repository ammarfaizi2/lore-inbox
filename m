Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261785AbTHTIPB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 04:15:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261823AbTHTINU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 04:13:20 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:24497 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S261775AbTHTIEG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 04:04:06 -0400
Date: Wed, 20 Aug 2003 10:03:41 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Jamie Lokier <jamie@shareable.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>
Subject: Re: [PATCH][2.6][5/5]Support for HPET based timer
Message-ID: <20030820080341.GA17793@ucw.cz>
References: <C8C38546F90ABF408A5961FC01FDBF1902C7D1C7@fmsmsx405.fm.intel.com> <20030819224104.GB13346@ucw.cz> <20030820000856.GE18035@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030820000856.GE18035@mail.jlokier.co.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 20, 2003 at 01:08:56AM +0100, Jamie Lokier wrote:
> Vojtech Pavlik wrote:
> > On Tue, Aug 19, 2003 at 12:20:22PM -0700, Pallipadi, Venkatesh wrote:
> > 
> > > 5/5 - hpet5.patch - This can be a standalone patch. Without this
> > >                     patch we loose interrupt generation capability
> > >                     of RTC (/dev/rtc), due to HPET. With this patch
> > >                     we basically try to emulate RTC interrupt
> > >                     functions in software using HPET counter 1.
> > > 
> > 
> > This is very wrong IMO. We shouldn't try to emulate the RTC interrupt
> > for the kernel, instead the HPET should use native APIC interrupt
> > routing.
> 
> Even on those machines where APIC interrupts are not usable?
> (E.g. due to interactions with the SMM BIOS).

Well, I suspect the machines with HPET should better have usable APIC
interrupts, because you won't be able to use all the HPET timers then -
only two can be routed via the timer and RTC interrupts, the other need
to use APIC or direct FSB delivery.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
