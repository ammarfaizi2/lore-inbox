Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932269AbWBFSWJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269AbWBFSWJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 13:22:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932270AbWBFSWJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 13:22:09 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:30433 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932269AbWBFSWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 13:22:08 -0500
Date: Mon, 6 Feb 2006 10:21:51 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andi Kleen <ak@suse.de>
cc: Paul Jackson <pj@sgi.com>, mingo@elte.hu, akpm@osdl.org, dgc@sgi.com,
       steiner@sgi.com, Simon.Derr@bull.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] cpuset memory spread basic implementation
In-Reply-To: <200602061811.49113.ak@suse.de>
Message-ID: <Pine.LNX.4.62.0602061017510.16829@schroedinger.engr.sgi.com>
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com>
 <20060206063549.d155c619.pj@sgi.com> <Pine.LNX.4.62.0602060839440.16337@schroedinger.engr.sgi.com>
 <200602061811.49113.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Feb 2006, Andi Kleen wrote:

> I still don't quite agree. As long as the latency penalty of going
> off node is not too bad (let's say < factor 2) i think it's better
> to spread out the caches than to always locate them locally.

AFAIK you can reach these low latency factors only if multiple nodes are 
on the same motherboard. Likely Opteron specific?

> If you have a much worse worst case NUMA factor it might be different,
> but even there it would be a good idea to at least spread it out
> to nearby nodes.

I dont understand you here. What would be the benefit of selecting more 
distant memory over local? I can only imagine that this would be 
beneficial if we know that the data would be used later by other 
processes.
