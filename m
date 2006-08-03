Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932345AbWHCHBQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345AbWHCHBQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 03:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932346AbWHCHBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 03:01:16 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:10415 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932345AbWHCHBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 03:01:15 -0400
Date: Thu, 3 Aug 2006 16:03:28 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net,
       kmannth@us.ibm.com, y-goto@jp.fujitsu.com
Subject: Re: [PATCH] memory hotadd fixes [1/5] not-aligned memory hotadd
 handling fix
Message-Id: <20060803160328.f66dcfd2.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060802233802.8186eb38.akpm@osdl.org>
References: <20060803123039.c50feb85.kamezawa.hiroyu@jp.fujitsu.com>
	<20060802233802.8186eb38.akpm@osdl.org>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Aug 2006 23:38:02 -0700
Andrew Morton <akpm@osdl.org> wrote:

> On Thu, 3 Aug 2006 12:30:39 +0900
> KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:
> 
> > After Keith's report of memory hotadd failure, I increased test patterns.
> > These patches are a result of new patterns. But I cannot cover all existing
> > memory layout in the world, more tests are needed.
> > Now, I think my patch can make things better and want this codes to be tested
> > in -mm.patche series is consitsts of 5 patches.
> 
> I expect the code which these patches touch is completely untested in -mm, so
> all we'll get is compile testing and some review.
> 
yes.. just tested on my emulation box with some patterns, including patterns in
hot-add-failure report.(very small chunks in one section, and very big contiguous
memory hot add and unaligned memory hot-add.)

> Given that these patches touch pretty much nothing but the memory hot-add
> paths I'd be inclined to fast-track them into 2.6.18. 
> Do you agree that these patches are sufficiently safe and that the problems 
> that they solve are sufficiently serious for us to take that approach?
> 
I think this patch fixes serious problems. This patch can enlarge memory-hot-add
supported hardware. And fast-track paths sounds attractiveto me.
But I want more tests and reviews.
I posted this 3 weeks ago to -lhms but no positive/negative answers from the list.

Thanks,
-Kame

