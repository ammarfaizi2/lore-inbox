Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268680AbUGXPkg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268680AbUGXPkg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 11:40:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268681AbUGXPkf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 11:40:35 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:37004 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S268680AbUGXPke (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 11:40:34 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [RFC] Patch for isolated scheduler domains
Date: Sat, 24 Jul 2004 11:40:28 -0400
User-Agent: KMail/1.6.2
Cc: Dimitri Sivanich <sivanich@sgi.com>, linux-kernel@vger.kernel.org,
       John Hawkes <hawkes@sgi.com>
References: <20040722164126.GB13189@sgi.com> <200407231603.09055.jbarnes@engr.sgi.com> <4101F2ED.3050208@yahoo.com.au>
In-Reply-To: <4101F2ED.3050208@yahoo.com.au>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407241140.29453.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, July 24, 2004 1:26 am, Nick Piggin wrote:
> You might have the theoretical problem of ending up with more than
> one disjoint top level domain (ie. no overlap, basically partitioning
> the CPUs).

Yes, we'll have several disjoint per-node cpu spans for a large system, but 
nearby nodes *will* overlap with more distant nodes than any given node, so I 
think we're covered, unless I'm misunderstanding something.

> No doubt you could come up with something provably correct, however
> it might just be good enough to examine the end result and check that
> it is good. At least while you test different configurations.

Right.  And ultimately, I think we'll want the hierarchy I mentioned in the 
comments, that'll cover us a little better I think.

Jesse
