Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264185AbTEOTT2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 15:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264186AbTEOTT2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 15:19:28 -0400
Received: from franka.aracnet.com ([216.99.193.44]:6054 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S264185AbTEOTT1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 15:19:27 -0400
Date: Thu, 15 May 2003 10:17:43 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: William Lee Irwin III <wli@holomorphy.com>, Andi Kleen <ak@suse.de>
cc: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>, keith maanthey <kmannth@us.ibm.com>
Subject: Re: [PATCH] linux-2.5.69_subarch-fix_A0.patch
Message-ID: <246880000.1053019057@[10.10.2.4]>
In-Reply-To: <20030515191919.GR8978@holomorphy.com>
References: <1052966228.9630.69.camel@w-jstultz2.beaverton.ibm.com> <20030515065120.GA3469@Wotan.suse.de> <1053019259.9630.91.camel@w-jstultz2.beaverton.ibm.com> <20030515172855.GA10831@Wotan.suse.de> <1053020763.9629.104.camel@w-jstultz2.beaverton.ibm.com> <20030515190006.GA30173@Wotan.suse.de> <20030515191919.GR8978@holomorphy.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, May 15, 2003 at 10:46:03AM -0700, john stultz wrote:
>>> I'd agree (long term even more strongly), although along with that I'd
>>> like to be able to pick and choose my subarch. So I can have a kernel
>>> that supports say, PC and BigSMP, but not NUMAQ or whatever. I believe
>>> this is doable with your infrastructure, but I'm not sure how much work
>>> it will take. 
> 
> On Thu, May 15, 2003 at 09:00:06PM +0200, Andi Kleen wrote:
>> NUMAQ is not supported by the generic subarchitecture anyways.
>> The only supported architecturs by generic are pc, bigsmp, summit.
>> In theory you could subselect them, but it's only a few bytes for each
>> so it's probably not worth the effort. Technically it isn't a big issue,
>> you would just need to add it to Kconfig (not sure how to do that cleanly), 
>> the Makefile and the probe table.
> 
> Okay, will fix.

Will fix what? Nothing seems to be broken ...

If you mean putting NUMA-Q under generic subarch, please don't.
If you mean "selectable sub-bits of generic subarch" that seems utterly
pointless to me, the whole point of this is to get a single kernel
image for distros for all machines ...

M.
