Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263563AbUCTWpS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 17:45:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263564AbUCTWpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 17:45:18 -0500
Received: from holomorphy.com ([207.189.100.168]:47497 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263563AbUCTWpO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 17:45:14 -0500
Date: Sat, 20 Mar 2004 14:45:00 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: rmk@arm.linux.org.uk, Andrew Morton <akpm@osdl.org>,
       Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
Message-ID: <20040320224500.GP2045@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	rmk@arm.linux.org.uk, Andrew Morton <akpm@osdl.org>,
	Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
	torvalds@osdl.org
References: <20040320133025.GH9009@dualathlon.random> <20040320144022.GC2045@holomorphy.com> <20040320150621.GO9009@dualathlon.random> <20040320121345.2a80e6a0.akpm@osdl.org> <20040320205053.GJ2045@holomorphy.com> <20040320222639.K6726@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040320222639.K6726@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 20, 2004 at 12:50:53PM -0800, William Lee Irwin III wrote:
>> There are other reasons for doing it, e.g. unusual TLB attributes
>> and/or unusual pagetable structures backing the virtual region. I don't
>> see anyone standing up and screaming for more functionality than cache
>> coherency and/or disablement now, so as far as I'm concerned,
>> remap_area_pages() (or rmk's stuff) kills the issue.

On Sat, Mar 20, 2004 at 10:26:39PM +0000, Russell King wrote:
> I'm no longer planning on this.  In fact, I see a future where I tell
> people who want to use sound on ARM to go screw themselves because
> there doesn't seem to be an acceptable solution to this problem.
> Of course, this will lead to dirty hacks by many people who *REQUIRE*
> sound to work, but I guess we just don't care about that.
> (Yes, I'm pissed off over this issue.)

This is the exact opposite of what I'd hoped come of this discussion.
ISTR something about remap_area_pages() missing several pieces, but
I pretty much need some kind of clarification to know what. Well, that,
and I presumed your fixups for ALSA were headed toward mainline
regardless after coping with whatever issue dwmw2 had (e.g. returning
pfn's or something).


-- wli
