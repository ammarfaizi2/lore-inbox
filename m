Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316768AbSH2VeO>; Thu, 29 Aug 2002 17:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319281AbSH2VeO>; Thu, 29 Aug 2002 17:34:14 -0400
Received: from holomorphy.com ([66.224.33.161]:30085 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S316768AbSH2VeN>;
	Thu, 29 Aug 2002 17:34:13 -0400
Date: Thu, 29 Aug 2002 14:38:30 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [PATCH] low-latency zap_page_range()
Message-ID: <20020829213830.GG888@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@zip.com.au>, Robert Love <rml@tech9.net>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <3D6E844C.4E756D10@zip.com.au> <1030653602.939.2677.camel@phantasy> <3D6E8B25.425263D5@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <3D6E8B25.425263D5@zip.com.au>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
>> unless we
>> wanted to unconditionally drop the locks and let preempt just do the
>> right thing and also reduce SMP lock contention in the SMP case.

On Thu, Aug 29, 2002 at 01:59:17PM -0700, Andrew Morton wrote:
> That's an interesting point.  page_table_lock is one of those locks
> which is occasionally held for ages, and frequently held for a short
> time.
> I suspect that yes, voluntarily popping the lock during the long holdtimes
> will allow other CPUs to get on with stuff, and will provide efficiency
> increases.  (It's a pretty lame way of doing that though).
> But I don't recall seeing nasty page_table_lock spintimes on
> anyone's lockmeter reports, so...

You will. There are just bigger fish to fry at the moment.


Cheers,
Bill
