Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267290AbSLELRI>; Thu, 5 Dec 2002 06:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267291AbSLELRH>; Thu, 5 Dec 2002 06:17:07 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:26830 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S267290AbSLELRF>;
	Thu, 5 Dec 2002 06:17:05 -0500
Date: Thu, 5 Dec 2002 04:23:12 -0700
From: yodaiken@fsmlabs.com
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: Andrew Morton <akpm@digeo.com>, Ravikiran G Thirumalai <kiran@in.ibm.com>,
       linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [patch] kmalloc_percpu  -- 2 of 2
Message-ID: <20021205042312.A12616@hq.fsmlabs.com>
References: <20021204174209.A17375@in.ibm.com> <20021204174550.B17375@in.ibm.com> <3DEE58CB.737259DB@digeo.com> <20021205091217.A11438@in.ibm.com> <3DEED6FA.B179FAFD@digeo.com> <20021205162329.A12588@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021205162329.A12588@in.ibm.com>; from dipankar@in.ibm.com on Thu, Dec 05, 2002 at 04:23:29PM +0530
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, Dec 05, 2002 at 04:23:29PM +0530, Dipankar Sarma wrote:
> Hi Andrew,
> 
> On Wed, Dec 04, 2002 at 08:32:58PM -0800, Andrew Morton wrote:
> > Where in the kernel is such a large number of 4-, 8- or 16-byte
> > objects being used?
> 
> Well, kernel objects may not be that small, but one would expect
> the per-cpu parts of the kernel objects to be sometimes small, often down to
> a couple of counters counting statistics.


Doesn't your allocator increase chances of cache conflict on the same
cpu ?

