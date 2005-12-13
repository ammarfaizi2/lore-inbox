Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750806AbVLMRhk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbVLMRhk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 12:37:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbVLMRhk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 12:37:40 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:2280 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750806AbVLMRhk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 12:37:40 -0500
Date: Tue, 13 Dec 2005 09:37:11 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Paul Jackson <pj@sgi.com>
cc: Andrew Morton <akpm@osdl.org>, dada1@cosmosbay.com,
       linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au,
       Simon.Derr@bull.net, ak@suse.de
Subject: Re: [PATCH] Cpuset: rcu optimization of page alloc hook
In-Reply-To: <20051213075345.c39f335d.pj@sgi.com>
Message-ID: <Pine.LNX.4.62.0512130936170.22803@schroedinger.engr.sgi.com>
References: <20051211233130.18000.2748.sendpatchset@jackhammer.engr.sgi.com>
 <439D39A8.1020806@cosmosbay.com> <20051212020211.1394bc17.pj@sgi.com>
 <20051212021247.388385da.akpm@osdl.org> <20051213075345.c39f335d.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Dec 2005, Paul Jackson wrote:

> So my intuition is:
>   If read alot but seldom written, mark "__read_mostly".
>   If seldom read or written, leave unmarked.

Correct.

>   1) I would -not- mark "struct kmem_cache *cpuset" __read_mostly, as it
>      is rarely accessed on -any- code path, much less a hot one.  It is
>      ideal cannon fodder.

Agree.

