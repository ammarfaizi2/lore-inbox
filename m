Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbUDGXXY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 19:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbUDGXXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 19:23:24 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:22659 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261263AbUDGXXW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 19:23:22 -0400
Date: Wed, 07 Apr 2004 16:34:51 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Ingo Molnar <mingo@elte.hu>, Eric Whiting <ewhiting@amis.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: -mmX 4G patches feedback [numbers: how much performance impact]
Message-ID: <33900000.1081380891@flay>
In-Reply-To: <20040407231806.GV26888@dualathlon.random>
References: <40718B2A.967D9467@amis.com> <20040405174616.GH2234@dualathlon.random> <4071D11B.1FEFD20A@amis.com> <20040405221641.GN2234@dualathlon.random> <20040406115539.GA31465@elte.hu> <20040406155925.GW2234@dualathlon.random> <20040406192549.GA14869@elte.hu> <12640000.1081378705@flay> <20040407230140.GT26888@dualathlon.random> <29510000.1081380104@flay> <20040407231806.GV26888@dualathlon.random>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Thursday, April 08, 2004 01:18:06 +0200 Andrea Arcangeli <andrea@suse.de> wrote:

> On Wed, Apr 07, 2004 at 04:21:44PM -0700, Martin J. Bligh wrote:
>> Speaking of which, pte_highmem is stinking expensive itself. There's
>> probably a large class of workloads that'd work with out pte_highmem
>> if we had 4/4 split (or shared pagetables. Grrr ;-))
> 
> hey, I can add a sysctl in 5 minutes to disable pte_highmem at runtime,
> why do you think it's expensive, it should be not, it's all atomic kmaps
> only doing invlpg. The few workloads trashing on the ptes manipulation
> needs pte_highmem anyways. If I thought it was expensive for any common
> load the sysctl would be already there.

I measured it - IIRC it was 5-10% on kernel compile ... and that was on a
high ratio NUMA which it should have made *better* (as with highmem, the
PTEs can be allocated node locally). I'll try to dig up the old profiles.

M.

