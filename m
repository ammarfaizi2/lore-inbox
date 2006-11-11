Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946990AbWKKCvU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946990AbWKKCvU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 21:51:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946991AbWKKCvU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 21:51:20 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:38882 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1946990AbWKKCvT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 21:51:19 -0500
Date: Fri, 10 Nov 2006 18:51:10 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
cc: Ingo Molnar <mingo@elte.hu>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>, akpm@osdl.org,
       mm-commits@vger.kernel.org, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
Subject: RE: + sched-use-tasklet-to-call-balancing.patch added to -mm tree
In-Reply-To: <000701c70535$dc0d8e70$ff0da8c0@amr.corp.intel.com>
Message-ID: <Pine.LNX.4.64.0611101847050.28621@schroedinger.engr.sgi.com>
References: <000701c70535$dc0d8e70$ff0da8c0@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Nov 2006, Chen, Kenneth W wrote:

> So designate only one CPU within a domain to do load balance between groups
> for that specific sched domain should in theory fix the 2nd problem you
> identified.  Did you get a chance to look at the patch Suresh posted?

Yes, I am still thinking about how this would work. This would mean that 
the first cpu on a system would move busy processes to itself from all 
1023 other processes? That does not sound appealing.

Processes in the allnodes domain would move to processor #0. The next 
lower layer are the nodes groups. Not all of the groups at that layer 
contain processor #0. So we would never move processes into those sched 
domains?

