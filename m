Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932079AbVLHWvS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbVLHWvS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 17:51:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932694AbVLHWvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 17:51:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:34278 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932079AbVLHWvP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 17:51:15 -0500
Date: Thu, 8 Dec 2005 23:51:02 +0100
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: Andi Kleen <ak@suse.de>, akpm@osdl.org,
       Christoph Hellwig <hch@infradead.org>, linux-ia64@vger.kernel.org,
       steiner@sgi.com, linux-kernel@vger.kernel.org,
       Wu Fengguang <wfg@mail.ustc.edu.cn>, discuss@x86-64.org
Subject: Re: [PATCH 1/3] Zone reclaim V3: main patch
Message-ID: <20051208225102.GW11190@wotan.suse.de>
References: <20051208203707.30456.57439.sendpatchset@schroedinger.engr.sgi.com> <20051208210850.GS11190@wotan.suse.de> <Pine.LNX.4.62.0512081320200.30786@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0512081320200.30786@schroedinger.engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> For Altix 20 means that the other node is remote but in the same 
> enclosure / motherboard. Latency is very low in these cases. I think in 
> these small configurations it is better to go off node rather than using 
> the reclaim logic.

On Opterons the NUMA factors are usually < 2, more towards 1, but people
definitely note a difference between node and off node.
So I don't think that's a good heuristic. 

I would use > LOCAL_DISTANCE or perhaps if you really want
a new constant with value 12-15. 

> RECLAIM_DISTANCE can be set per arch if the default is not okay.

Well if anything it would be per system - perhaps need to make
it a boot option or somesuch later. 

-Andi
