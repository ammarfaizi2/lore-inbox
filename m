Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267300AbSLELV1>; Thu, 5 Dec 2002 06:21:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267301AbSLELV1>; Thu, 5 Dec 2002 06:21:27 -0500
Received: from holomorphy.com ([66.224.33.161]:22154 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267300AbSLELV0>;
	Thu, 5 Dec 2002 06:21:26 -0500
Date: Thu, 5 Dec 2002 03:28:44 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: yodaiken@fsmlabs.com
Cc: Dipankar Sarma <dipankar@in.ibm.com>, Andrew Morton <akpm@digeo.com>,
       Ravikiran G Thirumalai <kiran@in.ibm.com>, linux-kernel@vger.kernel.org,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [patch] kmalloc_percpu  -- 2 of 2
Message-ID: <20021205112844.GJ9882@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	yodaiken@fsmlabs.com, Dipankar Sarma <dipankar@in.ibm.com>,
	Andrew Morton <akpm@digeo.com>,
	Ravikiran G Thirumalai <kiran@in.ibm.com>,
	linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>
References: <20021204174209.A17375@in.ibm.com> <20021204174550.B17375@in.ibm.com> <3DEE58CB.737259DB@digeo.com> <20021205091217.A11438@in.ibm.com> <3DEED6FA.B179FAFD@digeo.com> <20021205162329.A12588@in.ibm.com> <20021205042312.A12616@hq.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021205042312.A12616@hq.fsmlabs.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2002 at 08:32:58PM -0800, Andrew Morton wrote:
>>> Where in the kernel is such a large number of 4-, 8- or 16-byte
>>> objects being used?

On Thu, Dec 05, 2002 at 04:23:29PM +0530, Dipankar Sarma wrote:
> > Well, kernel objects may not be that small, but one would expect
> > the per-cpu parts of the kernel objects to be sometimes small, often down to
> > a couple of counters counting statistics.

On Thu, Dec 05, 2002 at 04:23:12AM -0700, yodaiken@fsmlabs.com wrote:
> Doesn't your allocator increase chances of cache conflict on the same
> cpu ?

This is so; I'm personally far more concerned about ZONE_NORMAL space
consumption in the cacheline aligned case.


Bill
