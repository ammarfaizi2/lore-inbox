Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261297AbTHSWlY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 18:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261306AbTHSWlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 18:41:24 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:31140 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S261297AbTHSWlU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 18:41:20 -0400
Date: Wed, 20 Aug 2003 00:41:04 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>
Subject: Re: [PATCH][2.6][5/5]Support for HPET based timer
Message-ID: <20030819224104.GB13346@ucw.cz>
References: <C8C38546F90ABF408A5961FC01FDBF1902C7D1C7@fmsmsx405.fm.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C8C38546F90ABF408A5961FC01FDBF1902C7D1C7@fmsmsx405.fm.intel.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 19, 2003 at 12:20:22PM -0700, Pallipadi, Venkatesh wrote:

> 5/5 - hpet5.patch - This can be a standalone patch. Without this
>                     patch we loose interrupt generation capability
>                     of RTC (/dev/rtc), due to HPET. With this patch
>                     we basically try to emulate RTC interrupt
>                     functions in software using HPET counter 1.
> 

This is very wrong IMO. We shouldn't try to emulate the RTC interrupt
for the kernel, instead the HPET should use native APIC interrupt
routing. This way the RTC will keep working and the 'legacy mode' of
HPET doesn't need to be used. I must admit I was a bit lazy when I was
implementing the x86_64 variant and the native IRQ for HPET is still on
my to-do list.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
