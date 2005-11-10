Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750966AbVKJOnU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750966AbVKJOnU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 09:43:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750967AbVKJOnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 09:43:20 -0500
Received: from styx.suse.cz ([82.119.242.94]:61116 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1750965AbVKJOnU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 09:43:20 -0500
Date: Thu, 10 Nov 2005 15:43:17 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andi Kleen <ak@suse.de>
Cc: Jan Beulich <JBeulich@novell.com>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org
Subject: Re: [PATCH 13/39] NLKD/x86-64 - time adjustment
Message-ID: <20051110144317.GC7342@ucw.cz>
References: <43720DAE.76F0.0078.0@novell.com> <4372105B.76F0.0078.0@novell.com> <437210D1.76F0.0078.0@novell.com> <200511101419.03838.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511101419.03838.ak@suse.de>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2005 at 02:19:03PM +0100, Andi Kleen wrote:
 
> Please remove the ifdefs too.  64bit HPET support would be fine, but 
> only as a runtime mechanism, not compile time.
> 
> Can you remove debugger_jiffies please? 
> The code has to handle long delays anyways (e.g. if someone uses a target
> probe), so we cannot rely on such hacks anyways.
> 
> I don't quite understand why the SMP case should be different from UP
> in that ifdef. Can you explain?  It shouldn't in theory.
> 
> 
> /* When the TSC gets reset during AP startup, the code below would
> +			   incorrectly think we lost a huge amount of ticks. */
> That is outdated - the TSCs are not reset anymore since 2.6.12.
> Please remove code for handling that.
> 
> The union in vxtime_data is ugly - can it be avoided?
> 
> Vojtech should probably review that one too when you repost.
 
I'd like to take a look at the patch as it is, but it seems my spam
filter ate it, and LKML.org doesn't archive binary attachments.

I've done some work on making x86-64 time handling overflow save in the
last few days, so I'm quite interested in what you needed to change.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
