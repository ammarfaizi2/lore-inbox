Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265714AbTIFBcY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 21:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265716AbTIFBcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 21:32:24 -0400
Received: from dyn-ctb-203-221-72-243.webone.com.au ([203.221.72.243]:9476
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S265714AbTIFBcW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 21:32:22 -0400
Message-ID: <3F59390F.8070902@cyberone.com.au>
Date: Sat, 06 Sep 2003 11:31:59 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: Mike Fedyk <mfedyk@matchmail.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Nick's scheduler policy v12
References: <3F58CE6D.2040000@cyberone.com.au> <195560000.1062788044@flay>	 <20030905202232.GD19041@matchmail.com> <207340000.1062793164@flay>	 <20030905203903.GF19041@matchmail.com> <1062796123.1436.4.camel@boobies.awol.org>
In-Reply-To: <1062796123.1436.4.camel@boobies.awol.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Robert Love wrote:

>On Fri, 2003-09-05 at 16:39, Mike Fedyk wrote:
>
>
>>Exactly.  Because the larger time slices for lower nice values came from
>>O(1), not Con.
>>
>
>The larger timeslices may not help, but one reason why renicing X hurts
>multimedia is that it gives a preference to the GUI over the multimedia
>thread(s).
>
>Look at it this way.  Assume renicing X does not _help_ whatever the
>problem is (simply because the problem, in this case, is not stemming
>from X).  Then giving X the higher priority and larger timeslice only
>adversely affects the problem.
>
>So, since the multimedia thread in (say) xmms is really unrelated to X
>(its a separate thread and not doing any Xlib calls), it just hurts it.
>

Hi Robert,
Yeah you are right. Backboost is sort of an implicit renice though,
except it doesn't always go where you want it or when you want :(

I have found that is enough to have good scheduling latency to ensure
xmms skips are difficult to produce.


