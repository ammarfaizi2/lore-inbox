Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263720AbTDNUyM (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 16:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263737AbTDNUyM (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 16:54:12 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:4011 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S263720AbTDNUyK (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 16:54:10 -0400
Date: Mon, 14 Apr 2003 13:55:40 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Dave Jones <davej@codemonkey.org.uk>
cc: Andrew Morton <akpm@digeo.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: BUGed to death
Message-ID: <92940000.1050353740@flay>
In-Reply-To: <20030414210006.GA7831@suse.de>
References: <80690000.1050351598@flay> <20030414210006.GA7831@suse.de>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  > Seems all these bug checks are fairly expensive. I can get 1%
>  > back on system time for kernel compiles by changing BUG to 
>  > "do {} while (0)" to make them all compile away. Profiles aren't
>  > very revealing though ... seems to be within experimental error ;-(
>  > 
>  > I was pondering CONFIG_RUN_WILD_NAKED_AND_FREE
> 
> The sort of folks who would worry about that very last 1% are the
> sort of people that would more than likely hit these BUGs as they're
> really stressing things.
> 
> Losing a bunch of potential reports (and possibly doing bad things),
> in the name of a 1% performance boost doesn't sound too productive to me.

True - however I should have included some more info ... Andrew worked
out that some of the hottest ones lead to a null ptr dereference
immediately afterwards anyways, so they're actually pointless.

I wasn't seriously suggesting just removing all of them, was just a point
of interest for some things that would be worth looking at ;-)

I'd agree with you that an unreliable system is 100% slower than a working
one ;-)

M.
