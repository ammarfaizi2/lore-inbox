Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266555AbUGPPb7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266555AbUGPPb7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 11:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266554AbUGPPb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 11:31:59 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:32562 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S266555AbUGPPbt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 11:31:49 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Chris Wedgwood <cw@f00f.org>
Subject: Re: [PATCH] reduce inter-node balancing frequency
Date: Fri, 16 Jul 2004 11:30:44 -0400
User-Agent: KMail/1.6.2
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       John Hawkes <hawkes@sgi.com>
References: <200407151829.20069.jbarnes@engr.sgi.com> <200407161045.38983.jbarnes@engr.sgi.com> <20040716150418.GA5195@taniwha.stupidest.org>
In-Reply-To: <20040716150418.GA5195@taniwha.stupidest.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407161130.44616.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, July 16, 2004 11:04 am, Chris Wedgwood wrote:
> On Fri, Jul 16, 2004 at 10:45:38AM -0400, Jesse Barnes wrote:
> > For sn2 at least, there are quite a few ways we could dice up the
> > topology.  We'll have to experiment with things a bit to find some
> > good defaults.
>
> The PROM can export topology details so presumably there is enough to
> derive something sane on boot surely?

Yep, we should have all the information we need, it's just a matter of 
translating it into something useful.  Since routers tend to group together 
nodes in groups of 4 or 8, a node herd with that many nodes might make sense, 
but also might be too small.  We might want everything within a set of 
metarouters in a group instead, or in addition, or...

Jesse
