Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261671AbUKOVFu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261671AbUKOVFu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 16:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261720AbUKOVFs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 16:05:48 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:2698 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261713AbUKOVE0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 16:04:26 -0500
Date: Mon, 15 Nov 2004 21:04:08 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] low discontig highmem_start_page
In-Reply-To: <13880000.1100551550@flay>
Message-ID: <Pine.LNX.4.44.0411152059370.4166-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Nov 2004, Martin J. Bligh wrote:
> --On Monday, November 15, 2004 20:37:28 +0000 Hugh Dickins <hugh@veritas.com> wrote:
> 
> > In the case of i386 CONFIG_DISCONTIGMEM CONFIG_HIGHMEM without highmem,
> > highmem_start_page was wrongly initialized (from a NULL zone_mem_map),
> > causing __change_page_attr to BUG on boot.
> 
> Thanks, I'm not suprised that was broken - I never test without highmem ;-)

Yes, I imagine it's a pretty odd combination: the tmpfs symlink mpol
screwup shows I wasn't testing NUMA enough, and I often lower my mem
with mem= to increase the pressure, so hit this.

Hugh

