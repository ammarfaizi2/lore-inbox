Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267388AbUHDTgj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267388AbUHDTgj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 15:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267398AbUHDTgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 15:36:38 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:51112 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267388AbUHDTe7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 15:34:59 -0400
Date: Wed, 04 Aug 2004 12:34:20 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>
cc: kernel@kolivas.org, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Rick Lindsley <ricklind@us.ibm.com>
Subject: Re: 2.6.8-rc2-mm2 performance improvements (scheduler?)
Message-ID: <211490000.1091648060@flay>
In-Reply-To: <20040804122414.4f8649df.akpm@osdl.org>
References: <6560000.1091632215@[10.10.2.4]><7480000.1091632378@[10.10.2.4]> <20040804122414.4f8649df.akpm@osdl.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Wednesday, August 04, 2004 12:24:14 -0700 Andrew Morton <akpm@osdl.org> wrote:

> "Martin J. Bligh" <mbligh@aracnet.com> wrote:
>> 
>> SDET 8  (see disclaimer)
>>                             Throughput    Std. Dev
>>                      2.6.7       100.0%         0.2%
>>                  2.6.8-rc2       100.2%         1.0%
>>              2.6.8-rc2-mm2       117.4%         0.9%
>> 
>>  SDET 16  (see disclaimer)
>>                             Throughput    Std. Dev
>>                      2.6.7       100.0%         0.3%
>>                  2.6.8-rc2        99.5%         0.3%
>>              2.6.8-rc2-mm2       118.5%         0.6%
> 
> hum, interesting.  Can Con's changes affect the inter-node and inter-cpu
> balancing decisions, or is this all due to caching effects, reduced context
> switching etc?
>
> I don't expect we'll be merging a new CPU scheduler into mainline any time
> soon, but we should work to understand where this improvement came from,
> and see if we can get the mainline scheduler to catch up.

Dunno ... really need to take schedstats profiles before and afterwards to
get a better picture what it's doing. Rick was working on a port.

M.

PS. schedstats is great for this kind of thing. Very useful, minimally 
invasive, no impact unless configed in, and nothing measurable even then.
Hint. Hint ;-)

