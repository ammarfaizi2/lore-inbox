Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263150AbTJPVni (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 17:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263152AbTJPVm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 17:42:27 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:52997 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263256AbTJPVlj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 17:41:39 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: [PATCH][2.6] No swapping on memory backed swapfiles
Date: 16 Oct 2003 21:31:46 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bmn2o2$il9$1@gatekeeper.tmr.com>
References: <20031013011117.103de5e7.akpm@osdl.org> <200310130832.h9D8WJ4g000157@81-2-122-30.bradfords.org.uk>
X-Trace: gatekeeper.tmr.com 1066339906 19113 192.168.12.62 (16 Oct 2003 21:31:46 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200310130832.h9D8WJ4g000157@81-2-122-30.bradfords.org.uk>,
John Bradford  <john@grabjohn.com> wrote:
| Quote from Andrew Morton <akpm@osdl.org>:
| > Zwane Mwaikambo <zwane@arm.linux.org.uk> wrote:
| > >
| > > +	bdi = mapping->backing_dev_info;
| > >  +	if (bdi->memory_backed)
| > >  +		goto bad_swap;
| > >  +
| > 
| > I guess that makes sense, although someone might want to swap onto a
| > ramdisk-backed file just for some testing purpose.
| 
| Or because some RAM is slower than the rest.  This came up a while ago
| on the list.

Something on my "learn how to..." list, I have some systems which are
setup to cache only the first 64MB, and I bet they would run a lot
faster if the rest were used as swap. It is definitely faster with
mem=64 than letting the CPU beat the whole memory.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
