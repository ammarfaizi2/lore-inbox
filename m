Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261722AbVAHAnF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261722AbVAHAnF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 19:43:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261725AbVAHAnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 19:43:05 -0500
Received: from colin2.muc.de ([193.149.48.15]:43281 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261727AbVAHAmf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 19:42:35 -0500
Date: 8 Jan 2005 01:42:34 +0100
Date: Sat, 8 Jan 2005 01:42:34 +0100
From: Andi Kleen <ak@muc.de>
To: YhLu <YhLu@tyan.com>
Cc: James Cleverdon <jamesclv@us.ibm.com>, Matt Domsch <Matt_Domsch@dell.com>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org,
       suresh.b.siddha@intel.com
Subject: Re: 256 apic id for amd64
Message-ID: <20050108004234.GB98595@muc.de>
References: <3174569B9743D511922F00A0C94314230729135E@TYANWEB>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3174569B9743D511922F00A0C94314230729135E@TYANWEB>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2005 at 04:50:43PM -0800, YhLu wrote:
> But the result looks ugly
> 
> I keep core0 and core1 of node0 to use 0/1 got
> 
> 4407.29 BogoMIPS (lpj=2203648)
> CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
> CPU: L2 Cache: 1024K (64 bytes/line)
> CPU 7 -> Node 3
> phy_proc_id[0] = 0

But that't BSP = 0, isn't it?
Where's the problem with that setup?

> phy_proc_id[1] = 0
> phy_proc_id[2] = 9
> phy_proc_id[3] = 9
> phy_proc_id[4] = 10
> phy_proc_id[5] = 10
> phy_proc_id[6] = 11
> phy_proc_id[7] = 11
> CPU: Physical Processor ID: 11
>  stepping 00
> Total of 8 processors activated (35209.21 BogoMIPS).
> If only keep core0/node0 to use 0.
> 
> Will get
> phy_proc_id[0] = 0
> phy_proc_id[1] = 8
> phy_proc_id[2] = 9
> phy_proc_id[3] = 9
> phy_proc_id[4] = 10
> phy_proc_id[5] = 10
> phy_proc_id[6] = 11
> phy_proc_id[7] = 11
> 
> it separate core0 and core1 of node 1

That's not supported yes. AMD docs specify core 0/1 are always 
consecutive in APIC space.

-Andi
