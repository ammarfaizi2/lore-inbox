Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964793AbVKLUoa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964793AbVKLUoa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 15:44:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964795AbVKLUoa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 15:44:30 -0500
Received: from styx.suse.cz ([82.119.242.94]:17076 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S964793AbVKLUo3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 15:44:29 -0500
Date: Sat, 12 Nov 2005 21:44:28 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andi Kleen <ak@suse.de>
Cc: Jan Beulich <JBeulich@novell.com>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org
Subject: Re: [PATCH 13/39] NLKD/x86-64 - time adjustment
Message-ID: <20051112204428.GA14733@midnight.suse.cz>
References: <43720DAE.76F0.0078.0@novell.com> <200511110312.15616.ak@suse.de> <20051112092200.GA7997@midnight.suse.cz> <200511121821.11552.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511121821.11552.ak@suse.de>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 12, 2005 at 06:21:11PM +0100, Andi Kleen wrote:
> On Saturday 12 November 2005 10:22, Vojtech Pavlik wrote:
> 
> > Is there any advantage to using 64-bit HPET? 
> 
> Yes - it can tolerate long delays between ticks, e.g. caused by noidletick / 
> debuggers / target probes / smm etc. At least the first case will be fairly
> important soon.

A 32-bit 14 MHz HPET counter will overflow in approximately 5 minutes. I
don't think going 64-bit makes sense for noidletick, but for debuggers,
etc, it could make a good sense indeed.

> > It's read is even slower 
> 
> Why? The read should be on cache line granuality and there shouldn't
> be any difference in theory.
 
I'll try to measure this. Indeed, in theory there shouldn't be a
significant difference.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
