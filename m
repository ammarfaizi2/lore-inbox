Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267403AbSKPXpb>; Sat, 16 Nov 2002 18:45:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267408AbSKPXpb>; Sat, 16 Nov 2002 18:45:31 -0500
Received: from tapu.f00f.org ([66.60.186.129]:22982 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S267403AbSKPXpb>;
	Sat, 16 Nov 2002 18:45:31 -0500
Date: Sat, 16 Nov 2002 15:52:29 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Dave Hansen <haveblue@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [lart] /bin/ps output
Message-ID: <20021116235229.GA32765@tapu.f00f.org>
References: <3DA798B6.9070400@us.ibm.com> <20021116092424.GY22031@holomorphy.com> <1037491895.24777.26.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1037491895.24777.26.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 17, 2002 at 12:11:35AM +0000, Alan Cox wrote:

> Bill - so what happens if you trim down the aio, event and ksoftirqd
> threads to a sane size (you might also want to do something about
> the fact 2.5 still runs ksoftirq too easily). Intuitively I'd go for
> a square root of the number of processors + 1 sort of function but
> what do the benchmarks say ?

IMO having various threads per-CPU is getting silly for (say) 4+
CPUs.  Even for two CPUs it means quite a good number of kernel
threads.

Does anyone really know for certain that this is necessary versus
having few per-CPU threads calling into state-machine functions?



  --cw
