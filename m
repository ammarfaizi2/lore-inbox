Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264518AbTLQT2M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 14:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264519AbTLQT2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 14:28:12 -0500
Received: from holomorphy.com ([199.26.172.102]:21138 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264518AbTLQT2I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 14:28:08 -0500
Date: Wed, 17 Dec 2003 11:27:42 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Rik van Riel <riel@redhat.com>
Cc: Roger Luethi <rl@hellgate.ch>, Andrew Morton <akpm@osdl.org>,
       Andrea Arcangeli <andrea@suse.de>, kernel@kolivas.org,
       chris@cvine.freeserve.co.uk, linux-kernel@vger.kernel.org,
       mbligh@aracnet.com
Subject: Re: 2.6.0-test9 - poor swap performance on low end machines
Message-ID: <20031217192742.GB22443@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Rik van Riel <riel@redhat.com>, Roger Luethi <rl@hellgate.ch>,
	Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
	kernel@kolivas.org, chris@cvine.freeserve.co.uk,
	linux-kernel@vger.kernel.org, mbligh@aracnet.com
References: <20031216112307.GA5041@k3.hellgate.ch> <Pine.LNX.4.44.0312171351080.28701-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0312171351080.28701-100000@chimarrao.boston.redhat.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Dec 2003, Roger Luethi wrote:
>> One potential problem with the benchmarks is that my test box has
>> just one bar with 256 MB RAM. The kbuild and efax tests were run with
>> mem=64M and mem=32M, respectively. If the difference between mem=32M

On Wed, Dec 17, 2003 at 01:53:28PM -0500, Rik van Riel wrote:
> OK, I found another difference with 2.4.
> Try "echo 256 > /proc/sys/vm/min_free_kbytes", I think
> that should give the same free watermarks that 2.4 has.
> Using 1MB as the min free watermark for lowmem is bound
> to result in more free (and less used) memory on systems
> with less than 128 MB RAM ... significantly so on smaller
> systems.
> The fact that ZONE_HIGHMEM and ZONE_NORMAL are recycled
> at very different rates could also be of influence on
> some performance tests...

Limited sets of configurations may have left holes in the testing.
Upper zones much larger than lower zones basically want the things
to be unequal. It probably wants the replacement load spread
proportionally in general or some such nonsense.

-- wli
