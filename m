Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261621AbTHTAJZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 20:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261620AbTHTAJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 20:09:24 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:60545 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S261621AbTHTAJT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 20:09:19 -0400
Date: Wed, 20 Aug 2003 01:08:56 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>
Subject: Re: [PATCH][2.6][5/5]Support for HPET based timer
Message-ID: <20030820000856.GE18035@mail.jlokier.co.uk>
References: <C8C38546F90ABF408A5961FC01FDBF1902C7D1C7@fmsmsx405.fm.intel.com> <20030819224104.GB13346@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030819224104.GB13346@ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> On Tue, Aug 19, 2003 at 12:20:22PM -0700, Pallipadi, Venkatesh wrote:
> 
> > 5/5 - hpet5.patch - This can be a standalone patch. Without this
> >                     patch we loose interrupt generation capability
> >                     of RTC (/dev/rtc), due to HPET. With this patch
> >                     we basically try to emulate RTC interrupt
> >                     functions in software using HPET counter 1.
> > 
> 
> This is very wrong IMO. We shouldn't try to emulate the RTC interrupt
> for the kernel, instead the HPET should use native APIC interrupt
> routing.

Even on those machines where APIC interrupts are not usable?
(E.g. due to interactions with the SMM BIOS).

-- Jamie
