Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313571AbSIPHqB>; Mon, 16 Sep 2002 03:46:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313628AbSIPHqA>; Mon, 16 Sep 2002 03:46:00 -0400
Received: from holomorphy.com ([66.224.33.161]:12766 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S313571AbSIPHqA>;
	Mon, 16 Sep 2002 03:46:00 -0400
Date: Mon, 16 Sep 2002 00:46:02 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Daniel Phillips <phillips@arcor.de>
Cc: Andrew Morton <akpm@digeo.com>, Dave Hansen <haveblue@us.ibm.com>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] per-zone kswapd process
Message-ID: <20020916074602.GK3530@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Daniel Phillips <phillips@arcor.de>, Andrew Morton <akpm@digeo.com>,
	Dave Hansen <haveblue@us.ibm.com>,
	"Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <3D815C8C.4050000@us.ibm.com> <3D81643C.4C4E862C@digeo.com> <20020913045938.GG2179@holomorphy.com> <E17qogR-0000HR-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <E17qogR-0000HR-00@starship>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 12, 2002 at 09:06:20PM -0700, Andrew Morton wrote:
>>> I still don't see why it's per zone and not per node.  It seems strange
>>> that a wee little laptop would be running two kswapds?
>>> kswapd can get a ton of work done in the development VM and one per
>>> node would, I expect, suffice?

On Friday 13 September 2002 06:59, William Lee Irwin III wrote:
>> Machines without observable NUMA effects can benefit from it if it's
>> per-zone.

On Mon, Sep 16, 2002 at 07:44:30AM +0200, Daniel Phillips wrote:
> How?

The notion was that some level of parallelism would be bestowed on the
single-node case by using separate worker threads on a per-zone basis,
as they won't have more than one node to spawn worker threads for at all.

This notion apparently got shot down somewhere, and I don't care to rise
to its defense. I've lost enough debates this release to know better than
to try.


Bill
