Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267509AbUHDXfO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267509AbUHDXfO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 19:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267510AbUHDXfO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 19:35:14 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:61852 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267509AbUHDXfF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 19:35:05 -0400
Date: Wed, 04 Aug 2004 16:34:12 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Andrew Morton <akpm@osdl.org>, kernel@kolivas.org,
       linux-kernel@vger.kernel.org, Rick Lindsley <ricklind@us.ibm.com>
Subject: Re: 2.6.8-rc2-mm2 performance improvements (scheduler?)
Message-ID: <235040000.1091662452@flay>
In-Reply-To: <20040804213113.GA29434@elte.hu>
References: <20040804122414.4f8649df.akpm@osdl.org> <211490000.1091648060@flay> <20040804201019.GA25908@elte.hu> <216720000.1091651795@flay> <20040804213113.GA29434@elte.hu>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Wednesday, August 04, 2004 23:31:13 +0200 Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Martin J. Bligh <mbligh@aracnet.com> wrote:
> 
>> > Martin, could you try 2.6.8-rc2-mm2 with staircase-cpu-scheduler 
>> > unapplied a re-run at least part of your tests?
>> > 
>> > there are a number of NUMA improvements queued up on -mm, and it would
>> > be nice to know what effect these cause, and what effect the staircase
>> > scheduler has.
>> 
>> Sure. I presume it's just the one patch:
>> 
>> staircase-cpu-scheduler-268-rc2-mm1.patch
>> 
>> which seemed to back out clean and is building now. Scream if that's
>> not all of it ...
> 
> correct, that's the end of the scheduler patch-queue and it works fine
> if unapplied. (The schedstats patch i just sent applies cleanly to that
> base, in case you need one.)

OK, the perf of 2.6.8-rc2-mm2 with the new sched code backed out is exactly
the same as 2.6.8-rc2 ... ie it's definitely the new sched code that makes
the improvement.

M.

