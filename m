Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422634AbVLXI3j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422634AbVLXI3j (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Dec 2005 03:29:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422635AbVLXI3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Dec 2005 03:29:39 -0500
Received: from smtp.osdl.org ([65.172.181.4]:29846 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422634AbVLXI3i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Dec 2005 03:29:38 -0500
Date: Sat, 24 Dec 2005 00:29:30 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Michael Bishop <michael.bishop@APPIQ.com>
cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       hugh@veritas.com, nickpiggin@yahoo.com.au
Subject: RE: More info for DSM w/r/t sunffb on 2.6.15-rc6
In-Reply-To: <DF925A10E7204748977502BECE3D1123015C4DCE@exch02.appiq.com>
Message-ID: <Pine.LNX.4.64.0512240026580.14098@g5.osdl.org>
References: <DF925A10E7204748977502BECE3D1123015C4DCE@exch02.appiq.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 23 Dec 2005, Michael Bishop wrote:
>
>  Linus - I did not try out the memory.c patch, as the subsequent patch 
> from David looked like the simpler solution.

Yes, absolutely.

> Hopefully no other 'insane users' such as myself run into the same 
> problem; I suspect that there would have been a chorus of complaints by 
> now if it was evident in more prominent places. :-)

Note that by "insane users" I didn't mean the end-user sitting in front of 
the machine, but the actual _program_ (ie X) that does uses the kernel in 
insane ways.

So no need to check in at the asylym.

And yes, as X seems to have a sane fallback, we can definitely avoid my 
"allow insanity" patch. Much better to return an error for insane uses 
than to try to support them when there's no need.

Thanks for testing,

		Linus
