Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261767AbUBYXmp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 18:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261619AbUBYXjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 18:39:42 -0500
Received: from fw.osdl.org ([65.172.181.6]:43666 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261624AbUBYXg6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 18:36:58 -0500
Message-Id: <200402252336.i1PNape32490@mail.osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: cliff white <cliffw@osdl.org>, linux-kernel@vger.kernel.org,
       cliffw@osdl.org
Subject: Re: reaim - 2.6.3-mm1 IO performance down. 
In-Reply-To: Your message of "Tue, 24 Feb 2004 17:03:37 PST."
             <20040224170337.798f5766.akpm@osdl.org> 
Date: Wed, 25 Feb 2004 15:36:51 -0800
From: Cliff White <cliffw@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> cliff white <cliffw@osdl.org> wrote:
> >
> > For the same test on the same machine, results from 2.6.2-rc1-mm2 and 2.6.2
> -rc3-mm1
> > were within 1.0% of the linux-2.6.2 runs. So this is new. 
> > 
> > More data and tests if requested - are there some patch sets we should try 
> reverting?
> 
> Thanks.  You could try reverting adaptive-lazy-readahead.patch.  If it is
> not that I'd be suspecting CPU scheduler changes.  Do you have uniprocessor
> test results?

adaptive-lazy-readahead reverted, not really much change here:
Kernel          Users      JPM        Run Time
2.6.3		60         10327.87   34.16 seconds
2.6.3-mm1	60         8279.75    42.61 seconds
2.6.3-mm1-noalr 60	   7731.76    45.63 seconds

2.6.3		80         10275.23   45.78 seconds
2.6.3-mm1	80         7841.31    59.99 seconds
2.6.3-mm1-noalr 80         8565.19    54.92 seconds

Full details, reaim tarball:
http://developer.osdl.org/cliffw

cliffw


> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
