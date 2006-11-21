Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755492AbWKUXny@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755492AbWKUXny (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 18:43:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756867AbWKUXny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 18:43:54 -0500
Received: from calculon.skynet.ie ([193.1.99.88]:29610 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S1755492AbWKUXnx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 18:43:53 -0500
Date: Tue, 21 Nov 2006 23:43:51 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet.skynet.ie
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/11] Add __GFP_MOVABLE flag and update callers
In-Reply-To: <Pine.LNX.4.64.0611211529030.32283@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.64.0611212340480.11982@skynet.skynet.ie>
References: <20061121225022.11710.72178.sendpatchset@skynet.skynet.ie>
 <20061121225042.11710.15200.sendpatchset@skynet.skynet.ie>
 <Pine.LNX.4.64.0611211529030.32283@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2006, Christoph Lameter wrote:

> Are GFP_HIGHUSER allocations always movable? It would reduce the size of
> the patch if this would be added to GFP_HIGHUSER.
>

No, they aren't. Page tables allocated with HIGHPTE are currently not 
movable for example. A number of drivers (infiniband for example) also use 
__GFP_HIGHMEM that are not movable.

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
