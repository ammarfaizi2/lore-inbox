Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271289AbTHCVsC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 17:48:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271283AbTHCVsC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 17:48:02 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:43139 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S271289AbTHCVrj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 17:47:39 -0400
Date: Sun, 3 Aug 2003 23:47:38 +0200
From: bert hubert <ahu@ds9a.nl>
To: David Lang <david.lang@digitalinsight.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, devik@cdi.cz,
       aebr@win.tue.nl
Subject: Re: [PATCH] Allow /dev/{,k}mem to be disabled to prevent kernel from being modified easily
Message-ID: <20030803214738.GA16129@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	David Lang <david.lang@digitalinsight.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	devik@cdi.cz, aebr@win.tue.nl
References: <20030803140031.7665546c.akpm@osdl.org> <Pine.LNX.4.44.0308031425100.24695-100000@dlang.diginsite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308031425100.24695-100000@dlang.diginsite.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 03, 2003 at 02:33:01PM -0700, David Lang wrote:

> we already have the option to not support modules (as Alan Cox points out
> every time that subject comes up it can be bypassed by people who have
> access to /dev/*mem) so it would seem that adding the option to bar access
> to /dev/*mem as well would make exisitng config options mean what they
> appear to mean.

This was also on my mind, yes. As Wichert said, not all holes are closed
then, there is also /dev/microcode, iopl() and more.

However, perhaps we could all sweep them under the "don't allow userspace to
touch kernel memory easily" banner?

We can leave more finegrained tools to outside patchsets then.

I think root will always be able to figure out a way to get into the
kernel's innards, but we can raise the bar quite a lot easily without too
much infrastructure.

As to what Alan said about LSM, I've yet to see how to do that in a
reasonable way. But I didn't look too hard.

As to what Andries said, how about '/proc/sys/raw_memory_access'?

Thanks.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
