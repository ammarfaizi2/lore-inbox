Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265163AbSIRCV4>; Tue, 17 Sep 2002 22:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265211AbSIRCV4>; Tue, 17 Sep 2002 22:21:56 -0400
Received: from holomorphy.com ([66.224.33.161]:46823 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S265163AbSIRCVz>;
	Tue, 17 Sep 2002 22:21:55 -0400
Date: Tue, 17 Sep 2002 19:22:42 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "David S. Miller" <davem@redhat.com>
Cc: mingo@elte.hu, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] lockless, scalable get_pid(), for_each_process() elimination, 2.5.35-BK
Message-ID: <20020918022242.GB23546@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"David S. Miller" <davem@redhat.com>, mingo@elte.hu,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0209180024090.30913-100000@localhost.localdomain> <20020918002240.GB2179@holomorphy.com> <20020917.182722.122084128.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020917.182722.122084128.davem@redhat.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: William Lee Irwin III <wli@holomorphy.com>
>    The issues addressed here are extremely important for the workloads I
>    must support.

On Tue, Sep 17, 2002 at 06:27:22PM -0700, David S. Miller wrote:
> Have you published test tools that emulate your workload?
> These would be very useful, probably to find problems even
> outside the scope of pid lookups.

By and large I've been using existing tools, for instance, multiple
tiobench instances to obtain a large task count. The test cases I've
had to construct by hand are generally meant to trigger pagetable OOM,
which I've been assigned to do something about. In general, I attempt
to simulate the VM and I/O characteristics of databases. Sometimes I
have to get a bit inventive, e.g. recent 2*dbench 512 on tmpfs test.


Thanks,
Bill
