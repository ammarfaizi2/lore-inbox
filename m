Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267411AbUHDUhk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267411AbUHDUhk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 16:37:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267415AbUHDUhk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 16:37:40 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:34279 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267414AbUHDUh3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 16:37:29 -0400
Date: Wed, 04 Aug 2004 13:36:36 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Andrew Morton <akpm@osdl.org>, kernel@kolivas.org,
       linux-kernel@vger.kernel.org, Rick Lindsley <ricklind@us.ibm.com>
Subject: Re: 2.6.8-rc2-mm2 performance improvements (scheduler?)
Message-ID: <216720000.1091651795@flay>
In-Reply-To: <20040804201019.GA25908@elte.hu>
References: <20040804122414.4f8649df.akpm@osdl.org> <211490000.1091648060@flay> <20040804201019.GA25908@elte.hu>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Wednesday, August 04, 2004 22:10:19 +0200 Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Martin J. Bligh <mbligh@aracnet.com> wrote:
> 
>> >>  SDET 16  (see disclaimer)
>> >>                             Throughput    Std. Dev
>> >>                      2.6.7       100.0%         0.3%
>> >>                  2.6.8-rc2        99.5%         0.3%
>> >>              2.6.8-rc2-mm2       118.5%         0.6%
>> > 
>> > hum, interesting.  Can Con's changes affect the inter-node and inter-cpu
>> > balancing decisions, or is this all due to caching effects, reduced context
>> > switching etc?
> 
> Martin, could you try 2.6.8-rc2-mm2 with staircase-cpu-scheduler 
> unapplied a re-run at least part of your tests?
> 
> there are a number of NUMA improvements queued up on -mm, and it would
> be nice to know what effect these cause, and what effect the staircase
> scheduler has.

Sure. I presume it's just the one patch:

staircase-cpu-scheduler-268-rc2-mm1.patch

which seemed to back out clean and is building now. Scream if that's not
all of it ...

M.

