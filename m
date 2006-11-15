Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030609AbWKOP4l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030609AbWKOP4l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 10:56:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030611AbWKOP4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 10:56:41 -0500
Received: from extu-mxob-1.symantec.com ([216.10.194.28]:42965 "EHLO
	extu-mxob-1.symantec.com") by vger.kernel.org with ESMTP
	id S1030609AbWKOP4k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 10:56:40 -0500
X-AuditID: 7f000001-a6acbbb000002674-bf-455b38b7e513 
Date: Wed, 15 Nov 2006 15:56:58 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: "Martin J. Bligh" <mbligh@mbligh.org>
cc: Andrew Morton <akpm@osdl.org>, Mel Gorman <mel@skynet.ie>,
       linux-kernel@vger.kernel.org
Subject: Re: Boot failure with ext2 and initrds
In-Reply-To: <455B330F.7050102@mbligh.org>
Message-ID: <Pine.LNX.4.64.0611151549130.18096@blonde.wat.veritas.com>
References: <20061114014125.dd315fff.akpm@osdl.org> <20061114184919.GA16020@skynet.ie>
 <Pine.LNX.4.64.0611141858210.11956@blonde.wat.veritas.com>
 <20061114113120.d4c22b02.akpm@osdl.org> <Pine.LNX.4.64.0611142111380.19259@blonde.wat.veritas.com>
 <Pine.LNX.4.64.0611151404260.11929@blonde.wat.veritas.com> <455B330F.7050102@mbligh.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 15 Nov 2006 15:56:39.0566 (UTC) FILETIME=[A31472E0:01C708CE]
X-Brightmail-Tracker: AAAAAA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2006, Martin J. Bligh wrote:
> Hugh Dickins wrote:
> > 
> > i386 and ppc64 still doing builds, but after an hour on x86_64,
> > an ld got stuck in a loop under ext2_try_to_allocate_with_rsv,
> > alternating between ext2_rsv_window_add and rsv_window_remove.
> 
> Ugh. What test are you doing? kernel compile in a tight loop forever?

That kind of thing, yes: my usual test, two repeated make -j20s of
a smallish kernel in 512MB RAM + 1or2GB swap, one in a tmpfs and
one in an ext2 backed by a looped tmpfs file.  (When things go
badly wrong, little harm befalls the hard disk.)

Hugh
