Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbUDGXSK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 19:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261244AbUDGXSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 19:18:10 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:46784
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261236AbUDGXSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 19:18:08 -0400
Date: Thu, 8 Apr 2004 01:18:06 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Ingo Molnar <mingo@elte.hu>, Eric Whiting <ewhiting@amis.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: -mmX 4G patches feedback [numbers: how much performance impact]
Message-ID: <20040407231806.GV26888@dualathlon.random>
References: <40718B2A.967D9467@amis.com> <20040405174616.GH2234@dualathlon.random> <4071D11B.1FEFD20A@amis.com> <20040405221641.GN2234@dualathlon.random> <20040406115539.GA31465@elte.hu> <20040406155925.GW2234@dualathlon.random> <20040406192549.GA14869@elte.hu> <12640000.1081378705@flay> <20040407230140.GT26888@dualathlon.random> <29510000.1081380104@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29510000.1081380104@flay>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2004 at 04:21:44PM -0700, Martin J. Bligh wrote:
> Speaking of which, pte_highmem is stinking expensive itself. There's
> probably a large class of workloads that'd work with out pte_highmem
> if we had 4/4 split (or shared pagetables. Grrr ;-))

hey, I can add a sysctl in 5 minutes to disable pte_highmem at runtime,
why do you think it's expensive, it should be not, it's all atomic kmaps
only doing invlpg. The few workloads trashing on the ptes manipulation
needs pte_highmem anyways. If I thought it was expensive for any common
load the sysctl would be already there.
