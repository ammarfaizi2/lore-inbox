Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319529AbSIMFoU>; Fri, 13 Sep 2002 01:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319532AbSIMFoU>; Fri, 13 Sep 2002 01:44:20 -0400
Received: from packet.digeo.com ([12.110.80.53]:4562 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S319529AbSIMFoT>;
	Fri, 13 Sep 2002 01:44:19 -0400
Message-ID: <3D817F94.4F4171FD@digeo.com>
Date: Thu, 12 Sep 2002 23:03:00 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: William Lee Irwin III <wli@holomorphy.com>,
       Dave Hansen <haveblue@us.ibm.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [PATCH] per-zone kswapd process
References: <3D817BC8.785F5C44@digeo.com> <619179322.1031870337@[10.10.2.3]>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Sep 2002 05:47:29.0776 (UTC) FILETIME=[0C2A1700:01C25AE9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" wrote:
> 
> ..
> Can we make a simple default of 1 per node, which is what 99%
> of people want, and then make it more complicated later if people
> complain? It's really pretty easy:
> 
> for (node = 0; node < numnodes; ++node) {
>         kswapd = kick_off_kswapd_for_node(node);
>         kswapd->cpus_allowed = node_to_cpus(node);
> }

Seems sane.
 
> Or whatever the current cpus_allowed method is. All we seem to need
> is node_to_cpus ... I can give that to you tommorow with no problem,
> it's trivial.

Tomorrow sounds too early - it'd be nice to get some before-n-after
performance testing to go along with that patch ;)
