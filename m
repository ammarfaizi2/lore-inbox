Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263530AbSITUkr>; Fri, 20 Sep 2002 16:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263546AbSITUkq>; Fri, 20 Sep 2002 16:40:46 -0400
Received: from holomorphy.com ([66.224.33.161]:65417 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S263530AbSITUkp>;
	Fri, 20 Sep 2002 16:40:45 -0400
Date: Fri, 20 Sep 2002 13:39:38 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Hanna Linder <hannal@us.ibm.com>
Cc: Maneesh Soni <maneesh@in.ibm.com>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org, viro@math.psu.edu
Subject: Re: 2.5.36-mm1 dbench 512 profiles
Message-ID: <20020920203938.GL3530@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Hanna Linder <hannal@us.ibm.com>, Maneesh Soni <maneesh@in.ibm.com>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
	viro@math.psu.edu
References: <20020919223007.GP28202@holomorphy.com> <68630000.1032477517@w-hlinder> <3D8A5FE6.4C5DE189@digeo.com> <20020920000815.GC3530@holomorphy.com> <200209200747.g8K7la9B174532@northrelay01.pok.ibm.com> <20020920080628.GK3530@holomorphy.com> <20020920120358.GV28202@holomorphy.com> <61200000.1032547873@w-hlinder>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <61200000.1032547873@w-hlinder>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2002 at 11:51:13AM -0700, Hanna Linder wrote:
> 	I mentioned it at OLS too. It was the point of my talk. Next
> 	time I will request a non 10am time slot!

10AM is relatively early in the morning for me. =)


On Friday, September 20, 2002 05:03:58 -0700 William Lee Irwin III <wli@holomorphy.com> wrote:
>> take its place. Ugly. OTOH the qualitative difference is striking. The
>> interactive responsiveness of the machine, even when entirely unloaded,
>> is drastically improved, along with such nice things as init scripts
>> and kernel compiles also markedly faster. I suspect this is just the
>> wrong benchmark to show throughput benefits with.
>> Also notable is that the system time was significantly reduced though
>> I didn't log it. Essentially a long period of 100% system time is
>> entered after a certain point in the benchmark, during which there are
>> few (around 60 or 70) context switches in a second, and the duration
>> of this period was shortened.

On Fri, Sep 20, 2002 at 11:51:13AM -0700, Hanna Linder wrote:
> 	Bill, you are saying that replacing dcache_rcu significantly
> 	improved system response time among other things? 
> 	Perhaps it is time to reconsider replacing fastwalk with dcache_rcu. 
> 	Viro? What are your objections?

Basically, the big ones get laggy, and laggier with more cpus. This fixed
a decent amount of that.

Another thing to note is that the max bandwidth of these disks is 40MB/s,
so we're running pretty close to peak anyway. I need to either get an FC
cable or something to see larger bandwidth gains.


Cheers,
Bill
