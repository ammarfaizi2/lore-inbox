Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263126AbUEKAZl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263126AbUEKAZl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 20:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262468AbUEKAZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 20:25:36 -0400
Received: from agminet04.oracle.com ([141.146.126.231]:39132 "EHLO
	agminet04.oracle.com") by vger.kernel.org with ESMTP
	id S262438AbUEKAZA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 20:25:00 -0400
Date: Mon, 10 May 2004 17:24:27 -0700
From: Wim Coekaerts <wim.coekaerts@oracle.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Chris Wedgwood <cw@f00f.org>, hch@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm1
Message-ID: <20040511002426.GD1105@ca-server1.us.oracle.com>
References: <20040510024506.1a9023b6.akpm@osdl.org> <20040510223755.A7773@infradead.org> <20040510150203.3257ccac.akpm@osdl.org> <20040510231146.GA5168@taniwha.stupidest.org> <20040510162818.376b4a55.akpm@osdl.org> <20040510233342.GA5614@taniwha.stupidest.org> <20040510165132.5107472e.akpm@osdl.org> <20040510235312.GA9348@taniwha.stupidest.org> <20040510171413.6c1699b8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040510171413.6c1699b8.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Migrating away from this will require work from vendors, Oracle, PAM
> developers, /bin/login and /bin/su developers.  Until that has happened I
> think we should arrange for vendor kernels and kernel.org kernels to offer
> the same interfaces.

We have done the work and are going to be ok going forward to just use
hugeltbfs directly, just mounting it with right uid,gid. the main issue
of course is the existing stuff out there and the fact that upgrades
from 2.4 to 2.6 would be a tad more nasty if we had to change so much
stuff around. it's never really a problem if we have advanced warning
and work towards stuff, it's a problem when we rely on stuff that exists
and then it gets pulled out underneath.

> And I don't think pulling the feature out of kernel.org kernels will
> provide any added stimulus, frankly.  They'll just ship the hack and go off
> to do something else.

at least we will make the change ;)

> If someone had done the kernel and userspace work 6-12 months ago then
> sure, we wouldn't be in this situation.

right we did the work based on what we were given, shm_hugetlb, was
quite painless. I think the start of this problem in particular was the
bigpages hack that started 2 years ago.

Wim

