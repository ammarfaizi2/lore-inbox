Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161079AbVKDGQr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161079AbVKDGQr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 01:16:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161080AbVKDGQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 01:16:46 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:53457 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1161079AbVKDGQq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 01:16:46 -0500
Date: Thu, 3 Nov 2005 22:16:09 -0800
From: bron@bronze.corp.sgi.com (Bron Nelson)
Message-Id: <200511040616.WAA21225@bronze.corp.sgi.com>
To: Paul Jackson <pj@sgi.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Cc: lhms-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, kravetz@us.ibm.com, mbligh@mbligh.org,
       mel@csn.ul.ie, haveblue@us.ibm.com, kamezawa.hiroyu@jp.fujitsu.com,
       mingo@elte.hu, gh@us.ibm.com, nickpiggin@yahoo.com.au, rob@landley.net,
       jdike@addtoit.com, pbadari@gmail.com
References: <E1EXEfW-0005ON-00@w-gerrit.beaverton.ibm.com>
    <200511021747.45599.rob@landley.net> <43699573.4070301@yahoo.com.au>
    <200511030007.34285.rob@landley.net>
    <20051103163555.GA4174@ccure.user-mode-linux.org>
    <1131035000.24503.135.camel@localhost.localdomain>
    <20051103205202.4417acf4.akpm@osdl.org> <20051103213538.7f037b3a.pj@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I was kind of thinking that the stats should be per-process (actually
> per-mm) rather than bound to cpusets.  /proc/<pid>/pageout-stats or something.

The particular people that I deal with care about constraining things
on a per-cpuset basis, so that is the information that I personally am
looking for.  But it is simple enough to map tasks to cpusets and vice-versa,
so this is not really a serious consideration.  I would generically be in
favor of the per-process stats (even though the application at hand is
actually interested in the cpuset aggregate stats), because we can always
produce an aggregate from the detailed, but not vice-versa.  And no doubt
some future as-yet-unimagined application will want per-process info.


--
Bron Campbell Nelson      bron@sgi.com
These statements are my own, not those of Silicon Graphics.
