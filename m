Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261474AbSITIHb>; Fri, 20 Sep 2002 04:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261619AbSITIHb>; Fri, 20 Sep 2002 04:07:31 -0400
Received: from holomorphy.com ([66.224.33.161]:8327 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261474AbSITIHa>;
	Fri, 20 Sep 2002 04:07:30 -0400
Date: Fri, 20 Sep 2002 01:06:28 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Maneesh Soni <maneesh@in.ibm.com>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       viro@math.psu.edu
Subject: Re: 2.5.36-mm1 dbench 512 profiles
Message-ID: <20020920080628.GK3530@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Maneesh Soni <maneesh@in.ibm.com>, Andrew Morton <akpm@digeo.com>,
	linux-kernel@vger.kernel.org, viro@math.psu.edu
References: <20020919223007.GP28202@holomorphy.com> <68630000.1032477517@w-hlinder> <3D8A5FE6.4C5DE189@digeo.com> <20020920000815.GC3530@holomorphy.com> <200209200747.g8K7la9B174532@northrelay01.pok.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <200209200747.g8K7la9B174532@northrelay01.pok.ibm.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Sep 2002 05:48:38 +0530, William Lee Irwin III wrote:
>> As far as the dcache goes, I'll stick to observing and reporting. I'll
>> rerun with dcache patches applied, though.

On Fri, Sep 20, 2002 at 01:29:28PM +0530, Maneesh Soni wrote:
> For a 32-way system fastwalk will perform badly from dcache_lock
> point of view, basically due to increased lock hold time.
> dcache_rcu-12 should reduce dcache_lock contention and hold time. The
> patch uses RCU infrastructer patch and read_barrier_depends patch.
> The patches are available in Read-Copy-Update section on lse site at
> http://sourceforge.net/projects/lse

ISTR Hubertus mentioning this at OLS, and it sounded like a problem to
me. I'm doing some runs with this to see if it fixes the problem.


Cheers,
Bill
