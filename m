Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269738AbUHZVqw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269738AbUHZVqw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 17:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269725AbUHZVqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 17:46:04 -0400
Received: from holomorphy.com ([207.189.100.168]:409 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269697AbUHZVn6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 17:43:58 -0400
Date: Thu, 26 Aug 2004 14:43:50 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: jmerkey@comcast.net
Cc: Roland Dreier <roland@topspin.com>, linux-kernel@vger.kernel.org,
       jmerkey@drdos.com
Subject: Re: 1GB/2GB/3GB User Space Splitting Patch 2.6.8.1 (PSEUDO SPAM)
Message-ID: <20040826214350.GI2793@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	jmerkey@comcast.net, Roland Dreier <roland@topspin.com>,
	linux-kernel@vger.kernel.org, jmerkey@drdos.com
References: <082620042108.24853.412E5143000405FF000061152200748184970A059D0A0306@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <082620042108.24853.412E5143000405FF000061152200748184970A059D0A0306@comcast.net>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, my attribution was stripped from:
>> You're years late to this game. It's been thought about and the
>> consensus (which I disagreed with) was to reject virtualspace pressure
>> related changes of this kind for 32-bit platforms in favor of refusing
>> to support 32-bit platforms and/or workloads requiring them.

On Thu, Aug 26, 2004 at 09:08:19PM +0000, jmerkey@comcast.net wrote:
> This has nothing to do with only having 1GB of kernel address 
> space and not enough virtual space to load a large swath of drivers
> or support modules loading reentrantly.  It's a little difficult to
> quantify how much kernel address space will be needed when you don't
> know if a full configuration will fit into it.  The fact people use
> this patch at all is **EVIDENCE THAT THERE ALREADY IS A PROBLEM**
> with limiting kernel address space to 1GB.  And who the hell cares
> about a mouldy, antiquated ABI spec modeled after 1970 Unix technology
> anyway?  It should be another option for executable formats. All this
> ABI compatibility huey is some Intel/SCO pipe dream for supporting
> applications across multiple Unix platforms anyway. If it doesn't run
> on Linux, who the hell cares?
> :-)

Quoting placement  and linewrap are better, but it could still use
attributions. For instance, above your text that I quoted, I put:
"On Thu, Aug 26, 2004 at 09:08:19PM +0000, jmerkey@comcast.net wrote:"
which was actually generated automatically by my MUA, and similar above
text you quote would be helpful.

We already know there are problems surrounding virtualspace limitations
with respect to both efficiency and correctness. The "solutions" of
these kinds were not considered acceptable. To address these things in
general changes to common code to address virtualspace footprint issues
in a manner also benefitting 64-bit platforms are preferred to the full
exclusion of both static and dynamic kernel virtualspace inflation.
It's not a tremendously far-flung policy, though it limits the upper
range of memory sizes on legacy systems (32-bit with extended physical
addressing) that can be effectively supported by mainline somewhat.

In defense of my favorite company at the moment, Oracle does scale down
rather well to smaller system sizes within the limits of its own text's
memory footprint. I've successfully run OAST with as little as 256MB
RAM on my ia32-based laptop, at which point its ca. 50MB text footprint
is even a large proportion of memory. One should recall that the Oracle
database has a long history, and by virtue of such has run on very old
hardware configurations with very little RAM relative to modern systems,
so acquiring an acute awareness of its own memory footprint persisting
even to this day.

Also, SCO UNIX ABI emulation does exist in the form of iBCS, so there
is the further consideration of breaking that. Linux does in fact
emulate other OS's ABI's, so in the course of implementing ABI changes
one should also consider the ABI emulations affected by them.


-- wli
