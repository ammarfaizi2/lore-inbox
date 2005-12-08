Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932383AbVLHVYJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932383AbVLHVYJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 16:24:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932398AbVLHVYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 16:24:08 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:14741 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932396AbVLHVYH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 16:24:07 -0500
Date: Thu, 8 Dec 2005 13:23:51 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andi Kleen <ak@suse.de>
cc: akpm@osdl.org, Christoph Hellwig <hch@infradead.org>,
       linux-ia64@vger.kernel.org, steiner@sgi.com,
       linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: Re: [PATCH 1/3] Zone reclaim V3: main patch
In-Reply-To: <20051208210850.GS11190@wotan.suse.de>
Message-ID: <Pine.LNX.4.62.0512081320200.30786@schroedinger.engr.sgi.com>
References: <20051208203707.30456.57439.sendpatchset@schroedinger.engr.sgi.com>
 <20051208210850.GS11190@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Dec 2005, Andi Kleen wrote:

> Sorry I made a mistake here earlier. On checking the ACPI spec
> again it's valid to have distances < 20 (e.g. for a 1.5 NUMA factor
> it would be legally 15) 

Saw that too.

> So better just check > LOCAL_DISTANCE, not >= 20.

For Altix 20 means that the other node is remote but in the same 
enclosure / motherboard. Latency is very low in these cases. I think in 
these small configurations it is better to go off node rather than using 
the reclaim logic.

Other small configurations may have the same issues.

RECLAIM_DISTANCE can be set per arch if the default is not okay.

> Also a lot of Opteron BIOS get that wrong, but I'm adding some
> sanity checking now so it should work in future.

Great!
