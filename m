Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261274AbSIZNM2>; Thu, 26 Sep 2002 09:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261281AbSIZNM2>; Thu, 26 Sep 2002 09:12:28 -0400
Received: from holomorphy.com ([66.224.33.161]:26021 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261274AbSIZNM1>;
	Thu, 26 Sep 2002 09:12:27 -0400
Date: Thu, 26 Sep 2002 06:17:40 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: Andrew Morton <akpm@digeo.com>, lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: 2.5.38-mm3
Message-ID: <20020926131740.GP3530@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Dipankar Sarma <dipankar@in.ibm.com>,
	Andrew Morton <akpm@digeo.com>, lkml <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
References: <3D92BE07.B6CDFE54@digeo.com> <20020926175445.B18906@in.ibm.com> <20020926122909.GN3530@holomorphy.com> <20020926181052.C18906@in.ibm.com> <20020926124244.GO3530@holomorphy.com> <20020926183558.D18906@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020926183558.D18906@in.ibm.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2002 at 05:42:44AM -0700, William Lee Irwin III wrote:
>> This is only aggravated by cacheline bouncing on SMP. The reductions
>> of system cpu time will doubtless be beneficial for all.

On Thu, Sep 26, 2002 at 06:35:58PM +0530, Dipankar Sarma wrote:
> On SMP, I would have thought that only sharing the fd table
> while cloning tasks (CLONE_FILES) affects performance by bouncing the rwlock
> cache line. Are there a lot of common workloads where this happens ?
> Anyway the files_struct_rcu patch for 2.5.38 is up at
> http://sourceforge.net/project/showfiles.php?group_id=8875&release_id=112473

It looks very unusual, but it is very real. Some of my prior profile
results show this. I'll run a before/after profile with this either
tonight or tomorrow night (it's 6:06AM PST here -- tonight is unlikely).


Cheers,
Bill
