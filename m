Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261503AbUCSCz6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 21:55:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261646AbUCSCz5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 21:55:57 -0500
Received: from holomorphy.com ([207.189.100.168]:53378 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261503AbUCSCz4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 21:55:56 -0500
Date: Thu, 18 Mar 2004 18:55:49 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Jesse Barnes <jbarnes@sgi.com>
Cc: linux-kernel@vger.kernel.org, colpatch@us.ibm.com, mbligh@aracnet.com,
       akpm@osdl.org, haveblue@us.ibm.com
Subject: Re: [PATCH] Introduce nodemask_t ADT [0/7]
Message-ID: <20040319025549.GM2045@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Jesse Barnes <jbarnes@sgi.com>, linux-kernel@vger.kernel.org,
	colpatch@us.ibm.com, mbligh@aracnet.com, akpm@osdl.org,
	haveblue@us.ibm.com
References: <1079651064.8149.158.camel@arrakis> <200403181523.10670.jbarnes@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403181523.10670.jbarnes@sgi.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2004 at 03:23:10PM -0800, Jesse Barnes wrote:
> My hero! :)  I think this has been needed for awhile, but now that I
> think about it, it begs the question of what a node is.  Is it a set
> of CPUs and blocks of memory (that seems to be the most commonly used
> definition in the code), just memory, just CPUs, or what?  On sn2
> hardware, we have the concept of a node without CPUs.  And due to our
> wacky I/O layout, we also have nodes without CPUs *or* memory!  (The
> I/O guys call these "ionodes".)  And then of course, there are CPUs
> that aren't particularly close to any memory (i.e. they have none of
> their own, and have to go several hops and/or through other CPUs to
> get at memory at all).
> I'll take a look at the ia64 bits when I get them (I've only received
> two of the seven patches thus far).

You need a tripartite graph.
(a) are connections full or half duplex? (i.e. directed or undirected)
(b) do you need distinct weights on each edge? (i.e. weighted or unweighted)


-- wli
