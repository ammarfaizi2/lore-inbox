Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754598AbWKHRVO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754598AbWKHRVO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 12:21:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753271AbWKHRVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 12:21:14 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:55732 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1754598AbWKHRVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 12:21:13 -0500
Date: Wed, 8 Nov 2006 09:21:06 -0800
From: Paul Jackson <pj@sgi.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: clameter@sgi.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Avoid allocating during interleave from almost full nodes
Message-Id: <20061108092106.1d3a2971.pj@sgi.com>
In-Reply-To: <1163005750.14238.19.camel@twins>
References: <Pine.LNX.4.64.0611031256190.15870@schroedinger.engr.sgi.com>
	<20061103134633.a815c7b3.akpm@osdl.org>
	<Pine.LNX.4.64.0611031353570.16486@schroedinger.engr.sgi.com>
	<20061103143145.85a9c63f.akpm@osdl.org>
	<20061103172605.e646352a.pj@sgi.com>
	<20061103174206.53f2c49e.akpm@osdl.org>
	<20061104025128.ca3c9859.pj@sgi.com>
	<Pine.LNX.4.64.0611060854000.25351@schroedinger.engr.sgi.com>
	<20061108022136.3b9b0748.pj@sgi.com>
	<1162999085.14238.17.camel@twins>
	<20061108090644.f23d37de.pj@sgi.com>
	<1163005750.14238.19.camel@twins>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter wrote:
> I was just hoping we could come up with 1 vm-time

Eh - why?

At least for secondary uses such as this, marking little node local
caches stale, so we are forced to refresh them occassionally, I'd
almost as soon avoid beating with other activity, and keeping the
affect rather like background white noise.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
