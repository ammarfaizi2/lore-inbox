Return-Path: <linux-kernel-owner+w=401wt.eu-S1750707AbXAET7o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbXAET7o (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 14:59:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750698AbXAET7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 14:59:43 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:36059 "EHLO
	mail.cs.helsinki.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1749667AbXAET7n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 14:59:43 -0500
References: <Pine.LNX.4.64.0701051345040.20220@sbz-30.cs.Helsinki.FI>
            <20070105115057.69d5ff11.akpm@osdl.org>
In-Reply-To: <20070105115057.69d5ff11.akpm@osdl.org>
From: "Pekka J Enberg" <penberg@cs.helsinki.fi>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, apw@shadowen.org, hch@lst.de,
       manfred@colorfullife.com, christoph@lameter.com, pj@sgi.com
Subject: Re: slab: cache alloc cleanups
Date: Fri, 05 Jan 2007 21:59:41 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="utf-8,iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <courier.459EAE2D.00003EE3@courier.cs.helsinki.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:
> Does this actually clean things up, or does it randomly move things around
> while carefully retaining existing obscurity?  Not sure..

Heh, the bulk of it is basically splitting the current __cache_alloc into 
separate UMA and NUMA paths via __do_cache_alloc so we don't have to play 
with NUMA_BUILD tricks. I also moved __cache_alloc_node in the same 
CONFIG_NUMA block as __cache_alloc while I was at it. 

                     Pekka 
