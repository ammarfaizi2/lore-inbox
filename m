Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262181AbSKDR2l>; Mon, 4 Nov 2002 12:28:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262197AbSKDR2l>; Mon, 4 Nov 2002 12:28:41 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:15073 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262181AbSKDR2l>;
	Mon, 4 Nov 2002 12:28:41 -0500
Date: Mon, 04 Nov 2002 09:29:14 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: woofwoof@hathway.com, Andrew Morton <akpm@digeo.com>
cc: dipankar@in.ibm.com, Maneesh Soni <maneesh@in.ibm.com>,
       Al Viro <viro@math.psu.edu>, LKML <linux-kernel@vger.kernel.org>,
       Anton Blanchard <anton@au1.ibm.com>,
       Paul McKenney <paul.mckenney@us.ibm.com>
Subject: Re: dcache_rcu [performance results]
Message-ID: <1025970000.1036430954@flay>
In-Reply-To: <20021102144306.A6736@dikhow>
References: <20021030161912.E2613@in.ibm.com> <20021031162330.B12797@in.ibm.com> <3DC32C03.C3910128@digeo.com> <20021102144306.A6736@dikhow>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Clearly dcache_lock is the killer when 'ps' command is used in
> the benchmark. My guess (without looking at 'ps' code) is that
> it has to open/close a lot of files in /proc and that increases
> the number of acquisitions of dcache_lock. Increased # of acquisition
> add to cache line bouncing and contention.

Strace it - IIRC it does 5 opens per PID. Vomit.

M.

